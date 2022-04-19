/*
 * translator.cpp
 *
 *  Created on: 21-Feb-2019
 *      Author: Akash Banerjee
 */

#include "translator.h"
#include "symbol_util.h"
#include "scope_tree.h"

#include <fstream>

using namespace std;
using namespace llvm;
using namespace ll2gb;

symbol_tablet translator::symbol_table = symbol_tablet();
map<const Argument*, string> translator::func_arg_name_map = map<
		const Argument*, string>();
map<DIScope*, string> translator::scope_name_map = map<DIScope*, string>();
string translator::error_state = "";
map<translator::intrinsics, bool> translator::intrinsic_support_added = map<
		intrinsics, bool>();

/// If DebugInfo is present then return a
/// location specification.
source_locationt translator::get_location(const Instruction &I) {
	source_locationt location;
	if (I.getMetadata(0)) {
		const auto loc = I.getDebugLoc();
		location.set_file(loc->getScope()->getFile()->getFilename().str());
		location.set_working_directory(
				loc->getScope()->getFile()->getDirectory().str());
		location.set_line(loc->getLine());
		location.set_column(loc->getColumn());
		location.set_function(I.getFunction()->getName().str());
	}
	return location;
}

/// Translates and returns expressions for constant values.
exprt translator::get_expr_const(const Constant &C) {
	exprt expr;
	if (isa<ConstantAggregate>(C)) {
		if (isa<ConstantArray>(C)) {
			const auto &CA = cast<ConstantArray>(C);
			exprt list_expr;
			exprt::operandst operands;
			for (unsigned i = 0; i < CA.getNumOperands(); i++) {
				const auto &V = CA.getAggregateElement(i);
				operands.emplace_back(get_expr(*V));
			}
			if (C.getType()->isArrayTy())
				list_expr = array_exprt(operands,
						to_array_type(symbol_util::get_goto_type(C.getType())));
			else {
				auto type = symbol_util::get_goto_type(C.getType());
				if (type.id() == ID_struct_tag)
					type =
							symbol_table.lookup(
									to_struct_tag_type(type).get_identifier().c_str())->type;

				list_expr = struct_exprt(operands, to_struct_type(type));
			}
			expr = list_expr;
		} else if (isa<ConstantStruct>(C)) {
			const auto &CS = cast<ConstantStruct>(C);
			exprt::operandst expr_opnds;
			for (unsigned i = 0; i < CS.getNumOperands(); i++) {
				const auto &V = CS.getAggregateElement(i);
				expr_opnds.push_back(get_expr(*V));
			}
			if (C.getType()->isArrayTy())
				expr = array_exprt(expr_opnds,
						to_array_type(symbol_util::get_goto_type(C.getType())));
			else {
				auto type = symbol_util::get_goto_type(C.getType());
				expr = struct_exprt(expr_opnds, type);
			}
		} else if (isa<ConstantVector>(C)) {

		}
	} else if (isa<ConstantData>(C)) {
		if (isa<ConstantAggregateZero>(C)) {
			const auto &CAZ = cast<ConstantAggregateZero>(C);
			exprt::operandst list_operands;
			for (unsigned i = 0; i < CAZ.getNumElements(); i++) {
				const auto &V = CAZ.getAggregateElement(i);
				list_operands.push_back(get_expr(*V));
			}
			if (C.getType()->isArrayTy())
				expr = array_exprt(list_operands,
						to_array_type(symbol_util::get_goto_type(C.getType())));
			else {
				auto type = symbol_util::get_goto_type(C.getType());
				expr = struct_exprt(list_operands, type);
			}
		} else if (isa<ConstantDataSequential>(C)) {
			const auto &CDS = cast<ConstantDataSequential>(C);
			exprt list_expr;
			exprt::operandst operands;
			for (unsigned i = 0; i < CDS.getNumElements(); i++) {
				const auto &V = CDS.getAggregateElement(i);
				operands.emplace_back(get_expr(*V));
			}
			if (C.getType()->isArrayTy())
				list_expr = array_exprt(operands,
						to_array_type(symbol_util::get_goto_type(C.getType())));
			else
				list_expr = struct_exprt(operands,
						to_struct_type(
								symbol_util::get_goto_type(C.getType())));
			expr = list_expr;
		} else if (isa<ConstantFP>(C)) {
			auto &CF = cast<ConstantFP>(C);
			floatbv_typet type;
			if (CF.getType()->isFP128Ty()) {
				type = ieee_float_spect::quadruple_precision().to_type();
				auto val = CF.getValueAPF().convertToDouble();
				ieee_floatt ieee_fl(type);
				ieee_fl.from_double(val);
				expr = ieee_fl.to_expr();
			} else if (CF.getType()->isX86_FP80Ty()) {
				auto val = CF.getValueAPF().bitcastToAPInt();
				string exp, frac;
				if (val[79])
					frac += "-";
				for (auto i = 78; i > 63; i--) {
					if (val[i])
						exp += "1";
					else
						exp += "0";
				}
				for (auto i = 63; i >= 0; i--) {
					if (val[i])
						frac += "1";
					else
						frac += "0";
				}

				type = ieee_float_spect::x86_80().to_type();
				ieee_floatt ieee_fl(type);
				auto exp_int = string2integer(exp, 2);
				auto frac_int = string2integer(frac, 2);
				exp_int -= 16383;		///CBMC expects unbiased exponent
				exp_int -= 63;///CBMC adds spec.f later, this is to offset that.
				ieee_fl.build(frac_int, exp_int);
				if (CF.getValueAPF().isNaN())
					ieee_fl.make_NaN();
				else if (CF.getValueAPF().isZero())
					ieee_fl.make_zero();
				else if (CF.getValueAPF().isInfinity()
						&& CF.getValueAPF().isNegative())
					ieee_fl.make_minus_infinity();
				else if (CF.getValueAPF().isInfinity())
					ieee_fl.make_plus_infinity();

				expr = ieee_fl.to_expr();
			} else if (CF.getType()->isDoubleTy()) {
				type = ieee_float_spect::double_precision().to_type();
				auto val = CF.getValueAPF().convertToDouble();
				ieee_floatt ieee_fl(type);
				ieee_fl.from_double(val);
				expr = ieee_fl.to_expr();
			} else if (CF.getType()->isHalfTy()) {
				type = ieee_float_spect::half_precision().to_type();
				auto val = CF.getValueAPF().convertToFloat();
				ieee_floatt ieee_fl(type);
				ieee_fl.from_float(val);
				expr = ieee_fl.to_expr();
			} else if (CF.getType()->isFloatTy()) {
				type = ieee_float_spect::single_precision().to_type();
				auto val = CF.getValueAPF().convertToFloat();
				ieee_floatt ieee_fl(type);
				ieee_fl.from_float(val);
				expr = ieee_fl.to_expr();
			}
		} else if (isa<ConstantInt>(C)) {
			auto &CI = cast<ConstantInt>(C);
			auto val = CI.getSExtValue();
			if (CI.getType()->getIntegerBitWidth() == 1) {
				val = CI.getZExtValue();
			}
			expr = from_integer(val, symbol_util::get_goto_type(CI.getType()));
		} else if (isa<ConstantPointerNull>(C)) {
			expr = null_pointer_exprt(
					to_pointer_type(symbol_util::get_goto_type(C.getType())));
		} else if (isa<ConstantTokenNone>(C)) {
		} else if (isa<UndefValue>(C)) {
			auto symbol = symbol_util::create_symbol(C.getType());
			if (C.hasName()) {
				symbol.base_name = C.getName().str();
				symbol.name = string("ll2gb_undef_") + symbol.base_name.c_str();
			} else
				symbol.name = string("ll2gb_undef_") + symbol.name.c_str();
			if (symbol_table.add(symbol)) {
				error_state = "duplicate symbol names encountered!";
			}
			goto_program.add(goto_programt::make_decl(symbol.symbol_expr()));
			goto_program.update();
			expr = symbol.symbol_expr();
		}
	} else if (isa<ConstantExpr>(C)) {
		auto CI = &cast<ConstantExpr>(C);
		const auto &I = const_cast<ConstantExpr*>(CI)->getAsInstruction();
		expr = get_expr(*I);
		I->deleteValue();
	} else if (isa<GlobalValue>(C)) {
		const auto symbol = symbol_table.lookup(C.getName().str());
		expr = address_of_exprt(symbol->symbol_expr());
	}
	return expr;
}

/// Translates and returns a float comparission expr.
exprt translator::get_expr_fcmp(const FCmpInst &FCI) {
	exprt expr;
	const auto &ll_op1 = FCI.getOperand(0);
	const auto &ll_op2 = FCI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	switch (FCI.getPredicate()) {
	case CmpInst::Predicate::FCMP_FALSE: {
		expr = false_exprt();
		break;
	}
	case CmpInst::Predicate::FCMP_TRUE: {
		expr = true_exprt();
		break;
	}
	case CmpInst::Predicate::FCMP_OEQ: {
		expr = ternary_exprt(ID_if, isnan_exprt(expr_op1), false_exprt(),
				ternary_exprt(ID_if, isnan_exprt(expr_op2), false_exprt(),
						ieee_float_equal_exprt(expr_op1, expr_op2),
						bool_typet()), bool_typet());
		break;
	}
	case CmpInst::Predicate::FCMP_OGE: {
		expr = ternary_exprt(ID_if, isnan_exprt(expr_op1), false_exprt(),
				ternary_exprt(ID_if, isnan_exprt(expr_op2), false_exprt(),
						binary_relation_exprt(expr_op1, ID_ge, expr_op2),
						bool_typet()), bool_typet());
		break;
	}
	case CmpInst::Predicate::FCMP_OGT: {
		expr = ternary_exprt(ID_if, isnan_exprt(expr_op1), false_exprt(),
				ternary_exprt(ID_if, isnan_exprt(expr_op2), false_exprt(),
						binary_relation_exprt(expr_op1, ID_gt, expr_op2),
						bool_typet()), bool_typet());
		break;
	}
	case CmpInst::Predicate::FCMP_OLE: {
		expr = ternary_exprt(ID_if, isnan_exprt(expr_op1), false_exprt(),
				ternary_exprt(ID_if, isnan_exprt(expr_op2), false_exprt(),
						binary_relation_exprt(expr_op1, ID_le, expr_op2),
						bool_typet()), bool_typet());
		break;
	}
	case CmpInst::Predicate::FCMP_OLT: {
		expr = ternary_exprt(ID_if, isnan_exprt(expr_op1), false_exprt(),
				ternary_exprt(ID_if, isnan_exprt(expr_op2), false_exprt(),
						binary_relation_exprt(expr_op1, ID_lt, expr_op2),
						bool_typet()), bool_typet());
		break;
	}
	case CmpInst::Predicate::FCMP_ONE: {
		expr = ternary_exprt(ID_if, isnan_exprt(expr_op1), false_exprt(),
				ternary_exprt(ID_if, isnan_exprt(expr_op2), false_exprt(),
						ieee_float_notequal_exprt(expr_op1, expr_op2),
						bool_typet()), bool_typet());
		break;
	}
	case CmpInst::Predicate::FCMP_ORD: {
		expr = ternary_exprt(ID_if, isnan_exprt(expr_op1), false_exprt(),
				ternary_exprt(ID_if, isnan_exprt(expr_op2), false_exprt(),
						true_exprt(), bool_typet()), bool_typet());
		break;
	}
	case CmpInst::Predicate::FCMP_UEQ: {
		expr = ternary_exprt(ID_if, isnan_exprt(expr_op1), true_exprt(),
				ternary_exprt(ID_if, isnan_exprt(expr_op2), true_exprt(),
						ieee_float_equal_exprt(expr_op1, expr_op2),
						bool_typet()), bool_typet());
		break;
	}
	case CmpInst::Predicate::FCMP_UGE: {
		expr = ternary_exprt(ID_if, isnan_exprt(expr_op1), true_exprt(),
				ternary_exprt(ID_if, isnan_exprt(expr_op2), true_exprt(),
						binary_relation_exprt(expr_op1, ID_ge, expr_op2),
						bool_typet()), bool_typet());
		break;
	}
	case CmpInst::Predicate::FCMP_UGT: {
		expr = ternary_exprt(ID_if, isnan_exprt(expr_op1), true_exprt(),
				ternary_exprt(ID_if, isnan_exprt(expr_op2), true_exprt(),
						binary_relation_exprt(expr_op1, ID_gt, expr_op2),
						bool_typet()), bool_typet());
		break;
	}
	case CmpInst::Predicate::FCMP_ULE: {
		expr = ternary_exprt(ID_if, isnan_exprt(expr_op1), true_exprt(),
				ternary_exprt(ID_if, isnan_exprt(expr_op2), true_exprt(),
						binary_relation_exprt(expr_op1, ID_le, expr_op2),
						bool_typet()), bool_typet());
		break;
	}
	case CmpInst::Predicate::FCMP_ULT: {
		expr = ternary_exprt(ID_if, isnan_exprt(expr_op1), true_exprt(),
				ternary_exprt(ID_if, isnan_exprt(expr_op2), true_exprt(),
						binary_relation_exprt(expr_op1, ID_lt, expr_op2),
						bool_typet()), bool_typet());
		break;
	}
	case CmpInst::Predicate::FCMP_UNE: {
		expr = ternary_exprt(ID_if, isnan_exprt(expr_op1), true_exprt(),
				ternary_exprt(ID_if, isnan_exprt(expr_op2), true_exprt(),
						ieee_float_notequal_exprt(expr_op1, expr_op2),
						bool_typet()), bool_typet());
		break;
	}
	case CmpInst::Predicate::FCMP_UNO: {
		expr = ternary_exprt(ID_if, isnan_exprt(expr_op1), true_exprt(),
				isnan_exprt(expr_op2), bool_typet());
		break;
	}
	default:
		error_state = "Unknown FCmp Instr Predicate";
	}
	return expr;
}

/// Translates and returns an int comparission expr.
exprt translator::get_expr_icmp(const ICmpInst &ICI) {
	exprt expr;
	const auto &ll_op1 = ICI.getOperand(0);
	const auto &ll_op2 = ICI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	switch (ICI.getPredicate()) {
	case CmpInst::Predicate::ICMP_EQ: {
		expr = equal_exprt(expr_op1, expr_op2);
		break;
	}
	case CmpInst::Predicate::ICMP_NE: {
		expr = notequal_exprt(expr_op1, expr_op2);
		break;
	}
	case CmpInst::Predicate::ICMP_SGE: {
		expr = binary_relation_exprt(expr_op1, ID_ge, expr_op2);
		break;
	}
	case CmpInst::Predicate::ICMP_SGT: {
		expr = binary_relation_exprt(expr_op1, ID_gt, expr_op2);
		break;
	}
	case CmpInst::Predicate::ICMP_SLE: {
		expr = binary_relation_exprt(expr_op1, ID_le, expr_op2);
		break;
	}
	case CmpInst::Predicate::ICMP_SLT: {
		expr = binary_relation_exprt(expr_op1, ID_lt, expr_op2);
		break;
	}
	case CmpInst::Predicate::ICMP_UGE: { //TODO:Check if its correct to cast to unsigned like this
		expr_op1 = typecast_exprt::conditional_cast(expr_op1,
				unsignedbv_typet(
						ll_op1->getType()->isPointerTy() ?
								64 : ll_op1->getType()->getIntegerBitWidth()));
		expr_op2 = typecast_exprt::conditional_cast(expr_op2,
				unsignedbv_typet(
						ll_op2->getType()->isPointerTy() ?
								64 : ll_op2->getType()->getIntegerBitWidth()));
		expr = binary_relation_exprt(expr_op1, ID_ge, expr_op2);
		break;
	}
	case CmpInst::Predicate::ICMP_UGT: {
		expr_op1 = typecast_exprt::conditional_cast(expr_op1,
				unsignedbv_typet(
						ll_op1->getType()->isPointerTy() ?
								64 : ll_op1->getType()->getIntegerBitWidth()));
		expr_op2 = typecast_exprt::conditional_cast(expr_op2,
				unsignedbv_typet(
						ll_op2->getType()->isPointerTy() ?
								64 : ll_op2->getType()->getIntegerBitWidth()));
		expr = binary_relation_exprt(expr_op1, ID_gt, expr_op2);
		break;
	}
	case CmpInst::Predicate::ICMP_ULE: {
		expr_op1 = typecast_exprt::conditional_cast(expr_op1,
				unsignedbv_typet(
						ll_op1->getType()->isPointerTy() ?
								64 : ll_op1->getType()->getIntegerBitWidth()));
		expr_op2 = typecast_exprt::conditional_cast(expr_op2,
				unsignedbv_typet(
						ll_op2->getType()->isPointerTy() ?
								64 : ll_op2->getType()->getIntegerBitWidth()));
		expr = binary_relation_exprt(expr_op1, ID_le, expr_op2);
		break;
	}
	case CmpInst::Predicate::ICMP_ULT: {
		expr_op1 = typecast_exprt::conditional_cast(expr_op1,
				unsignedbv_typet(
						ll_op1->getType()->isPointerTy() ?
								64 : ll_op1->getType()->getIntegerBitWidth()));
		expr_op2 = typecast_exprt::conditional_cast(expr_op2,
				unsignedbv_typet(
						ll_op2->getType()->isPointerTy() ?
								64 : ll_op2->getType()->getIntegerBitWidth()));
		expr = binary_relation_exprt(expr_op1, ID_lt, expr_op2);
		break;
	}
	default:
		error_state = "Unknown ICmp Instr Predicate";
	}
	return expr;
}

/// Performs typcasting to truncate an expr and returns it.
exprt translator::get_expr_trunc(const TruncInst &TI) {
	exprt expr;
	const auto &ll_op1 = TI.getOperand(0);
	const auto &ll_op2 = TI.getDestTy();
	auto expr_op1 = get_expr(*ll_op1);
	expr = typecast_exprt(expr_op1, symbol_util::get_goto_type(ll_op2));
	return expr;
}

/// Translates and retrurns an add expr.
exprt translator::get_expr_add(const Instruction &AI) {
	exprt expr;
	const auto &ll_op1 = AI.getOperand(0);
	const auto &ll_op2 = AI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	expr = plus_exprt(expr_op1, expr_op2);
	return expr;
}

/// Translates and returns a iee_fl::div expr.
exprt translator::get_expr_fadd(const Instruction &FAI) {
	exprt expr;
	const auto &ll_op1 = FAI.getOperand(0);
	const auto &ll_op2 = FAI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	expr = ieee_float_op_exprt(expr_op1, ID_floatbv_plus, expr_op2,
			rounding_mode);
	return expr;
}

/// Translates and returns a sub expr;
exprt translator::get_expr_sub(const Instruction &SI) {
	exprt expr;
	const auto &ll_op1 = SI.getOperand(0);
	const auto &ll_op2 = SI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	expr = minus_exprt(expr_op1, expr_op2);
	return expr;
}

/// Translates and returns a iee_fl::div expr.
exprt translator::get_expr_fsub(const Instruction &FSI) {
	exprt expr;
	const auto &ll_op1 = FSI.getOperand(0);
	const auto &ll_op2 = FSI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	expr = ieee_float_op_exprt(expr_op1, ID_floatbv_minus, expr_op2,
			rounding_mode);
	return expr;
}

/// Translates and returns a mul expr.
exprt translator::get_expr_mul(const Instruction &MI) {
	exprt expr;
	const auto &ll_op1 = MI.getOperand(0);
	const auto &ll_op2 = MI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	expr = mult_exprt(expr_op1, expr_op2);
	return expr;
}

/// Translates and returns a iee_fl::div expr.
exprt translator::get_expr_fmul(const Instruction &FMI) {
	exprt expr;
	const auto &ll_op1 = FMI.getOperand(0);
	const auto &ll_op2 = FMI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	expr = ieee_float_op_exprt(expr_op1, ID_floatbv_mult, expr_op2,
			rounding_mode);
	return expr;
}

/// Translates and returns a div expr.
exprt translator::get_expr_sdiv(const Instruction &SDI) {
	exprt expr;
	const auto &ll_op1 = SDI.getOperand(0);
	const auto &ll_op2 = SDI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	expr = div_exprt(expr_op1, expr_op2);
	return expr;
}

/// Translates and returns a rem expr.
exprt translator::get_expr_srem(const Instruction &SRI) {
	exprt expr;
	const auto &ll_op1 = SRI.getOperand(0);
	const auto &ll_op2 = SRI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	expr = mod_exprt(expr_op1, expr_op2);
	return expr;
}

/// Translates and returns a iee_fl::div expr.
exprt translator::get_expr_fdiv(const Instruction &FDI) {
	exprt expr;
	const auto &ll_op1 = FDI.getOperand(0);
	const auto &ll_op2 = FDI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	expr = ieee_float_op_exprt(expr_op1, ID_floatbv_div, expr_op2,
			rounding_mode);
	return expr;
}

/// Translates and returns a div expr. Since it is
/// unsigned division, we must typecast both operands
/// to unsigned, perform the div, and then again
/// typecast back to signed.
exprt translator::get_expr_udiv(const Instruction &UDI) {
	exprt expr;
	const auto &ll_op1 = UDI.getOperand(0);
	const auto &ll_op2 = UDI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	expr_op1 = typecast_exprt::conditional_cast(expr_op1,
			unsignedbv_typet(
					ll_op1->getType()->isPointerTy() ?
							64 : ll_op1->getType()->getIntegerBitWidth()));
	expr_op2 = typecast_exprt::conditional_cast(expr_op2,
			unsignedbv_typet(
					ll_op2->getType()->isPointerTy() ?
							64 : ll_op2->getType()->getIntegerBitWidth()));
	expr = div_exprt(expr_op1, expr_op2);
	expr = typecast_exprt::conditional_cast(expr,
			signedbv_typet(ll_op1->getType()->getIntegerBitWidth()));
	return expr;
}

/// Translates and returns a rem expr. Since it is
/// unsigned division, we must typecast both operands
/// to unsigned, perform the rem, and then again
/// typecast back to signed.
exprt translator::get_expr_urem(const Instruction &URI) {
	exprt expr;
	const auto &ll_op1 = URI.getOperand(0);
	const auto &ll_op2 = URI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	expr_op1 = typecast_exprt::conditional_cast(expr_op1,
			unsignedbv_typet(
					ll_op1->getType()->isPointerTy() ?
							64 : ll_op1->getType()->getIntegerBitWidth()));
	expr_op2 = typecast_exprt::conditional_cast(expr_op2,
			unsignedbv_typet(
					ll_op2->getType()->isPointerTy() ?
							64 : ll_op2->getType()->getIntegerBitWidth()));
	expr = mod_exprt(expr_op1, expr_op2);
	expr = typecast_exprt::conditional_cast(expr,
			signedbv_typet(ll_op1->getType()->getIntegerBitWidth()));
	return expr;
}

/// Translates ANDInstr.
///	By using the infinity gauntlet.
exprt translator::get_expr_and(const Instruction &AI) {
	exprt expr;
	const auto &ll_op1 = AI.getOperand(0);
	const auto &ll_op2 = AI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	///CBMC ignores bitand of two bools so we use or instead.
	if (expr_op1.type().id() == ID_bool && expr_op2.type().id() == ID_bool)
		expr = and_exprt(expr_op1, expr_op2);
	else
		expr = bitand_exprt(expr_op1, expr_op2);
	return expr;
}

/// Translates ORInstr.
///	By using the Death Star.
exprt translator::get_expr_or(const Instruction &OI) {
	exprt expr;
	const auto &ll_op1 = OI.getOperand(0);
	const auto &ll_op2 = OI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	///CBMC ignores bitor of two bools so we use or instead.
	if (expr_op1.type().id() == ID_bool && expr_op2.type().id() == ID_bool)
		expr = or_exprt(expr_op1, expr_op2);
	else
		expr = bitor_exprt(expr_op1, expr_op2);
	return expr;
}

/// Translates XORInstr.
///	By using the one ring.
exprt translator::get_expr_xor(const Instruction &XI) {
	exprt expr;
	const auto &ll_op1 = XI.getOperand(0);
	const auto &ll_op2 = XI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	if (expr_op1.type().id() == ID_bool && expr_op2.type().id() == ID_bool)
		expr = xor_exprt(expr_op1, expr_op2);
	else
		expr = bitxor_exprt(expr_op1, expr_op2);
	return expr;
}

/// Translates ShiftLeftInstr.
///	By using the elder wand.
exprt translator::get_expr_shl(const Instruction &SLI) {
	exprt expr;
	const auto &ll_op1 = SLI.getOperand(0);
	const auto &ll_op2 = SLI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	expr = shl_exprt(expr_op1, expr_op2);
	return expr;
}

/// Translates LogicalShiftRightInstr.
///	By performing dark arts.
exprt translator::get_expr_lshr(const Instruction &LSRI) {
	exprt expr;
	const auto &ll_op1 = LSRI.getOperand(0);
	const auto &ll_op2 = LSRI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	expr = lshr_exprt(expr_op1, expr_op2);
	return expr;
}

/// Translates ArithShiftRightInstr.
///	By magic.
exprt translator::get_expr_ashr(const Instruction &ASRI) {
	exprt expr;
	const auto &ll_op1 = ASRI.getOperand(0);
	const auto &ll_op2 = ASRI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	expr = ashr_exprt(expr_op1, expr_op2);
	return expr;
}

/// Translates a BitCastInst. By
///	typecasting the address of the value,
///	followed by a derefernce.
///	Intuition:	(float)a != *(float*)&a
///	Here we want the latter.
exprt translator::get_expr_bitcast(const BitCastInst &BI) {
	exprt expr;
	const auto &ll_op1 = BI.getOperand(0);
	const auto &ll_op2 = BI.getDestTy();
	expr = get_expr(*ll_op1);
	if (expr.type().id() == ID_pointer || expr.type().id() == ID_array)
		expr = typecast_exprt(expr, symbol_util::get_goto_type(ll_op2));
	else {
		expr = get_expr(*ll_op1, true);
		expr = address_of_exprt(expr);
		expr = typecast_exprt(expr,
				pointer_type(symbol_util::get_goto_type(ll_op2)));
		expr = dereference_exprt(expr);
	}
	return expr;
}

/// Translates FPExtInst. By doing
///	a floatbv_typecast on it.
exprt translator::get_expr_fpext(const FPExtInst &FPEI) {
	exprt expr;
	const auto &ll_op1 = FPEI.getOperand(0);
	const auto &ll_op2 = FPEI.getDestTy();
	expr = get_expr(*ll_op1);
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	expr = floatbv_typecast_exprt(expr, rounding_mode,
			symbol_util::get_goto_type(ll_op2));
	return expr;
}

/// Translates FPToSIInst. By doing
///	a floatbv_typecast on it.
exprt translator::get_expr_fptosi(const FPToSIInst &FPTSI) {
	exprt expr;
	const auto &ll_op1 = FPTSI.getOperand(0);
	const auto &ll_op2 = FPTSI.getDestTy();
	expr = get_expr(*ll_op1);
	auto rounding_mode = from_integer(ieee_floatt::ROUND_TO_ZERO,
			signed_int_type());
	expr = floatbv_typecast_exprt(expr, rounding_mode,
			symbol_util::get_goto_type(ll_op2));
	return expr;
}

/// Translates SIToFPInst. By doing
///	a floatbv_typecast on it.
exprt translator::get_expr_sitofp(const SIToFPInst &SITFP) {
	exprt expr;
	const auto &ll_op1 = SITFP.getOperand(0);
	const auto &ll_op2 = SITFP.getDestTy();
	expr = get_expr(*ll_op1);
	if (expr.type().id() == ID_bool)
		expr = typecast_exprt(expr, signedbv_typet(32));
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	if (expr.type().id() == ID_bool)
		expr = typecast_exprt(expr, signedbv_typet(32));
	expr = floatbv_typecast_exprt(expr, rounding_mode,
			symbol_util::get_goto_type(ll_op2));
	return expr;
}

/// Translates FPToUIInst. By doing
///	a floatbv_typecast on it.
exprt translator::get_expr_fptoui(const FPToUIInst &FPTUI) {
	exprt expr;
	const auto &ll_op1 = FPTUI.getOperand(0);
	const auto &ll_op2 = FPTUI.getDestTy();
	expr = get_expr(*ll_op1);
	auto rounding_mode = from_integer(ieee_floatt::ROUND_TO_ZERO,
			signed_int_type());
	expr = typecast_exprt(
			floatbv_typecast_exprt(expr, rounding_mode,
					unsignedbv_typet(ll_op2->getIntegerBitWidth())),
			symbol_util::get_goto_type(ll_op2));
	return expr;
}

/// Translates UIToFPInst. By doing
///	a floatbv_typecast on it.
exprt translator::get_expr_uitofp(const UIToFPInst &UITFP) {
	exprt expr;
	const auto &ll_op1 = UITFP.getOperand(0);
	const auto &ll_op2 = UITFP.getDestTy();
	expr = get_expr(*ll_op1);
	if (expr.type().id() == ID_bool)
		expr = typecast_exprt(expr, unsignedbv_typet(32));
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	if (expr.type().id() == ID_bool)
		expr = typecast_exprt(expr, unsignedbv_typet(32));
	expr = floatbv_typecast_exprt(expr, rounding_mode,
			symbol_util::get_goto_type(ll_op2));
	return expr;
}

/// Translates FPTruncInst. By doing
///	a floatbv_typecast on it.
exprt translator::get_expr_fptrunc(const FPTruncInst &FPTI) {
	exprt expr;
	const auto &ll_op1 = FPTI.getOperand(0);
	const auto &ll_op2 = FPTI.getDestTy();
	expr = get_expr(*ll_op1);
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	expr = floatbv_typecast_exprt(expr, rounding_mode,
			symbol_util::get_goto_type(ll_op2));
	return expr;
}

/// Translates FNegInst. By doing
///	a bitwise xor with 1<<bit_width.
exprt translator::get_expr_fneg(const Instruction &I) {
	exprt expr;
	const auto &ll_op1 = I.getOperand(0);
	expr = get_expr(*ll_op1);
	auto bit_width = to_bitvector_type(expr.type()).get_width();
	if (bit_width > 64)
		error_state = "Floating Point width >64 not supported in FNegInst";
	auto flip_sign = from_integer(1llu << (bit_width - 1),
			signedbv_typet(bit_width));
	expr = bitxor_exprt(expr, flip_sign);
	return expr;
}

/// Translates PtrToIntInst. By simply,
///	typecasting it.
exprt translator::get_expr_ptrtoint(const PtrToIntInst &P2I) {
	exprt expr;
	const auto &ll_op1 = P2I.getOperand(0);
	const auto &ll_op2 = P2I.getDestTy();
	expr = get_expr(*ll_op1);
	expr = typecast_exprt(expr, symbol_util::get_goto_type(ll_op2));
	return expr;
}

/// Translates IntToPtrInst. By simply,
///	typecasting it.
exprt translator::get_expr_inttoptr(const IntToPtrInst &I2P) {
	exprt expr;
	const auto &ll_op1 = I2P.getOperand(0);
	const auto &ll_op2 = I2P.getDestTy();
	expr = get_expr(*ll_op1);
	expr = typecast_exprt(expr, symbol_util::get_goto_type(ll_op2));
	return expr;
}

/// Translates SelectInst. This is equivalent
/// to a ternary operator.
exprt translator::get_expr_select(const SelectInst &SI) {
	exprt expr;
	const auto &ll_op1 = SI.getOperand(0);
	const auto &ll_op2 = SI.getOperand(1);
	const auto &ll_op3 = SI.getOperand(2);
	auto cond_expr = get_expr(*ll_op1);
	auto op1_expr = get_expr(*ll_op2);
	auto op2_expr = get_expr(*ll_op3);
	expr = ternary_exprt(ID_if, cond_expr, op1_expr, op2_expr, op1_expr.type());
	return expr;
}

/// Translates and returns a sign extended integer.
/// Sign extension is dont by a simple typecast.
exprt translator::get_expr_sext(const SExtInst &SI) {
	exprt expr;
	const auto &ll_op1 = SI.getOperand(0);
	const auto &ll_op2 = SI.getDestTy();
	expr = get_expr(*ll_op1);
	///If it's a i1 llvm value, then because of 2's complement
	///representation true and false are -1 & 0 instead of 1 & 0.
	///The following if block takes care of this scenario.
	if (SI.getOperand(0)->getType()->getIntegerBitWidth() == 1) {
		expr = ternary_exprt(ID_if,
				equal_exprt(expr, from_integer(0, expr.type())),
				from_integer(0, symbol_util::get_goto_type(ll_op2)),
				from_integer(-1, symbol_util::get_goto_type(ll_op2)),
				symbol_util::get_goto_type(ll_op2));
	} else
		expr = typecast_exprt(expr, symbol_util::get_goto_type(ll_op2));
	return expr;
}

/// This performs zero extension on an exprt. By
/// doing a usual signed extension followed by
/// a bitwise and with a number whose MSBs are
/// set to 0 and LSBs are set to 1. MSBs here are
/// the newly added bits, and LSBs are the old bits,
/// eg, to extend i32 x to i64, we do
/// i64 val = ((signed long)x) & 0x0000000011111111.
exprt translator::get_expr_zext(const ZExtInst &ZI) {
	exprt expr;
	const auto &ll_op1 = ZI.getOperand(0);
	const auto &ll_op2 = ZI.getDestTy();
	expr = get_expr(*ll_op1);
	expr = typecast_exprt(expr, symbol_util::get_goto_type(ll_op2));
	unsigned long long zext_and = 1u;
	zext_and <<= ll_op1->getType()->getIntegerBitWidth();
	zext_and--;
	auto zext_expr = from_integer(zext_and,
			signedbv_typet(ll_op2->getIntegerBitWidth()));
	expr = bitand_exprt(expr, zext_expr);
	return expr;
}

/// Translates load instruction. By returning
///	the derefernce value, intuitively the first,
///	load to any value should not be dereferenced
///	since all values are pointers in llvm, which is
///	not the case in GOTO. But skipping the first
///	load introduces when a value was read, before,
///	a preceding load on it, this is essentially,
///	reading the address of the value, hence,
/// we always dereference on a load and instead,
///	all value producing instructions must return
///	the address to ther value instead.
exprt translator::get_expr_load(const LoadInst &LI) {
	exprt expr;
	const auto &ll_op1 = LI.getOperand(0);
	expr = dereference_exprt(get_expr(*ll_op1));
	return expr;
}

/// Translates ExtractValueInst. By returning
///	the value at the appropriate index of the array.
exprt translator::get_expr_extractvalue(const ExtractValueInst &EVI) {
	exprt expr;
	const auto &ll_op1 = EVI.getOperand(0);
	expr = get_expr(*ll_op1);
	auto indices = EVI.getIndices();
	for (auto i = 0u, n = EVI.getNumIndices(); i < n; i++) {
		auto index = indices[i];
		auto index_expr = from_integer(index, index_type());
		if (expr.type().id() == ID_pointer)
			expr = dereference_exprt(plus_exprt(expr, index_expr));
		else if (expr.type().id() == ID_array)
			expr = index_exprt(expr, index_expr);
		else if (expr.type().id() == ID_struct
				|| expr.type().id() == ID_struct_tag) {
			const auto struct_t = to_struct_type(expr.type());
			auto component = struct_t.components().at(index);
			expr = member_exprt(expr, component);
		} else
			error_state =
					"Unexpected exprt type in: translator::get_expr_extractvalue";
	}
	return expr;
}

///	Translates GEP instructions.
///	This one of the most complicated
///	translations, take extra CAUTION
///	before changing it, or anything around it.
exprt translator::get_expr_gep(const GetElementPtrInst &GEPI) {
	exprt expr;
	const auto &ll_op1 = GEPI.getOperand(0);
	expr = get_expr(*ll_op1);
	for (auto i = 1u, n = GEPI.getNumOperands(); i < n; i++)
		if (expr.type().id() == ID_pointer)
			expr = dereference_exprt(
					plus_exprt(expr, get_expr(*GEPI.getOperand(i))));
		else if (expr.type().id() == ID_array)
			expr = index_exprt(expr, get_expr(*GEPI.getOperand(i)));
		else if (expr.type().id() == ID_struct
				|| expr.type().id() == ID_struct_tag) {
			auto index_operand = GEPI.getOperand(i);
			auto index = cast<ConstantInt>(index_operand)->getSExtValue();
			struct_typet struct_t;
			if (expr.type().id() == ID_struct_tag)
				struct_t =
						to_struct_type(
								symbol_table.lookup(
										to_struct_tag_type(expr.type()).get_identifier().c_str())->type);
			else
				struct_t = to_struct_type(expr.type());
			auto component = struct_t.components().at(index);
			expr = member_exprt(expr, component);
		} else
			error_state = "Unexpected exprt type in: translator::get_expr_gep";
	return expr;
}

///	Translates PHINodes. By modeling them as
///	ternary operators.
exprt translator::get_expr_phi(const PHINode &PI) {
	exprt expr;
	for (int i = PI.getNumOperands() - 1; i >= 0; i--) {
		auto BB = PI.getIncomingBlock(i);
		auto V = PI.getIncomingValue(i);
		if (auto terminator_inst = dyn_cast<BranchInst>(BB->getTerminator())) {
			if (!terminator_inst->isConditional()) {
				expr = get_expr(*V);
			} else {
				exprt cond;
				cond = get_expr(*terminator_inst->getOperand(0));
				exprt f;
				f = get_expr(*V);
				if (dyn_cast<BasicBlock>(terminator_inst->getOperand(1))
						== PI.getParent()) {
					expr = ternary_exprt(ID_if, cond, expr, f, bool_typet());
				} else {
					expr = ternary_exprt(ID_if, cond, f, expr, bool_typet());
				}
			}
		} else
			error_state =
					"Expected terminator of PHINode Incoming Block to be a BranchInst!";
	}
	return expr;
}

/// Translates and returns the equivalent expr
/// to represent an llvm Value.
exprt translator::get_expr(const Value &V, bool new_state_required) {
	exprt expr;
	if (save_state_values.find(&V) != save_state_values.end()) {
		new_state_required = true;
		if (state_map.find(&V) != state_map.end())
			return state_map[&V];
	}
	if (isa<Instruction>(V)) {
		const auto &I = cast<Instruction>(V);
		switch (I.getOpcode()) {
		case Instruction::Alloca: {
			auto symbol = symbol_table.lookup(var_name_map[&I]);
			expr = symbol->symbol_expr();
			if (!cast<AllocaInst>(&I)->isArrayAllocation())
				expr = address_of_exprt(expr);
			break;
		}
		case Instruction::Load: {
			const auto &LI = cast<LoadInst>(&I);
			expr = get_expr_load(*LI);
			break;
		}
		case Instruction::ExtractValue: {
			const auto &EVI = cast<ExtractValueInst>(&I);
			expr = get_expr_extractvalue(*EVI);
			break;
		}
		case Instruction::GetElementPtr: {
			const auto &GEPI = cast<GetElementPtrInst>(&I);
			expr = get_expr_gep(*GEPI);
			expr = address_of_exprt(expr);
			break;
		}
		case Instruction::PHI: {
			const auto &PN = cast<PHINode>(&I);
			expr = get_expr_phi(*PN);
			break;
		}
		case Instruction::ZExt: {
			const auto &ZI = cast<ZExtInst>(&I);
			expr = get_expr_zext(*ZI);
			break;
		}
		case Instruction::SExt: {
			const auto &SI = cast<SExtInst>(&I);
			expr = get_expr_sext(*SI);
			break;
		}
		case Instruction::FPExt: {
			const auto &FPEI = cast<FPExtInst>(&I);
			expr = get_expr_fpext(*FPEI);
			break;
		}
		case Instruction::FPToSI: {
			const auto &FPTSI = cast<FPToSIInst>(&I);
			expr = get_expr_fptosi(*FPTSI);
			break;
		}
		case Instruction::SIToFP: {
			const auto &SITFP = cast<SIToFPInst>(&I);
			expr = get_expr_sitofp(*SITFP);
			break;
		}
		case Instruction::FPToUI: {
			const auto &FPTUI = cast<FPToUIInst>(&I);
			expr = get_expr_fptoui(*FPTUI);
			break;
		}
		case Instruction::UIToFP: {
			const auto &UITFP = cast<UIToFPInst>(&I);
			expr = get_expr_uitofp(*UITFP);
			break;
		}
		case Instruction::FPTrunc: {
			const auto &FPTI = cast<FPTruncInst>(&I);
			expr = get_expr_fptrunc(*FPTI);
			break;
		}
		case Instruction::FNeg: {
//			const auto &FPTI = cast<FNegInst>(&I);
			expr = get_expr_fneg(I);
			break;
		}
		case Instruction::PtrToInt: {
			const auto &P2I = cast<PtrToIntInst>(&I);
			expr = get_expr_ptrtoint(*P2I);
			break;
		}
		case Instruction::IntToPtr: {
			const auto &I2P = cast<IntToPtrInst>(&I);
			expr = get_expr_inttoptr(*I2P);
			break;
		}
		case Instruction::Select: {
			const auto &SI = cast<SelectInst>(&I);
			expr = get_expr_select(*SI);
			break;
		}
		case Instruction::FAdd: {
			expr = get_expr_fadd(I);
			break;
		}
		case Instruction::Add: {
			expr = get_expr_add(I);
			break;
		}
		case Instruction::FSub: {
			expr = get_expr_fsub(I);
			break;
		}
		case Instruction::Sub: {
			expr = get_expr_sub(I);
			break;
		}
		case Instruction::FMul: {
			expr = get_expr_fmul(I);
			break;
		}
		case Instruction::Mul: {
			expr = get_expr_mul(I);
			break;
		}
		case Instruction::FDiv: {
			expr = get_expr_fdiv(I);
			break;
		}
		case Instruction::UDiv: {
			expr = get_expr_udiv(I);
			break;
		}
		case Instruction::URem: {
			expr = get_expr_urem(I);
			break;
		}
		case Instruction::SDiv: {
			expr = get_expr_sdiv(I);
			break;
		}
		case Instruction::SRem: {
			expr = get_expr_srem(I);
			break;
		}
		case Instruction::And: {
			expr = get_expr_and(I);
			break;
		}
		case Instruction::Or: {
			expr = get_expr_or(I);
			break;
		}
		case Instruction::Xor: {
			expr = get_expr_xor(I);
			break;
		}
		case Instruction::Shl: {
			expr = get_expr_shl(I);
			break;
		}
		case Instruction::LShr: {
			expr = get_expr_lshr(I);
			break;
		}
		case Instruction::AShr: {
			expr = get_expr_ashr(I);
			break;
		}
		case Instruction::Trunc: {
			const auto &TI = cast<TruncInst>(&I);
			expr = get_expr_trunc(*TI);
			break;
		}
		case Instruction::FCmp: {
			const auto &FCI = cast<FCmpInst>(&I);
			expr = get_expr_fcmp(*FCI);
			break;
		}
		case Instruction::ICmp: {
			const auto &ICI = cast<ICmpInst>(&I);
			expr = get_expr_icmp(*ICI);
			break;
		}
		case Instruction::BitCast: {
			const auto &BI = cast<BitCastInst>(&I);
			expr = get_expr_bitcast(*BI);
			break;
		}
		case Instruction::Call: {
			const auto &CI = cast<CallInst>(&I);
			expr = symbol_table.lookup(call_ret_sym_map[CI])->symbol_expr();
			break;
		}
		case Instruction::InsertValue: {
			const auto &IVI = cast<InsertValueInst>(&I);
			expr = ins_value_name_map[IVI];
			break;
		}
		default:
			error_state =
					"Unsupported llvm::Instruction in translator::get_expr";
		}
	} else if (isa<Constant>(V)) {
		const auto &C = cast<Constant>(V);
		expr = get_expr_const(C);
	} else if (isa<Argument>(V)) {
		const auto &A = cast<Argument>(V);
		auto symbol = symbol_table.lookup(func_arg_name_map[&A]);
		expr = symbol->symbol_expr();
	}

///Sometimes we would like to use address_of(&) on rvalues,
///this allows us to do that by assigning it to a new temp variable.
	if (new_state_required) {
		auto sym = symbol_util::create_symbol(expr.type());
		sym.name = string("ll2gb_state_") + sym.name.c_str();
		sym.base_name = string("ll2gb_state_") + sym.base_name.c_str();
		if (symbol_table.add(sym)) {
			error_state = "duplicate symbol names encountered!";
		}
		goto_program.add(
				goto_programt::make_assignment(sym.symbol_expr(), expr));
		goto_program.update();
		state_map[&V] = sym.symbol_expr();
		return sym.symbol_expr();
	}
	return expr;
}

/// Add a new symbol to the symbol_table. Naming is done
/// respecting the following precedence:
/// Debug_Name >> IR_Name >> var<x>, where x in var<x>
/// is a coutner from 1 set for each function.
void translator::trans_alloca(const AllocaInst &AI) {
	symbolt symbol;
	auto location = get_location(AI);
	if (AI.isArrayAllocation())
		symbol = symbol_util::create_symbol(
				array_typet(symbol_util::get_goto_type(AI.getAllocatedType()),
						get_expr(*AI.getArraySize())));
	else
		symbol = symbol_util::create_symbol(AI.getAllocatedType());

	if (alloca_dbg_map.find(&AI) != alloca_dbg_map.end()) {
		auto DI = alloca_dbg_map[&AI]->getVariable();
		if (!DI->getName().str().compare(""))
			goto L1;
		symbol.name =
				scope_name_map.find(
						dyn_cast<DILocalScope>(DI->getScope())->getNonLexicalBlockFileScope())->second
						+ "::" + DI->getName().str();
		symbol.base_name = DI->getName().str();
		symbol.location = location;
	} else {
		if (AI.hasName()) {
			symbol.base_name = AI.getName().str();
			symbol.name = AI.getFunction()->getName().str() + "::"
					+ symbol.base_name.c_str();
		} else
			L1: symbol.name = AI.getFunction()->getName().str() + "::"
					+ symbol.name.c_str();
	}
	auto &I = cast<Instruction>(AI);
	var_name_map[&I] = symbol.name.c_str();
	if (symbol_table.add(symbol)) {
		error_state = "duplicate symbol names encountered!";
	}
	goto_program.add(goto_programt::make_decl(symbol.symbol_expr(), location));
	if (AI.isArrayAllocation()) {
		auto aux_symbol = symbol_util::create_symbol(AI.getType());
		aux_symbol.name = aux_symbol.base_name = aux_symbol.pretty_name =
				string(symbol.base_name.c_str()) + "__alias";
		if (symbol_table.add(aux_symbol)) {
			error_state = "duplicate symbol names encountered!";
		}
		goto_program.add(
				goto_programt::make_assignment(
						code_assignt(aux_symbol.symbol_expr(),
								typecast_exprt::conditional_cast(
										address_of_exprt(
												index_exprt(
														symbol.symbol_expr(),
														from_integer(0,
																index_type()))),
										aux_symbol.type)), location));
		aux_name_map[aux_symbol.name.c_str()] = var_name_map[&I];
		var_name_map[&I] = aux_symbol.name.c_str();
	}
	goto_program.update();
}

/// This adds one or two skip instuctions. Since the target
/// BB may not have been translated yet, we add skips, and later
/// once the BB has been translated we will change the skips to
/// GOTO instructions.
void translator::trans_br(const BranchInst &BI) {
	auto location = get_location(BI);
	if (BI.isConditional()) {
		auto guard_expr = not_exprt(get_expr(*BI.getCondition()));
		auto cond_true = goto_program.add_instruction(GOTO);
		auto cond_false = goto_program.add_instruction(GOTO);
		br_instr_target_map[&BI] = pair<goto_programt::targett,
				goto_programt::targett>(cond_true, cond_false);
		cond_true->set_condition(guard_expr);
		cond_true->set_target(cond_false);
		cond_false->set_condition(true_exprt());
		cond_false->set_target(cond_true);
	} else {
		auto br_ins = goto_program.add_instruction(GOTO);
		br_instr_target_map[&BI] = pair<goto_programt::targett,
				goto_programt::targett>(br_ins, br_ins);
		br_ins->set_target(br_ins);
		br_ins->set_condition(true_exprt());
	}
	goto_program.update();
}

/// Translates and adds a function call instruction.
/// Special cases:
///		__assert_fail: add proper comments since they are available.
///		intrinsic: use trans_call_intrinsic to translate intrinsics.
///		function_ptr: these are translated in cbmc style, by adding if condtions.
///		assert: Instead of a function call, assert instruction must be added.
///		assume: Instead of a function call, assume instruction must be added.
void translator::trans_call(const CallInst &CI) {
	auto called_func = CI.getCalledFunction();
	auto location = get_location(CI);
	if (called_func) {
		if (called_func->isIntrinsic()) {		///LLVM Intrinsic Functions
			const auto &ICI = cast<IntrinsicInst>(CI);
			trans_call_llvm_intrinsic(ICI);
		} else if (!called_func->getName().str().compare("__assert_fail")) { ///__assert_fail is instrinsic assert of llvm which is equivalent to assert(fail && "Message").
			auto assert_inst = goto_program.add(
					goto_programt::make_assertion(false_exprt(), location));
			auto asrt_comment =
					cast<ConstantDataArray>(
							cast<ConstantExpr>(CI.getOperand(0))->getOperand(0)->getOperand(
									0))->getAsCString();
			auto file_name =
					cast<ConstantDataArray>(
							cast<ConstantExpr>(CI.getOperand(1))->getOperand(0)->getOperand(
									0))->getAsCString();
			auto func_name =
					cast<ConstantDataArray>(
							cast<ConstantExpr>(CI.getOperand(3))->getOperand(0)->getOperand(
									0))->getAsCString();
			auto line_no = cast<ConstantInt>(CI.getOperand(2))->getZExtValue();
			auto comment = file_name + ":" + to_string(line_no) + ": "
					+ func_name + ": " + asrt_comment;
			assert_inst->source_location_nonconst().set_comment(comment.str());
			goto_program.update();
		} else if (!called_func->getName().str().compare("reach_error")) { ///reach_error is the error definition for SV-COMP 20
			goto_program.add(
					goto_programt::make_assertion(false_exprt(), location));
			goto_program.update();
		} else if (!called_func->getName().str().compare("abort")) { ///abort in SV-COMP 20 should stop Verification at that point
			goto_program.add(
					goto_programt::make_assumption(false_exprt(), location));
			goto_program.update();
		} else if (called_func->isDeclaration())
			goto L1;
		else
			make_func_call(CI);
	} else {	/// These are functions whose semantics are unknown.
		L1: auto called_val = CI.getCalledOperand()->stripPointerCasts();
		if (is_assert_function(called_val->getName().str())) {
			exprt guard_expr;
			if (called_val->getName().str() == "assert_")//assert_ for Fortran is always pass by address, hence the implicit dereference.
				guard_expr = typecast_exprt(
						dereference_exprt(get_expr(*CI.getOperand(0))),
						bool_typet());
			else
				guard_expr = typecast_exprt(get_expr(*CI.getOperand(0)),
						bool_typet());
			auto assert_inst = goto_program.add(
					goto_programt::make_assertion(guard_expr, location));
			assert_inst->source_location_nonconst().set_comment(
					"assertion "
							+ from_expr(namespacet(symbol_table), "",
									guard_expr));
			goto_program.update();
		} else if (is_assert_fail_function(called_val->getName().str())) {
			goto_program.add(
					goto_programt::make_assertion(false_exprt(), location));
			goto_program.update();
		} else if (is_assume_function(called_val->getName().str())) {
			auto guard_expr = typecast_exprt(get_expr(*CI.getOperand(0)),
					bool_typet());
			goto_program.add(
					goto_programt::make_assumption(guard_expr, location));
			goto_program.update();
		} else if (is_intrinsic_function(called_val->getName().str())) {
			add_intrinsic_support(*called_func);///General Intrinsic functions, like fpclassify, fesetround, etc
			make_func_call(CI);
		} else {
			auto ll_func_type = cast<FunctionType>(
					called_val->getType()->getPointerElementType());
			auto func_type = symbol_util::get_goto_type(ll_func_type);
			std::set<const symbolt*> actual_symbols;
			std::set<code_function_callt> func_calls;
			if (!isa<Constant>(called_val))
				for (auto a : symbol_table)
					if (a.second.type == func_type
							&& std::string("main").compare(
									a.second.name.c_str())) {
						actual_symbols.insert(
								symbol_table.lookup(a.second.name));
					}
			symbolt ret_symbol;
			exprt lhs_expr;
			exprt call_func_expr;
			code_function_callt::argumentst call_arguments;
			if (!ll_func_type->getReturnType()->isVoidTy()) {
				ret_symbol = symbol_util::create_symbol(
						ll_func_type->getReturnType());
				if (CI.hasName()) {
					ret_symbol.base_name = CI.getName().str();
					ret_symbol.name = CI.getFunction()->getName().str() + "::"
							+ ret_symbol.base_name.c_str();
				} else
					ret_symbol.name = CI.getFunction()->getName().str() + "::"
							+ ret_symbol.name.c_str();
				ret_symbol.location = location;
				if (symbol_table.add(ret_symbol)) {
					error_state = "duplicate symbol names encountered!";
				}
				lhs_expr = ret_symbol.symbol_expr();
				call_ret_sym_map[&CI] = ret_symbol.name.c_str();
				goto_program.add(
						goto_programt::make_decl(
								code_declt(ret_symbol.symbol_expr()),
								location));
				goto_program.update();
			}
			for (auto func_sym : actual_symbols) {
				call_func_expr = func_sym->symbol_expr();
				for (const auto &arg : CI.args()) {
					const auto &arg_val = arg.get();
					call_arguments.push_back(get_expr(*arg_val));
				}
				func_calls.insert(
						code_function_callt(lhs_expr, call_func_expr,
								call_arguments));
			}
			std::vector<goto_programt::targett> cond_targets;
			std::vector<goto_programt::targett> func_targets;
			std::vector<goto_programt::targett> goto_end_targets;
			for (auto actual_func_call : func_calls) {
				goto_programt::targett temp = goto_program.add_instruction(
						GOTO);
				cond_targets.push_back(temp);
			}
			auto default_target = goto_program.add_instruction(GOTO);
			default_target->set_condition(true_exprt());
			for (auto actual_func_call : func_calls) {
				goto_programt::targett temp = goto_program.add_instruction(
						FUNCTION_CALL);
				func_targets.push_back(temp);
				goto_programt::targett temp2 = goto_program.add_instruction(
						GOTO);
				goto_end_targets.push_back(temp2);
			}
			if (!ll_func_type->getReturnType()->isVoidTy()) { ///We should add a new variable to capture the return value of the func.
				auto asgn_instr = goto_program.add(
						goto_programt::make_assignment(
								code_assignt(ret_symbol.symbol_expr(),
										side_effect_expr_nondett(
												ret_symbol.type, location)),
								location));
				default_target->set_target(asgn_instr);
			}
			goto_programt::targett end = goto_program.add(
					goto_programt::make_skip(location));
			if (ll_func_type->getReturnType()->isVoidTy())
				default_target->set_target(end);
			int i = 0;
			for (auto actual_func_call : func_calls) {
				auto func_expr = get_expr(*called_val);
				auto temp = goto_programt::make_function_call(actual_func_call);
				func_targets[i]->swap(temp);
				cond_targets[i]->set_target(func_targets[i]);
				cond_targets[i]->set_condition(
						equal_exprt(func_expr,
								address_of_exprt(actual_func_call.function())));
				goto_end_targets[i]->set_target(end);
				goto_end_targets[i]->set_condition(true_exprt());
				i++;
			}
		}
	}
}

void translator::make_func_call(const CallInst &CI) {
	auto location = get_location(CI);
	auto called_func = CI.getCalledFunction();
	auto called_val = CI.getCalledOperand()->stripPointerCasts();
	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	if (called_func)
		call_expr.function() =
				symbol_table.lookup(called_func->getName().str())->symbol_expr();
	else
		call_expr.function() =
				symbol_table.lookup(called_val->getName().str())->symbol_expr();
	for (const auto &arg : CI.args()) {
		const auto &arg_val = arg.get();
		call_expr.arguments().push_back(get_expr(*arg_val));
	}
	if (called_func ?
			!called_func->getReturnType()->isVoidTy() :
			get_intrinsic_return_type(called_val->getName().str()).id()
					!= ID_void) { /// We should add a new variable to capture the return value of the func.
		symbolt ret_symbol;
		if (called_func)
			ret_symbol = symbol_util::create_symbol(
					called_func->getReturnType());
		else
			ret_symbol = symbol_util::create_symbol(
					get_intrinsic_return_type(called_val->getName().str()));
		if (CI.hasName()) {
			ret_symbol.base_name = CI.getName().str();
			ret_symbol.name = CI.getFunction()->getName().str() + "::"
					+ ret_symbol.base_name.c_str();
		} else
			ret_symbol.name = CI.getFunction()->getName().str() + "::"
					+ ret_symbol.name.c_str();
		ret_symbol.location = location;
		if (symbol_table.add(ret_symbol)) {
			error_state = "duplicate symbol names encountered!";
		}
		call_expr.lhs() = ret_symbol.symbol_expr();
		call_ret_sym_map[&CI] = ret_symbol.name.c_str();
		goto_program.add(
				goto_programt::make_decl(ret_symbol.symbol_expr(), location));
		goto_program.update();
	}
	goto_program.add(goto_programt::make_function_call(call_expr, location));
}

/// Translates all the intrinsics of llvm.
/// dbg intrinsics are ignored
/// memcpy is implemented as an assignment.
void translator::trans_call_llvm_intrinsic(const IntrinsicInst &ICI) {
	auto location = get_location(ICI);
	switch (ICI.getIntrinsicID()) {
	case Intrinsic::assume: {
		const auto &cond = ICI.getArgOperand(0);
		auto guard_expr = typecast_exprt(get_expr(*cond), bool_typet());
		goto_program.add(goto_programt::make_assumption(guard_expr, location));
		goto_program.update();
		break;
	}
	case Intrinsic::memcpy: {
//		add_intrinsic_support("llvm.memcpy.p0i8.p0i8.i64");
//		make_func_call(ICI);
//		break;
		const auto &MCI = cast<MemCpyInst>(ICI);
		const auto &ll_target = MCI.getOperand(0);
		const auto &ll_source = MCI.getOperand(1);
		const auto &ll_len = MCI.getOperand(2);
		auto target_expr = (get_expr(*ll_target));
		auto source_expr = (get_expr(*ll_source));
		auto len_expr = (get_expr(*ll_len));

		auto symbol = symbol_util::create_symbol(
				array_typet(signedbv_typet(8), len_expr));
		if (ICI.hasName()) {
			symbol.base_name = ICI.getName().str();
			symbol.name = ICI.getFunction()->getName().str() + "::"
					+ symbol.base_name.c_str();
		} else
			symbol.name = ICI.getFunction()->getName().str() + "::"
					+ symbol.name.c_str();
		if (symbol_table.add(symbol)) {
			error_state = "duplicate symbol names encountered!";
		}
		auto new_arr = typecast_exprt(address_of_exprt(symbol.symbol_expr()),
				pointer_type(signedbv_typet(8)));

		goto_program.add(
				goto_programt::make_decl(code_declt(symbol.symbol_expr()),
						location));

		auto array_copy_code = codet(ID_array_copy);
		array_copy_code.operands().push_back(new_arr);
		array_copy_code.operands().push_back(source_expr);
		goto_program.add(goto_programt::make_other(array_copy_code, location));

		auto array_replace_code = codet(ID_array_copy);
		array_replace_code.operands().push_back(target_expr);
		array_replace_code.operands().push_back(new_arr);
		goto_program.add(
				goto_programt::make_other(array_replace_code, location));
		goto_program.update();
		break;
	}
	case Intrinsic::memset: {
		const auto &MSI = cast<MemSetInst>(ICI);
		const auto &ll_target = MSI.getOperand(0);
		const auto &ll_val = MSI.getOperand(1);
		const auto &ll_len = MSI.getOperand(2);
		auto target_expr = get_expr(*ll_target);
		auto val_expr = get_expr(*ll_val);
		auto len_expr = get_expr(*ll_len);

		auto symbol = symbol_util::create_symbol(
				array_typet(signedbv_typet(8), len_expr));
		if (ICI.hasName()) {
			symbol.base_name = ICI.getName().str();
			symbol.name = ICI.getFunction()->getName().str() + "::"
					+ symbol.base_name.c_str();
		} else
			symbol.name = ICI.getFunction()->getName().str() + "::"
					+ symbol.name.c_str();
		if (symbol_table.add(symbol)) {
			error_state = "duplicate symbol names encountered!";
		}
		auto new_arr = typecast_exprt(address_of_exprt(symbol.symbol_expr()),
				pointer_type(signedbv_typet(8)));

		goto_program.add(
				goto_programt::make_decl(code_declt(symbol.symbol_expr()),
						location));

		auto array_set_code = codet(ID_array_set);
		array_set_code.operands().push_back(new_arr);
		array_set_code.operands().push_back(val_expr);
		goto_program.add(goto_programt::make_other(array_set_code, location));

		auto array_replace_code = codet(ID_array_replace);
		array_replace_code.operands().push_back(target_expr);
		array_replace_code.operands().push_back(new_arr);
		goto_program.add(
				goto_programt::make_other(array_replace_code, location));
		goto_program.update();
		break;
	}
	case Intrinsic::ceil: {
		add_llvm_intrinsic_support("llvm.ceil.f64");
		make_func_call(ICI);
		break;
	}
	case Intrinsic::floor: {
		add_llvm_intrinsic_support("llvm.floor.f64");
		make_func_call(ICI);
		break;
	}
	case Intrinsic::round: {
		add_llvm_intrinsic_support("llvm.round.f64");
		make_func_call(ICI);
		break;
	}
	case Intrinsic::nearbyint: {
		add_llvm_intrinsic_support("llvm.nearbyint.f64");
		make_func_call(ICI);
		break;
	}
	case Intrinsic::rint: {
		add_llvm_intrinsic_support("llvm.rint.f64");
		make_func_call(ICI);
		break;
	}
	case Intrinsic::fabs: {
		add_llvm_intrinsic_support("llvm.fabs.f64");
		add_llvm_intrinsic_support("llvm.fabs.f32");
		add_llvm_intrinsic_support("llvm.fabs.f80");
		make_func_call(ICI);
		break;
	}
	case Intrinsic::copysign: {
		add_llvm_intrinsic_support("llvm.copysign.f64");
		make_func_call(ICI);
		break;
	}
	case Intrinsic::maxnum: {
		add_llvm_intrinsic_support("llvm.maxnum.f64");
		make_func_call(ICI);
		break;
	}
	case Intrinsic::minnum: {
		add_llvm_intrinsic_support("llvm.minnum.f64");
		make_func_call(ICI);
		break;
	}
	case Intrinsic::trunc: {
		add_llvm_intrinsic_support("llvm.trunc.f64");
		make_func_call(ICI);
		break;
	}
	case Intrinsic::trap: {
		goto_program.add(
				goto_programt::make_assumption(false_exprt(), location));
		goto_program.update();
		break;
	}
	case Intrinsic::stacksave: {
		auto called_func = ICI.getCalledFunction();
		auto ret_symbol = symbol_util::create_symbol(
				called_func->getReturnType());
		if (ICI.hasName()) {
			ret_symbol.base_name = ICI.getName().str();
			ret_symbol.name = ICI.getFunction()->getName().str() + "::"
					+ ret_symbol.base_name.c_str();
		} else
			ret_symbol.name = ICI.getFunction()->getName().str() + "::"
					+ ret_symbol.name.c_str();
		if (symbol_table.add(ret_symbol)) {
			error_state = "duplicate symbol names encountered!";
		}
		goto_program.add(
				goto_programt::make_assignment(ret_symbol.symbol_expr(),
						side_effect_expr_nondett(ret_symbol.type,
								source_locationt::nil())));
		goto_program.update();
		call_ret_sym_map[&ICI] = ret_symbol.name.c_str();
		break;
	}
	case Intrinsic::dbg_declare:
	case Intrinsic::dbg_value:
	case Intrinsic::dbg_label:
	case Intrinsic::stackrestore:
		break;
	default:
		error_state = "Unknown llvmIntrinsic type";
	}
}

/// Translates InsertValueInst.
///	This is modeled as an assignment to an array.
void translator::trans_insertvalue(const InsertValueInst &IVI) {
	const auto &ll_op1 = IVI.getOperand(0);
	const auto &ll_op2 = IVI.getOperand(1);
	auto tgt_expr = get_expr(*ll_op1);
	ins_value_name_map[&IVI] = tgt_expr;
	auto src_expr = get_expr(*ll_op2);
	auto indices = IVI.getIndices();
	for (auto i = 0u, n = IVI.getNumIndices(); i < n; i++) {
		auto index = indices[i];
		auto index_expr = from_integer(index, index_type());
		if (tgt_expr.type().id() == ID_pointer)
			tgt_expr = dereference_exprt(plus_exprt(tgt_expr, index_expr));
		else if (tgt_expr.type().id() == ID_array)
			tgt_expr = index_exprt(tgt_expr, index_expr);
		else if (tgt_expr.type().id() == ID_struct
				|| tgt_expr.type().id() == ID_struct_tag) {
			const auto struct_t = to_struct_type(tgt_expr.type());
			auto component = struct_t.components().at(index);
			tgt_expr = member_exprt(tgt_expr, component);
		} else
			error_state =
					"Unexpected exprt type in: translator::trans_insertvalue";
	}
	goto_program.add(
			goto_programt::make_assignment(code_assignt(tgt_expr, src_expr),
					get_location(IVI)));
	goto_program.update();
}

/// Translates and adds a return instr.
void translator::trans_ret(const ReturnInst &RI) {
	if (const auto &ll_op1 = RI.getReturnValue()) {
		auto ret_expr = get_expr(*ll_op1);
		goto_program.add(
				goto_programt::make_set_return_value(ret_expr,
						get_location(RI)));
	}

	/// Change these to GOTO END FUNCTION later, we don't use
	/// incomplete_goto instr anywhere else, hence we can convert,
	/// every incomplete_goto to goto END FUNCTION.
	goto_program.add(goto_programt::make_incomplete_goto());
	goto_program.update();
}

/// Translate and add an Assignment Instruction.
void translator::trans_store(const StoreInst &SI) {
	const auto &ll_op1 = SI.getOperand(0);
	const auto &ll_op2 = SI.getOperand(1);
	auto src_expr = get_expr(*ll_op1);
	auto tgt_expr = dereference_exprt(get_expr(*ll_op2));
	goto_program.add(
			goto_programt::make_assignment(tgt_expr, src_expr,
					get_location(SI)));
	goto_program.update();
}

/// Add skip instructions for each switch case + 1 for
/// the default/epilog case.
void translator::trans_switch(const SwitchInst &SI) {
	auto location = get_location(SI);
	auto i = SI.getNumCases();
	while (i--) {
		auto skip_instr = goto_program.add_instruction(GOTO);
		switch_instr_target_map[&SI].push_back(skip_instr);
	}
	auto skip_instr = goto_program.add_instruction(GOTO);
	switch_instr_target_map[&SI].push_back(skip_instr);
	goto_program.update();
}

/// We only translate instructions that resemble as
/// a state change, like store instructions, etc, else skip.
bool translator::trans_instruction(const Instruction &I) {
	switch (I.getOpcode()) {
	case Instruction::Ret: {
		const ReturnInst &RI = cast<ReturnInst>(I);
		trans_ret(RI);
		break;
	}
	case Instruction::Br: {
		const BranchInst &BI = cast<BranchInst>(I);
		trans_br(BI);
		break;
	}
	case Instruction::Alloca: {
		const AllocaInst &AI = cast<AllocaInst>(I);
		trans_alloca(AI);
		break;
	}
	case Instruction::Store: {
		const StoreInst &SI = cast<StoreInst>(I);
		trans_store(SI);
		break;
	}
	case Instruction::Call: {
		const CallInst &CI = cast<CallInst>(I);
		trans_call(CI);
		break;
	}
	case Instruction::Switch: {
		const SwitchInst &SI = cast<SwitchInst>(I);
		trans_switch(SI);
		break;
	}
	case Instruction::InsertValue: {
		const InsertValueInst &IVI = cast<InsertValueInst>(I);
		trans_insertvalue(IVI);
		break;
	}
	case Instruction::FAdd:
	case Instruction::FSub:
	case Instruction::FDiv:
	case Instruction::FMul:
	case Instruction::Add:
	case Instruction::Sub:
	case Instruction::Mul:
	case Instruction::UDiv:
	case Instruction::URem:
	case Instruction::SDiv:
	case Instruction::SRem:
	case Instruction::And:
	case Instruction::Or:
	case Instruction::Xor:
	case Instruction::AShr:
	case Instruction::LShr:
	case Instruction::Shl:
	case Instruction::Trunc:
	case Instruction::ZExt:
	case Instruction::SExt:
	case Instruction::Load:
	case Instruction::ICmp:
	case Instruction::FCmp:
	case Instruction::Unreachable:
	case Instruction::GetElementPtr:
	case Instruction::BitCast:
	case Instruction::PHI:
	case Instruction::PtrToInt:
	case Instruction::IntToPtr:
	case Instruction::FPExt:
	case Instruction::Select:
	case Instruction::FPToSI:
	case Instruction::SIToFP:
	case Instruction::FPToUI:
	case Instruction::UIToFP:
	case Instruction::ExtractValue:
	case Instruction::FPTrunc:
	case Instruction::FNeg:
		break;
	default:
		error_state = "Unknown llvmInstruction";
	}
	if (save_state_values.find(cast<Value>(&I)) != save_state_values.end())
		get_expr(cast<Value>(I));
	return check_state();
}

/// Calls trans_instruction for each I in BB
bool translator::trans_block(const BasicBlock &BB) {
	for (auto iter = BB.begin(), ie = BB.end(); iter != ie && !check_state();
			++iter) {
		auto &I = *iter;
		trans_instruction(I);
	}
	return check_state();
}

/// Once all BB haven been translated, we go back and
///	and replace the skip instructions we added earlier
///	br instructions into actual goto instructions.
void translator::set_branches() {
	for (auto br_inst_iter = br_instr_target_map.begin(), ie =
			br_instr_target_map.end(); br_inst_iter != ie; br_inst_iter++) {
		const auto &BI = br_inst_iter->first;
		if (BI->isConditional()) {
			auto true_target = block_target_map[BI->getSuccessor(0)];
			auto false_taget = block_target_map[BI->getSuccessor(1)];
//			br_inst_iter->second.first->make_goto(false_taget, guard_expr);
			br_inst_iter->second.first->set_target(false_taget);
			br_inst_iter->second.second->set_target(true_target);
		} else {
			goto_programt::targett target;
			target = block_target_map[BI->getSuccessor(0)];
			br_inst_iter->second.first->set_target(target);
		}
	}
	br_instr_target_map.clear();
}

/// Once all blocks have been translated
/// add the goto statements for each case.
void translator::set_switches() {
	for (auto sw_inst_iter = switch_instr_target_map.begin(), ie =
			switch_instr_target_map.end(); sw_inst_iter != ie; sw_inst_iter++) {
		auto SI = sw_inst_iter->first;
		auto select_expr = get_expr(*SI->getCondition());
		auto target_vector = sw_inst_iter->second;
		for (auto i = 1u, n = SI->getNumCases(); i <= n; i++) {
			auto guard_expr = equal_exprt(select_expr,
					get_expr(*SI->getOperand(i * 2)));
			auto target = block_target_map[SI->getSuccessor(i)];
			target_vector[i - 1]->set_target(target);
			target_vector[i - 1]->set_condition(guard_expr);
		}
		auto default_inst = target_vector.back();
		auto default_target = block_target_map[SI->getDefaultDest()];
		default_inst->set_target(default_target);
		default_inst->set_condition(true_exprt());
	}
	switch_instr_target_map.clear();
}

/// Once END FUNCTION has been realised,
/// add GOTO END FUNCTION after each return.
void translator::set_returns(goto_programt::targett &end_func) {
	for (auto &inst : goto_program.instructions)
		if (inst.is_incomplete_goto()) {
			auto temp = goto_programt::make_goto(end_func, true_exprt());
			inst.swap(temp);
		}
}

/// Translates and entire function and writes it
///to the 'goto_program'.
bool translator::trans_function(Function &F) {
	symbol_util::set_var_counter(F.arg_size() + 1);
	scope_tree st;
	scope_name_map.clear();
	st.get_scope_name_map(F, &scope_name_map);
	scope_name_map[nullptr] = "";
	for (const auto &BB : F) {
		auto target = goto_program.add(goto_programt::make_skip());
		block_target_map[&BB] = target;
		trans_block(BB);
		if (check_state())
			return true;
	}
	if (check_state())
		return true;
	auto end_func = goto_program.add_instruction(END_FUNCTION);
	set_branches();
	set_switches();
	set_returns(end_func);
	goto_program.update();
	remove_skip(goto_program);
	state_map.clear();

	if (verbose_very) {
		outs().changeColor(outs().BLUE, true);
		outs() << "Function: ";
		outs().resetColor();
		outs().changeColor(outs().SAVEDCOLOR, true);
		outs() << llvm_module->getName() << "::" << F.getName() << "\n";
		outs().changeColor(outs().YELLOW, true);
		outs() << "------------------------------------------------------\n";
		outs().resetColor();
		stringstream ss;
		goto_program.output(namespacet(symbol_table), "", ss);
		outs() << ss.str();
		outs().changeColor(outs().YELLOW, true);
		outs() << "------------------------------------------------------\n";
		outs().resetColor();
		outs().flush();
	}
	return check_state();
}

void translator::set_function_symbol_value(
		goto_functionst::function_mapt &function_map,
		symbol_tablet &symbol_table) {
	for (auto &func : function_map) {
		code_blockt cb;
		for (auto ins : func.second.body.instructions)
			cb.add(ins.get_code());
		auto &symbol = symbol_table.get_writeable_ref(func.first);
		symbol.value.swap(cb);
	}
}

void translator::set_entry_point(goto_functionst &goto_functions,
		symbol_tablet &symbol_table) {
	set_function_symbol_value(goto_functions.function_map, symbol_table);
	int argc = 0;
	const char **argv = nullptr;
	cbmc_parse_optionst parse_options(argc, argv);
	c_object_factory_parameterst object_factory_params;
	optionst options;
	parse_options.set_default_options(options);
	object_factory_params.set(options);
	ansi_c_languaget ansi_c;
	ansi_c.set_language_options(options);
	ansi_c.set_message_handler(msg_handler);
	ansi_c.generate_support_functions(symbol_table);
}

/// Translates and entire module and writes it
///	to the goto_functions.
bool translator::trans_module() {
	if (check_state())
		return true;
	for (auto F = llvm_module->getFunctionList().begin();
			F != llvm_module->getFunctionList().end() && !check_state(); F++) {
		if (F->isDeclaration()) {
			continue;
		}
		trans_function(*F);
		if (check_state())
			return true;
		const auto *fn = symbol_table.lookup(F->getName().str());
		goto_functions.function_map.find(F->getName().str())->second.body.swap(
				goto_program);
		goto_functions.function_map.find(F->getName().str())->second.set_parameter_identifiers(
				to_code_type(fn->type));
		goto_program.clear();
	}
	if (check_state())
		return true;
	remove_skip(goto_functions); ///Remove and unncecessary skip instructions that we might have added.
	goto_functions.update();

	config.set_from_symbol_table(symbol_table);
	config.main.emplace(string("main"));
	set_entry_point(goto_functions, symbol_table);
	return check_state();
}

void translator::collect_operands(const Instruction &I,
		set<const Value*> &operands) {
	if (isa<AllocaInst>(I))
		operands.insert(cast<Value>(&I));
	else {
		for (const auto &U : I.operands()) {
			if (isa<GlobalVariable>(U))
				operands.insert(cast<Value>(&U));
			else if (isa<Instruction>(U))
				collect_operands(*cast<Instruction>(U), operands);
		}
	}
}

/// Does some preliminary analysis. Things like
///	mapping alloca instructions to their DbgDeclare
///	happen here.
void translator::analyse_ir() {
	if (check_state())
		return;
	for (auto &F : *llvm_module)
		for (auto &BB : F)
			for (auto &I : BB) {
				if (isa<DbgDeclareInst>(&I)) {
					auto *CI = cast<CallInst>(&I);
					auto *M =
							cast<MetadataAsValue>(CI->getOperand(0))->getMetadata();
					if (isa<ValueAsMetadata>(M)) {
						auto *V = cast<ValueAsMetadata>(M)->getValue();
						if (isa<AllocaInst>(V)) {
							auto *AI = cast<AllocaInst>(V);
							alloca_dbg_map[AI] = cast<DbgDeclareInst>(CI);
						}
					}
				}
				///We always record a state for the following types
				///so no need to mark them explicitly.
				if (isa<StoreInst>(&I) || isa<AllocaInst>(&I)
						|| isa<BranchInst>(&I) || isa<ReturnInst>(&I)
						|| isa<CallInst>(&I) || isa<SwitchInst>(&I)
						|| isa<InsertValueInst>(&I))
					continue;
				set<const Value*> operands;
				collect_operands(I, operands);
				bool already_inserted = false;
				if (isa<LoadInst>(&I))
					for (const auto a : operands) {
						if (a->getType()->isAggregateType()
								|| (a->getType()->isPointerTy() ?
										a->getType()->getPointerElementType()->isPointerTy() :
										false)) {
							save_state_values.insert(&I);
							already_inserted = true;
							break;
						}
					}
				if (cast<Value>(&I)->getNumUses() < 2 || already_inserted)
					continue;
				set<const StoreInst*> in_btwn_instrs;
				for (const auto &U : I.uses()) {
					auto UI = dyn_cast<Instruction>(U.getUser());
					if (UI->getParent() == I.getParent()) {
						for (auto it = I.getIterator(); it != UI->getIterator();
								it++) {
							if (isa<StoreInst>(it))
								in_btwn_instrs.insert(cast<StoreInst>(&*it));
						}
					} else {
//						TODO: Add support for inter BasicBlock
					}
				}
				for (const auto &SI : in_btwn_instrs)
					if (operands.find(SI->getOperand(1)) != operands.end())
						save_state_values.insert(&I);
			}
}

/// This inserts all the function symbols to the
///	symbol table.
void translator::add_function_symbols() {
	for (Function &F : *llvm_module) {
		symbol_util::set_var_counter(1);
		if (F.isDeclaration()) {
			continue;
		}
		if (!F.getName().str().compare("MAIN_")) {
			F.setName("main");
		}
		if (!F.getName().str().compare("main") && F.arg_size() > 2) {
			error_state = "Expected main function to accept <= 2 arguments";
			return;
		}
		for (auto &arg : F.args()) {
			symbolt arg_symbol = symbol_util::create_symbol(arg.getType());
			if (check_state())
				return;
			arg_symbol.name = F.getName().str() + "::"
					+ arg_symbol.name.c_str();
			arg_symbol.is_parameter = true;
			arg_symbol.is_state_var = true;
			func_arg_name_map[&arg] = arg_symbol.name.c_str();
			if (symbol_table.add(arg_symbol)) {
				error_state = "duplicate symbol names encountered!";
			}
		}
		symbolt func_symbol = symbol_util::create_goto_func_symbol(F);
		if (symbol_table.add(func_symbol)) {
			error_state = "duplicate symbol names encountered!";
		}
		goto_functions.function_map[func_symbol.name] =
				goto_functionst::goto_functiont();
	}
}

/// This adds all the global symbols to
/// the symbol table.
void translator::add_global_symbols() {
	symbol_util::reset_var_counter();
	for (auto &G : llvm_module->globals()) {
		auto symbol = symbol_util::create_symbol(G.getValueType());
		if (check_state())
			return;
		if (G.hasName()) {
			symbol.base_name = G.getName().str();
			symbol.name = symbol.base_name.c_str();
			symbol.is_static_lifetime = true;
		} else {
			error_state = "Global does not have name";
			return;
		}
		symbol_table.add(symbol);
	}
	for (auto &G : llvm_module->globals()) {
		auto symbol = symbol_table.get_writeable(G.getName().str());
		if (G.getNumOperands() > 0)
			symbol->value = get_expr(*G.getOperand(0));
		symbol_table.move(*symbol, symbol);
	}
}

/// Returns false on successful
/// translation, true on failure.
/// Read 'error_state' for insights
/// on what caused the error.
bool translator::generate_goto() {
	if (verbose && !verbose_very) {
		outs().changeColor(raw_ostream::Colors::SAVEDCOLOR, true);
		outs() << "Generating GOTO Binary";
		outs().resetColor();
	}
	initialize_goto();
	add_function_symbols();
	add_global_symbols();
	analyse_ir();
	trans_module();
	if (verbose && !verbose_very) {
		outs() << "  [";
		if (check_state()) {
			outs().changeColor(raw_ostream::Colors::RED, true);
			outs() << "FAILED";
		} else {
			outs().changeColor(raw_ostream::Colors::GREEN, true);
			outs() << "OK";
		}
		outs().resetColor();
		outs() << "]\n";
	}
	return check_state();
}

/// This writes the goto_functions to a new file with name
///	<filename>
void translator::write_goto(const string &filename) {
	if (verbose) {
		outs().changeColor(outs().SAVEDCOLOR, true);
		outs() << "Writing GOTO Binary to: " << filename;
		outs().resetColor();
	}

	ofstream out(filename, ios::binary);
	if (write_goto_binary(out, symbol_table, goto_functions)) {
		if (!verbose) {
			outs().changeColor(outs().SAVEDCOLOR, true);
			outs() << "Writing GOTO Binary to: " << filename;
			outs().resetColor();
		}
		outs() << "  [";
		outs().changeColor(outs().RED, true);
		outs() << "FAILED";
		outs().resetColor();
		outs() << "]\n";
	} else if (verbose) {
		outs() << "  [";
		outs().changeColor(outs().GREEN, true);
		outs() << "OK";
		outs().resetColor();
		outs() << "]\n";
	}
}

/// Clears the symbol_util and
/// some other data_structures
/// to translate multiple irs at once.
translator::~translator() {
	symbol_table.clear();
	func_arg_name_map.clear();
	scope_name_map.clear();
	symbol_util::clear();
	error_state = "";
	intrinsic_support_added.clear();
}
