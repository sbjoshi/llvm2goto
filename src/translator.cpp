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

/// If DebugInfo is present then return a
/// location specification.
source_locationt translator::get_location(const Instruction &I) {
	source_locationt location;
	if (I.getMetadata(0)) {
		const auto loc = I.getDebugLoc();
		location.set_file(loc->getScope()->getFile()->getFilename().str());
		location.set_working_directory(loc->getScope()->getFile()->getDirectory().str());
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
			if (C.getType()->isArrayTy())
				list_expr =
						array_exprt(to_array_type(symbol_util::get_goto_type(C.getType())));
			else
				list_expr =
						struct_exprt(to_struct_type(symbol_util::get_goto_type(C.getType())));
			for (unsigned i = 0; i < CA.getNumOperands(); i++) {
				const auto &V = CA.getAggregateElement(i);
				list_expr.add_to_operands(get_expr(*V));
			}
			expr = list_expr;
		}
		else if (isa<ConstantStruct>(C)) {
			const auto &CS = cast<ConstantStruct>(C);
			exprt list_expr;
			if (C.getType()->isArrayTy())
				list_expr =
						array_exprt(to_array_type(symbol_util::get_goto_type(C.getType())));
			else
				list_expr =
						struct_exprt(to_struct_type(symbol_util::get_goto_type(C.getType())));
			for (unsigned i = 0; i < CS.getNumOperands(); i++) {
				const auto &V = CS.getAggregateElement(i);
				list_expr.add_to_operands(get_expr(*V));
			}
			expr = list_expr;
		}
		else if (isa<ConstantVector>(C)) {

		}
	}
	else if (isa<ConstantData>(C)) {
		if (isa<ConstantAggregateZero>(C)) {
			const auto &CAZ = cast<ConstantAggregateZero>(C);
			exprt list_expr;
			if (C.getType()->isArrayTy())
				list_expr =
						array_exprt(to_array_type(symbol_util::get_goto_type(C.getType())));
			else
				list_expr =
						struct_exprt(to_struct_type(symbol_util::get_goto_type(C.getType())));
			for (unsigned i = 0; i < CAZ.getNumElements(); i++) {
				const auto &V = CAZ.getAggregateElement(i);
				list_expr.add_to_operands(get_expr(*V));
			}
			expr = list_expr;
		}
		else if (isa<ConstantDataSequential>(C)) {
			const auto &CDS = cast<ConstantDataSequential>(C);
			exprt list_expr;
			if (C.getType()->isArrayTy())
				list_expr =
						array_exprt(to_array_type(symbol_util::get_goto_type(C.getType())));
			else
				list_expr =
						struct_exprt(to_struct_type(symbol_util::get_goto_type(C.getType())));
			for (unsigned i = 0; i < CDS.getNumElements(); i++) {
				const auto &V = CDS.getAggregateElement(i);
				list_expr.add_to_operands(get_expr(*V));
			}
			expr = list_expr;
		}
		else if (isa<ConstantFP>(C)) {
			auto &CF = cast<ConstantFP>(C);
			floatbv_typet type;
			if (CF.getType()->isFP128Ty()) {
				type = ieee_float_spect::quadruple_precision().to_type();
				auto val = CF.getValueAPF().convertToDouble();
				ieee_floatt ieee_fl(type);
				ieee_fl.from_double(val);
				expr = ieee_fl.to_expr();
			}
			else if (CF.getType()->isX86_FP80Ty()) {
				type = ieee_float_spect::x86_80().to_type();
				auto val = CF.getValueAPF().convertToDouble();
				ieee_floatt ieee_fl(type);
				ieee_fl.from_double(val);
				expr = ieee_fl.to_expr();
			}
			else if (CF.getType()->isDoubleTy()) {
				type = ieee_float_spect::double_precision().to_type();
				auto val = CF.getValueAPF().convertToDouble();
				ieee_floatt ieee_fl(type);
				ieee_fl.from_double(val);
				expr = ieee_fl.to_expr();
			}
			else if (CF.getType()->isHalfTy()) {
				type = ieee_float_spect::half_precision().to_type();
				auto val = CF.getValueAPF().convertToFloat();
				ieee_floatt ieee_fl(type);
				ieee_fl.from_float(val);
				expr = ieee_fl.to_expr();
			}
			else if (CF.getType()->isFloatTy()) {
				type = ieee_float_spect::single_precision().to_type();
				auto val = CF.getValueAPF().convertToFloat();
				ieee_floatt ieee_fl(type);
				ieee_fl.from_float(val);
				expr = ieee_fl.to_expr();
			}
		}
		else if (isa<ConstantInt>(C)) {
			auto &CI = cast<ConstantInt>(C);
			auto val = CI.getSExtValue();
			if (CI.getType()->getIntegerBitWidth() == 1) {
				val = CI.getZExtValue();
			}
			expr = from_integer(val, symbol_util::get_goto_type(CI.getType()));
		}
		else if (isa<ConstantPointerNull>(C)) {
			expr =
					null_pointer_exprt(to_pointer_type(symbol_util::get_goto_type(C.getType())));
		}
		else if (isa<ConstantTokenNone>(C)) {
		}
		else if (isa<UndefValue>(C)) {
			auto symbol = symbol_util::create_symbol(C.getType());
			symbol_table.add(symbol);
			auto dclr_instr = goto_program.add_instruction();
			dclr_instr->make_decl();
			dclr_instr->code = code_declt(symbol.symbol_expr());
			goto_program.update();
			expr = symbol.symbol_expr();
		}
	}
	else if (isa<ConstantExpr>(C)) {
		auto CI = &cast<ConstantExpr>(C);
		const auto &I = const_cast<ConstantExpr*>(CI)->getAsInstruction();
		expr = get_expr(*I);
		I->deleteValue();
	}
	else if (isa<GlobalValue>(C)) {
		const auto &symbol = symbol_table.lookup(C.getName().str());
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
		expr = ieee_float_equal_exprt(expr_op1, expr_op2);
		break;
	}
	case CmpInst::Predicate::FCMP_OGE: {
		expr = binary_relation_exprt(expr_op1, ID_ge, expr_op2);
		break;
	}
	case CmpInst::Predicate::FCMP_OGT: {
		expr = binary_relation_exprt(expr_op1, ID_gt, expr_op2);
		break;
	}
	case CmpInst::Predicate::FCMP_OLE: {
		expr = binary_relation_exprt(expr_op1, ID_le, expr_op2);
		break;
	}
	case CmpInst::Predicate::FCMP_OLT: {
		expr = binary_relation_exprt(expr_op1, ID_lt, expr_op2);
		break;
	}
	case CmpInst::Predicate::FCMP_ONE: {
		expr = ieee_float_notequal_exprt(expr_op1, expr_op2);
		break;
	}
	case CmpInst::Predicate::FCMP_ORD: {
		expr = true_exprt();
		break;
	}
	case CmpInst::Predicate::FCMP_UEQ: {
		expr = ieee_float_equal_exprt(expr_op1, expr_op2);
		break;
	}
	case CmpInst::Predicate::FCMP_UGE: {
		expr = binary_relation_exprt(expr_op1, ID_ge, expr_op2);
		break;
	}
	case CmpInst::Predicate::FCMP_UGT: {
		expr = binary_relation_exprt(expr_op1, ID_gt, expr_op2);
		break;
	}
	case CmpInst::Predicate::FCMP_ULE: {
		expr = binary_relation_exprt(expr_op1, ID_le, expr_op2);
		break;
	}
	case CmpInst::Predicate::FCMP_ULT: {
		expr = binary_relation_exprt(expr_op1, ID_lt, expr_op2);
		break;
	}
	case CmpInst::Predicate::FCMP_UNE: {
		expr = ieee_float_notequal_exprt(expr_op1, expr_op2);
		break;
	}
	case CmpInst::Predicate::FCMP_UNO: {
		expr = true_exprt();
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
	case CmpInst::Predicate::ICMP_UGE: {
		expr_op1 = typecast_exprt::conditional_cast(expr_op1,
				unsignedbv_typet(ll_op1->getType()->getIntegerBitWidth()));
		expr_op2 = typecast_exprt::conditional_cast(expr_op2,
				unsignedbv_typet(ll_op2->getType()->getIntegerBitWidth()));
		expr = binary_relation_exprt(expr_op1, ID_ge, expr_op2);
		break;
	}
	case CmpInst::Predicate::ICMP_UGT: {
		expr_op1 = typecast_exprt::conditional_cast(expr_op1,
				unsignedbv_typet(ll_op1->getType()->getIntegerBitWidth()));
		expr_op2 = typecast_exprt::conditional_cast(expr_op2,
				unsignedbv_typet(ll_op2->getType()->getIntegerBitWidth()));
		expr = binary_relation_exprt(expr_op1, ID_gt, expr_op2);
		break;
	}
	case CmpInst::Predicate::ICMP_ULE: {
		expr_op1 = typecast_exprt::conditional_cast(expr_op1,
				unsignedbv_typet(ll_op1->getType()->getIntegerBitWidth()));
		expr_op2 = typecast_exprt::conditional_cast(expr_op2,
				unsignedbv_typet(ll_op2->getType()->getIntegerBitWidth()));
		expr = binary_relation_exprt(expr_op1, ID_le, expr_op2);
		break;
	}
	case CmpInst::Predicate::ICMP_ULT: {
		expr_op1 = typecast_exprt::conditional_cast(expr_op1,
				unsignedbv_typet(ll_op1->getType()->getIntegerBitWidth()));
		expr_op2 = typecast_exprt::conditional_cast(expr_op2,
				unsignedbv_typet(ll_op2->getType()->getIntegerBitWidth()));
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
	expr = typecast_exprt(expr_op1,
			signedbv_typet(ll_op2->getIntegerBitWidth()));
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
			unsignedbv_typet(ll_op1->getType()->getIntegerBitWidth()));
	expr_op2 = typecast_exprt::conditional_cast(expr_op2,
			unsignedbv_typet(ll_op2->getType()->getIntegerBitWidth()));
	expr = div_exprt(expr_op1, expr_op2);
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
	if (expr.type().id() == ID_pointer)
		expr = typecast_exprt(expr, symbol_util::get_goto_type(ll_op2));
	else {
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
	expr = floatbv_typecast_exprt(expr,
			rounding_mode,
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
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	expr = floatbv_typecast_exprt(expr,
			rounding_mode,
			symbol_util::get_goto_type(ll_op2));
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
		}
		else
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
			expr = dereference_exprt(plus_exprt(expr,
					get_expr(*GEPI.getOperand(i))));
		else if (expr.type().id() == ID_array)
			expr = index_exprt(expr, get_expr(*GEPI.getOperand(i)));
		else if (expr.type().id() == ID_struct
				|| expr.type().id() == ID_struct_tag) {
			auto index_operand = GEPI.getOperand(i);
			auto index = cast<ConstantInt>(index_operand)->getSExtValue();
			const auto struct_t = to_struct_type(expr.type());
			auto component = struct_t.components().at(index);
			expr = member_exprt(expr, component);
		}
		else
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
			}
			else {
				exprt cond;
				cond = get_expr(*terminator_inst->getOperand(0));
				exprt f;
				f = get_expr(*V);
				if (dyn_cast<BasicBlock>(terminator_inst->getOperand(1))
						== PI.getParent()) {
					expr = ternary_exprt(ID_if, cond, expr, f, bool_typet());
				}
				else {
					expr = ternary_exprt(ID_if, cond, f, expr, bool_typet());
				}
			}
		}
		else
			error_state =
					"Expected terminator of PHINode Incoming Block to be a BranchInst!";
	}
	return expr;
}

/// Translates and returns the equivalent expr
/// to represent an llvm Value.
exprt translator::get_expr(const Value &V) {
	exprt expr;
	if (isa<Instruction>(V)) {
		const auto &I = cast<Instruction>(V);
		switch (I.getOpcode()) {
		case Instruction::Alloca: {
			auto symbol = symbol_table.lookup(var_name_map[&I]);
			expr = symbol->symbol_expr();
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
		case Instruction::FAdd:
		case Instruction::Add: {
			expr = get_expr_add(I);
			break;
		}
		case Instruction::FSub:
		case Instruction::Sub: {
			expr = get_expr_sub(I);
			break;
		}
		case Instruction::FMul:
		case Instruction::Mul: {
			expr = get_expr_mul(I);
			break;
		}
		case Instruction::FDiv:
		case Instruction::SDiv: {
			expr = get_expr_sdiv(I);
			break;
		}
		case Instruction::UDiv: {
			expr = get_expr_udiv(I);
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
	}
	else if (isa<Constant>(V)) {
		const auto &C = cast<Constant>(V);
		expr = get_expr_const(C);
	}
	else if (isa<Argument>(V)) {
		const auto &A = cast<Argument>(V);
		auto symbol = symbol_table.lookup(func_arg_name_map[&A]);
		expr = symbol->symbol_expr();
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
	symbol = symbol_util::create_symbol(AI.getAllocatedType());
	if (alloca_dbg_map.find(&AI) != alloca_dbg_map.end()) {
		auto DI = alloca_dbg_map[&AI]->getVariable();
		if (!DI->getName().str().compare("")) goto L1;
		symbol.name =
				scope_name_map.find(dyn_cast<DILocalScope>(DI->getScope())->getNonLexicalBlockFileScope())->second
						+ "::" + DI->getName().str();
		symbol.base_name = DI->getName().str();
		symbol.location = location;
	}
	else {
		if (AI.hasName()) {
			symbol.base_name = AI.getName().str();
			symbol.name = AI.getFunction()->getName().str() + "::"
					+ symbol.base_name.c_str();
		}
		else
			L1: symbol.name = AI.getFunction()->getName().str() + "::"
					+ symbol.name.c_str();
	}
	auto &I = cast<Instruction>(AI);
	var_name_map[&I] = symbol.name.c_str();
	symbol_table.add(symbol);
	auto dclr_instr = goto_program.add_instruction();
	dclr_instr->make_decl();
	dclr_instr->code = code_declt(symbol.symbol_expr());
	dclr_instr->source_location = location;
	goto_program.update();
}

/// This adds one or two skip instuctions. Since the target
/// BB may not have been translated yet, we add skips, and later
/// once the BB has been translated we will change the skips to
/// GOTO instructions.
void translator::trans_br(const BranchInst &BI) {
	auto location = get_location(BI);
	if (BI.isConditional()) {
		auto cond_true = goto_program.add_instruction();
		auto cond_false = goto_program.add_instruction();
		br_instr_target_map[&BI] = pair<goto_programt::targett,
				goto_programt::targett>(cond_true, cond_false);
		cond_true->source_location = location;
		cond_false->source_location = location;
	}
	else {
		auto br_ins = goto_program.add_instruction();
		br_instr_target_map[&BI] = pair<goto_programt::targett,
				goto_programt::targett>(br_ins, br_ins);
		br_ins->source_location = location;
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
		if (called_func->isIntrinsic()) {
			const auto &ICI = cast<IntrinsicInst>(CI);
			trans_call_intrinsic(ICI);
		}
		else if (!called_func->getName().str().compare("__assert_fail")) { ///__assert_fail is instrinsic assert of llvm which is equivalent to assert(fail && "Message").
			auto assert_instr = goto_program.add_instruction();
			auto asrt_comment =
					cast<ConstantDataArray>(cast<ConstantExpr>(CI.getOperand(0))->getOperand(0)->getOperand(0))->getAsCString();
			auto file_name =
					cast<ConstantDataArray>(cast<ConstantExpr>(CI.getOperand(1))->getOperand(0)->getOperand(0))->getAsCString();
			auto func_name =
					cast<ConstantDataArray>(cast<ConstantExpr>(CI.getOperand(3))->getOperand(0)->getOperand(0))->getAsCString();
			auto line_no = cast<ConstantInt>(CI.getOperand(2))->getZExtValue();
			auto comment = file_name + ":" + to_string(line_no) + ": "
					+ func_name + ": " + asrt_comment;
			assert_instr->make_assertion(false_exprt());
			assert_instr->source_location = location;
			assert_instr->source_location.set_comment(comment.str());
			goto_program.update();
		}
		else if (is_assert_function(called_func->getName().str())) {
			auto assert_inst = goto_program.add_instruction();
			auto guard_expr = typecast_exprt(get_expr(*CI.getOperand(0)),
					bool_typet());
			assert_inst->make_assertion(guard_expr);
			assert_inst->source_location = location;
			goto_program.update();
		}
		else if (is_assert_fail_function(called_func->getName().str())) {
			auto assert_inst = goto_program.add_instruction();
			assert_inst->make_assertion(false_exprt());
			assert_inst->source_location = location;
			goto_program.update();
		}
		else if (called_func->isDeclaration())
			goto L1;
		else {
			code_function_callt call_expr;
			call_expr.function() =
					symbol_table.lookup(called_func->getName().str())->symbol_expr();
			for (const auto &arg : CI.args()) {
				const auto &arg_val = arg.get();
				call_expr.arguments().push_back(get_expr(*arg_val));
			}
			if (!called_func->getReturnType()->isVoidTy()) { /// We should add a new variable to capture the return value of the func.
				auto ret_symbol =
						symbol_util::create_symbol(called_func->getReturnType());
				if (CI.hasName()) {
					ret_symbol.base_name = CI.getName().str();
					ret_symbol.name = CI.getFunction()->getName().str() + "::"
							+ ret_symbol.base_name.c_str();
				}
				else
					ret_symbol.name = CI.getFunction()->getName().str() + "::"
							+ ret_symbol.name.c_str();
				ret_symbol.location = location;
				symbol_table.add(ret_symbol);
				call_expr.lhs() = ret_symbol.symbol_expr();
				call_ret_sym_map[&CI] = ret_symbol.name.c_str();
				auto dclr_instr = goto_program.add_instruction();
				dclr_instr->make_decl();
				dclr_instr->code = code_declt(ret_symbol.symbol_expr());
				dclr_instr->source_location = location;
				goto_program.update();
			}
			auto call_instr = goto_program.add_instruction();
			call_instr->make_function_call(call_expr);
			call_instr->source_location = location;
		}
	}
	else {	/// These are functions whose semantics are unknown.
		L1: auto called_val = CI.getCalledValue()->stripPointerCasts();
		if (is_assert_function(called_val->getName().str())) {
			auto assert_inst = goto_program.add_instruction();
			auto guard_expr = typecast_exprt(get_expr(*CI.getOperand(0)),
					bool_typet());
			assert_inst->make_assertion(guard_expr);
			assert_inst->source_location = location;
			goto_program.update();
		}
		else if (is_assume_function(called_val->getName().str())) {
			auto assert_inst = goto_program.add_instruction();
			auto guard_expr = typecast_exprt(get_expr(*CI.getOperand(0)),
					bool_typet());
			assert_inst->make_assumption(guard_expr);
			assert_inst->source_location = location;
			goto_program.update();
		}
		else if (!called_val->getName().str().compare("malloc")) {
			add_malloc_support();
			code_function_callt call_expr;
			call_expr.function() = symbol_table.lookup("malloc")->symbol_expr();
			for (const auto &arg : CI.args()) {
				const auto &arg_val = arg.get();
				call_expr.arguments().push_back(get_expr(*arg_val));
			}
			auto ret_symbol =
					symbol_util::create_symbol(called_func->getReturnType());
			if (CI.hasName()) {
				ret_symbol.base_name = CI.getName().str();
				ret_symbol.name = CI.getFunction()->getName().str() + "::"
						+ ret_symbol.base_name.c_str();
			}
			else
				ret_symbol.name = CI.getFunction()->getName().str() + "::"
						+ ret_symbol.name.c_str();
			ret_symbol.location = location;
			symbol_table.add(ret_symbol);
			call_expr.lhs() = ret_symbol.symbol_expr();
			call_ret_sym_map[&CI] = ret_symbol.name.c_str();
			auto dclr_instr = goto_program.add_instruction();
			dclr_instr->make_decl();
			dclr_instr->code = code_declt(ret_symbol.symbol_expr());
			dclr_instr->source_location = location;
			goto_program.update();
			auto call_instr = goto_program.add_instruction();
			call_instr->make_function_call(call_expr);
			call_instr->source_location = location;
		}
		else {
			auto ll_func_type =
					cast<FunctionType>(called_val->getType()->getPointerElementType());
			auto func_type = symbol_util::get_goto_type(ll_func_type);
			std::set<const symbolt*> actual_symbols;
			std::set<code_function_callt> func_calls;
			if (!isa<Constant>(called_val))
				for (auto a : symbol_table)
					if (a.second.type == func_type
							&& std::string("main").compare(a.second.name.c_str())) {
						actual_symbols.insert(symbol_table.lookup(a.second.name));
					}
			code_typet func__code_type;
			symbolt ret_symbol;
			code_function_callt call_expr;
			if (!ll_func_type->getReturnType()->isVoidTy()) {
				ret_symbol =
						symbol_util::create_symbol(ll_func_type->getReturnType());
				if (CI.hasName()) {
					ret_symbol.base_name = CI.getName().str();
					ret_symbol.name = CI.getFunction()->getName().str() + "::"
							+ ret_symbol.base_name.c_str();
				}
				else
					ret_symbol.name = CI.getFunction()->getName().str() + "::"
							+ ret_symbol.name.c_str();
				ret_symbol.location = location;
				symbol_table.add(ret_symbol);
				call_expr.lhs() = ret_symbol.symbol_expr();
				call_ret_sym_map[&CI] = ret_symbol.name.c_str();
				auto dclr_instr = goto_program.add_instruction();
				dclr_instr->make_decl();
				dclr_instr->code = code_declt(ret_symbol.symbol_expr());
				dclr_instr->source_location = location;
				goto_program.update();
			}
			for (auto func_sym : actual_symbols) {
				call_expr.function() = func_sym->symbol_expr();
				for (const auto &arg : CI.args()) {
					const auto &arg_val = arg.get();
					call_expr.arguments().push_back(get_expr(*arg_val));
				}
				func_calls.insert(call_expr);
				call_expr.arguments().clear();
			}
			std::vector<goto_programt::targett> cond_targets;
			std::vector<goto_programt::targett> func_targets;
			std::vector<goto_programt::targett> goto_end_targets;
			for (auto actual_func_call : func_calls) {
				goto_programt::targett temp = goto_program.add_instruction();
				cond_targets.push_back(temp);
			}
			auto default_target = goto_program.add_instruction();
			for (auto actual_func_call : func_calls) {
				goto_programt::targett temp = goto_program.add_instruction();
				func_targets.push_back(temp);
				goto_programt::targett temp2 = goto_program.add_instruction();
				goto_end_targets.push_back(temp2);
			}
			if (!ll_func_type->getReturnType()->isVoidTy()) { ///We should add a new variable to capture the return value of the func.
				auto asgn_instr = goto_program.add_instruction();
				asgn_instr->make_assignment();
				asgn_instr->code = code_assignt(ret_symbol.symbol_expr(),
						side_effect_expr_nondett(ret_symbol.type, location));
				asgn_instr->source_location = location;
				default_target->make_goto(asgn_instr);
			}
			goto_programt::targett end = goto_program.add_instruction();
			end->make_skip();
			if (ll_func_type->getReturnType()->isVoidTy())
				default_target->make_goto(end);
			int i = 0;
			for (auto actual_func_call : func_calls) {
				auto func_expr = get_expr(*called_val);
				func_targets[i]->make_function_call(actual_func_call);
				cond_targets[i]->make_goto(func_targets[i],
						equal_exprt(func_expr,
								address_of_exprt(actual_func_call.function())));
				goto_end_targets[i]->make_goto(end);
				i++;
			}

		}
	}
}

/// Translates all the intrinsics of llvm.
/// dbg intrinsics are ignored
/// memcpy is implemented as an assignment.
void translator::trans_call_intrinsic(const IntrinsicInst &ICI) {
	auto location = get_location(ICI);
	switch (ICI.getIntrinsicID()) {
	case Intrinsic::memcpy: {
		const auto &x = cast<MemCpyInst>(ICI);
		const auto &ll_target = x.getDest();
		const auto &ll_source = cast<Constant>(x.getSource())->getOperand(0);
		auto target_expr = dereference_exprt(get_expr(*ll_target));
		auto source_expr = get_expr(*ll_source);
		auto assgn_instr = goto_program.add_instruction();
		assgn_instr->make_assignment();
		assgn_instr->code = code_assignt(target_expr, source_expr);
		assgn_instr->function = irep_idt(ICI.getFunction()->getName().str());
		assgn_instr->source_location = location;
		break;
	}
	case Intrinsic::dbg_declare:
	case Intrinsic::dbg_value:
	case Intrinsic::dbg_label:
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
		}
		else
			error_state =
					"Unexpected exprt type in: translator::trans_insertvalue";
	}
	auto asgn_instr = goto_program.add_instruction();
	asgn_instr->make_assignment();
	asgn_instr->code = code_assignt(tgt_expr, src_expr);
	asgn_instr->source_location = get_location(IVI);
	goto_program.update();
}

/// Translates and adds a return instr.
void translator::trans_ret(const ReturnInst &RI) {
	if (const auto &ll_op1 = RI.getReturnValue()) {
		auto ret_expr = get_expr(*ll_op1);
		goto_programt::targett ret_inst = goto_program.add_instruction();
		code_returnt cret;
		cret.return_value() = ret_expr;
		ret_inst->make_return();
		ret_inst->code = cret;
		ret_inst->source_location = get_location(RI);
		goto_program.update();
	}
}

/// Translate and add an Assignment Instruction.
void translator::trans_store(const StoreInst &SI) {
	const auto &ll_op1 = SI.getOperand(0);
	const auto &ll_op2 = SI.getOperand(1);
	auto src_expr = get_expr(*ll_op1);
	auto tgt_expr = dereference_exprt(get_expr(*ll_op2));
	auto asgn_instr = goto_program.add_instruction();
	asgn_instr->make_assignment();
	asgn_instr->code = code_assignt(tgt_expr, src_expr);
	asgn_instr->source_location = get_location(SI);
	goto_program.update();
}

/// Add skip instructions for each switch case + 1 for
/// the default/epilog case.
void translator::trans_switch(const SwitchInst &SI) {
	auto location = get_location(SI);
	auto i = SI.getNumCases();
	while (i--) {
		auto skip_instr = goto_program.add_instruction();
		skip_instr->make_skip();
		switch_instr_target_map[&SI].push_back(skip_instr);
	}
	auto skip_instr = goto_program.add_instruction();
	skip_instr->make_skip();
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
	case Instruction::SDiv:
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
	case Instruction::ExtractValue:
		break;
	default:
		error_state = "Unknown llvmInstruction";
	}
	return ll2gb_in_error();
}

/// Calls trans_instruction for each I in BB
bool translator::trans_block(const BasicBlock &BB) {
	for (auto iter = BB.begin(), ie = BB.end(); iter != ie && !ll2gb_in_error();
			++iter) {
		auto &I = *iter;
		trans_instruction(I);
	}
	return ll2gb_in_error();
}

/// Once all BB haven been translated, we go back and
///	and replace the skip instructions we added earlier
///	br instructions into actual goto instructions.
void translator::set_branches() {
	for (auto br_inst_iter = br_instr_target_map.begin(), ie =
			br_instr_target_map.end(); br_inst_iter != ie; br_inst_iter++) {
		const auto &BI = br_inst_iter->first;
		if (BI->isConditional()) {
			const auto &cond = BI->getCondition();
			auto guard_expr = not_exprt(get_expr(*cond));
			auto true_target = block_target_map[BI->getSuccessor(0)];
			auto false_taget = block_target_map[BI->getSuccessor(1)];
			br_inst_iter->second.first->make_goto(false_taget, guard_expr);
			br_inst_iter->second.second->make_goto(true_target, true_exprt());
		}
		else {
			goto_programt::targett then_part;
			then_part = block_target_map[BI->getSuccessor(0)];
			br_inst_iter->second.first->make_goto(then_part, true_exprt());
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
			target_vector[i - 1]->make_goto(target, guard_expr);
		}
		auto default_inst = target_vector.back();
		auto default_target = block_target_map[SI->getDefaultDest()];
		default_inst->make_goto(default_target, true_exprt());
	}
	switch_instr_target_map.clear();
}

/// Moves new symbol to symbol.
void translator::move_symbol(symbolt &symbol, symbolt *&new_symbol) {
	symbol.mode = ID_C;
	if (symbol_table.move(symbol, new_symbol)) {
		error_state = "Move symbol failed in translator::move_symbol";
	}
}

/// Taken from cbmc code base to transform
/// the argc and argv symbols of main function.
void translator::add_argc_argv(const symbolt &main_symbol) {
	const code_typet::parameterst &parameters =
			to_code_type(main_symbol.type).parameters();

	if (parameters.empty()) return;

	if (parameters.size() != 2 && parameters.size() != 3) {
		error_state =
				"Expected main function to have no or two or three parameters";
		return;
	}

	symbolt *argc_new_symbol;

	const exprt &op0 = static_cast<const exprt&>(parameters[0]);
	const exprt &op1 = static_cast<const exprt&>(parameters[1]);

	{
		symbolt argc_symbol;

		argc_symbol.base_name = "argc";
		argc_symbol.name = "argc'";
		argc_symbol.type = op0.type();
		argc_symbol.is_static_lifetime = true;
		argc_symbol.is_lvalue = true;

		if (argc_symbol.type.id() != ID_signedbv
				&& argc_symbol.type.id() != ID_unsignedbv) {
			error_state = "argc argument expected to be integer type";
			return;
		}

		move_symbol(argc_symbol, argc_new_symbol);
	}

	{
		if (op1.type().id() != ID_pointer
				|| op1.type().subtype().id() != ID_pointer) {
			error_state =
					"argv argument expected to be pointer-to-pointer type";
			return;
		}

		/// we make the type of this thing an array of pointers
		/// need to add one to the size -- the array is terminated
		/// with NULL
		exprt one_expr = from_integer(1, argc_new_symbol->type);

		const plus_exprt size_expr(argc_new_symbol->symbol_expr(), one_expr);
		const array_typet argv_type(op1.type().subtype(), size_expr);

		symbolt argv_symbol;

		argv_symbol.base_name = "argv'";
		argv_symbol.name = "argv'";
		argv_symbol.type = argv_type;
		argv_symbol.is_static_lifetime = true;
		argv_symbol.is_lvalue = true;

		symbolt *argv_new_symbol;
		move_symbol(argv_symbol, argv_new_symbol);
	}

	if (parameters.size() == 3) {
		symbolt envp_symbol;
		envp_symbol.base_name = "envp'";
		envp_symbol.name = "envp'";
		envp_symbol.type = (static_cast<const exprt&>(parameters[2])).type();
		envp_symbol.is_static_lifetime = true;

		symbolt envp_size_symbol, *envp_new_size_symbol;
		envp_size_symbol.base_name = "envp_size";
		envp_size_symbol.name = "envp_size'";
		envp_size_symbol.type = op0.type();  // same type as argc!
		envp_size_symbol.is_static_lifetime = true;
		move_symbol(envp_size_symbol, envp_new_size_symbol);

		if (envp_symbol.type.id() != ID_pointer) {
			error_state = "envp argument expected to be pointer type";
			return;
		}

		exprt size_expr = envp_new_size_symbol->symbol_expr();

		envp_symbol.type.id(ID_array);
		envp_symbol.type.add(ID_size).swap(size_expr);

		symbolt *envp_new_symbol;
		move_symbol(envp_symbol, envp_new_symbol);
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
		auto target = goto_program.add_instruction();
		target->make_skip();
		block_target_map[&BB] = target;
		trans_block(BB);
		if (ll2gb_in_error()) return true;
	}
	if (ll2gb_in_error()) return true;
	goto_program.add_instruction(END_FUNCTION);
	set_branches();
	set_switches();
	goto_program.update();
	remove_skip(goto_program);

	if (verbose >= 10) {
		outs().changeColor(outs().BLUE, true);
		outs() << "Function: ";
		outs().resetColor();
		outs().changeColor(outs().SAVEDCOLOR, true);
		outs() << llvm_module->getName() << "::" << F.getName() << "\n";
		outs().changeColor(outs().YELLOW, true);
		outs() << "------------------------------------------------------\n";
		outs().resetColor();
		stringstream ss;
		goto_program.output(ss);
		outs() << ss.str();
		outs().changeColor(outs().YELLOW, true);
		outs() << "------------------------------------------------------\n";
		outs().resetColor();
		outs().flush();
	}
	return ll2gb_in_error();
}

/// Translates and entire module and writes it
///	to the goto_functions.
bool translator::trans_module() {
	for (auto F = llvm_module->getFunctionList().begin();
			F != llvm_module->getFunctionList().end() && !ll2gb_in_error();
			F++) {
		if (F->isDeclaration()) {
			continue;
		}
		trans_function(*F);
		if (ll2gb_in_error()) return true;
		const auto *fn = symbol_table.lookup(F->getName().str());
		goto_functions.function_map.find(F->getName().str())->second.body.swap(goto_program);
		(*goto_functions.function_map.find(F->getName().str())).second.type =
				to_code_type(fn->type);
		goto_program.clear();
	}
	if (ll2gb_in_error()) return true;
	const auto &main_func = symbol_table.lookup("main");
	if (main_func) add_argc_argv(*main_func); ///Takes care of the argc and argv arguments for main.

	remove_skip(goto_functions); ///Remove and unncecessary skip instructions that we might have added.
	goto_functions.update();
	set_entry_point(goto_functions, symbol_table);
	config.set_from_symbol_table(symbol_table);
	namespacet ns(symbol_table);
	return ll2gb_in_error();
}

/// Does some preliminary analysis. Things like
///	mapping alloca instructions to their DbgDeclare
///	happen here.
void translator::analyse_ir() {
	for (auto &F : *llvm_module)
		for (auto &BB : F)
			for (auto &I : BB)
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
			arg_symbol.name = F.getName().str() + "::"
					+ arg_symbol.name.c_str();
			arg_symbol.is_parameter = true;
			arg_symbol.is_state_var = true;
			func_arg_name_map[&arg] = arg_symbol.name.c_str();
			symbol_table.add(arg_symbol);
		}
		symbolt func_symbol = symbol_util::create_goto_func_symbol(F);
		symbol_table.add(func_symbol);
		goto_functions.function_map[func_symbol.name] =
				goto_functionst::goto_functiont();
	}
}

/// This adds all the global symbols to
/// the symbol table.
void translator::add_global_symbols() {
	symbolt symbol;
	symbol_util::reset_var_counter();
	for (auto &G : llvm_module->globals()) {
		symbol = symbol_util::create_symbol(G.getValueType());
		if (G.hasName()) {
			symbol.base_name = G.getName().str();
			symbol.name = symbol.base_name.c_str();
			symbol.value = get_expr(*G.getOperand(0));
			symbol.is_static_lifetime = true;
		}
		symbol_table.add(symbol);
	}
}

/// Returns false on successful
/// translation, true on failure.
/// Read 'error_state' for insights
/// on what caused the error.
bool translator::generate_goto() {
	if (verbose && verbose < 10) {
		outs().changeColor(raw_ostream::Colors::SAVEDCOLOR, true);
		outs() << "Generating GOTO Binary";
		outs().resetColor();
	}
	initialize_goto();
	add_global_symbols();
	add_function_symbols();
	analyse_ir();
	trans_module();
	if (verbose && verbose < 10) {
		outs() << "  [";
		if (ll2gb_in_error()) {
			outs().changeColor(raw_ostream::Colors::RED, true);
			outs() << "FAILED";
		}
		else {
			outs().changeColor(raw_ostream::Colors::GREEN, true);
			outs() << "OK";
		}
		outs().resetColor();
		outs() << "]\n";
	}
	return ll2gb_in_error();
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
		outs() << "]\n\n";
	}
	else if (verbose) {
		outs() << "  [";
		outs().changeColor(outs().GREEN, true);
		outs() << "OK";
		outs().resetColor();
		outs() << "]\n\n";
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
	add_malloc_support(true);
}
