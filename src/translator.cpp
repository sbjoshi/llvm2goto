/*
 * llvm2goto_translator.cpp
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
//map<Instruction*, string> translator::var_name_map =
//		map<Instruction*, string>();
map<const Argument*, string> translator::func_arg_name_map = map<
		const Argument*, string>();
map<DIScope*, string> translator::scope_name_map = map<DIScope*, string>();

exprt translator::get_expr_const(const Constant &C) {
	exprt expr;
	if (isa<ConstantAggregate>(C)) {
//		TODO:Implement this
	}
	else if (isa<ConstantData>(C)) {
		if (isa<ConstantAggregateZero>(C)) {
		}
		else if (isa<ConstantDataSequential>(C)) {
		}
		else if (isa<ConstantFP>(C)) {
		}
		else if (isa<ConstantInt>(C)) {
			auto &CI = cast<ConstantInt>(C);
			auto val = CI.getSExtValue();
			expr = from_integer(val, signedbv_typet(CI.getBitWidth()));
		}
		else if (isa<ConstantPointerNull>(C)) {
		}
		else if (isa<ConstantTokenNone>(C)) {
		}
		else if (isa<UndefValue>(C)) {
		}
	}
	else if (isa<ConstantExpr>(C)) {
//		TODO:Implement this
	}
	else if (isa<GlobalValue>(C)) {
//		TODO:Implement this
	}
	return expr;
}

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
		//		TODO:Implement this
		break;
	}
	case CmpInst::Predicate::ICMP_SGT: {
		//		TODO:Implement this
		break;
	}
	case CmpInst::Predicate::ICMP_SLE: {
		//		TODO:Implement this
		break;
	}
	case CmpInst::Predicate::ICMP_SLT: {
		//		TODO:Implement this
		break;
	}
	case CmpInst::Predicate::ICMP_UGE: {
		//		TODO:Implement this
		break;
	}
	case CmpInst::Predicate::ICMP_UGT: {
		//		TODO:Implement this
		break;
	}
	case CmpInst::Predicate::ICMP_ULE: {
		//		TODO:Implement this
		break;
	}
	case CmpInst::Predicate::ICMP_ULT: {
		//		TODO:Implement this
		break;
	}
	default:
		assert(false && "Unknown ICmp Instr Predicate");
	}
	return expr;
}

exprt translator::get_expr_trunc(const TruncInst &TI) {
	exprt expr;
	const auto &ll_op1 = TI.getOperand(0);
	const auto &ll_op2 = TI.getDestTy();
	auto expr_op1 = get_expr(*ll_op1);
	expr = typecast_exprt(expr_op1,
			signedbv_typet(ll_op2->getIntegerBitWidth()));
	return expr;
}

exprt translator::get_expr_add(const Instruction &AI) {
	exprt expr;
	const auto &ll_op1 = AI.getOperand(0);
	const auto &ll_op2 = AI.getOperand(1);
	auto expr_op1 = get_expr(*ll_op1);
	auto expr_op2 = get_expr(*ll_op2);
	expr = plus_exprt(expr_op1, expr_op2);
	return expr;
}

exprt translator::get_expr_sext(const SExtInst &SI) {
	exprt expr;
	const auto &ll_op1 = SI.getOperand(0);
	const auto &ll_op2 = SI.getDestTy();
	expr = get_expr(*ll_op1);
	expr = typecast_exprt(expr, signedbv_typet(ll_op2->getIntegerBitWidth()));
	return expr;
}

exprt translator::get_expr_zext(const ZExtInst &ZI) {
	exprt expr;
	const auto &ll_op1 = ZI.getOperand(0);
	const auto &ll_op2 = ZI.getDestTy();
	expr = get_expr(*ll_op1);
	expr = typecast_exprt(expr, signedbv_typet(ll_op2->getIntegerBitWidth()));
///	Make all the MSB bits as 0, since we want to do a Zero Extension.
	unsigned long long zext_and = 1u;
	zext_and <<= ll_op1->getType()->getIntegerBitWidth();
	zext_and--;
	auto zext_expr = from_integer(zext_and,
			signedbv_typet(ll_op2->getIntegerBitWidth()));
	expr = bitand_exprt(expr, zext_expr);
	return expr;
}

exprt translator::get_expr_load(const LoadInst &LI) {
	exprt expr;
	static bool first_call = true; //Dereferencing is not needed for the first load.
	const auto &ll_op1 = LI.getOperand(0);
	if (first_call) {
		first_call = false;
		expr = get_expr(*ll_op1);
		first_call = true;
	}
	else
		expr = dereference_exprt(get_expr(*ll_op1));
	return expr;
}

exprt translator::get_expr(const Value &V) {
	exprt expr;
	if (isa<Instruction>(V)) {
		const auto &I = cast<Instruction>(V);
		switch (I.getOpcode()) {
		case Instruction::Alloca: {
			auto s = var_name_map[&I];
			auto symbol = symbol_table.lookup(var_name_map[&I]);
			return symbol->symbol_expr();
			break;
		}
		case Instruction::Load: {
			const auto &LI = cast<LoadInst>(&I);
			expr = get_expr_load(*LI);
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
		case Instruction::Add: {
			expr = get_expr_add(I);
			break;
		}
		case Instruction::Trunc: {
			const auto &TI = cast<TruncInst>(&I);
			expr = get_expr_trunc(*TI);
			break;
		}
		case Instruction::ICmp: {
			const auto &ICI = cast<ICmpInst>(&I);
			expr = get_expr_icmp(*ICI);
			break;
		}
		default:
			assert(false && "Unhandled Instruction type in get_expr()");
		}
	}
	else if (isa<Constant>(V)) {
		const auto &C = cast<Constant>(V);
		expr = get_expr_const(C);
	}
	else if (isa<Argument>(V)) {
		const auto &A = cast<Argument>(V);
		auto symbol = symbol_table.lookup(func_arg_name_map[&A]);
		return symbol->symbol_expr();
	}
	return expr;
}

void translator::trans_store(const StoreInst &SI) {
	const auto &ll_op1 = SI.getOperand(0);
	const auto &ll_op2 = SI.getOperand(1);
	auto src_expr = get_expr(*ll_op1);
	auto tgt_expr = get_expr(*ll_op2);
	auto asgn_instr = goto_program.add_instruction();
	asgn_instr->make_assignment();
	asgn_instr->code = code_assignt(tgt_expr, src_expr);
	source_locationt location;
	if (SI.getMetadata(0)) {
		const auto loc = SI.getDebugLoc();
		location.set_file(loc->getScope()->getFile()->getFilename().str());
		location.set_working_directory(loc->getScope()->getFile()->getDirectory().str());
		location.set_line(loc->getLine());
		location.set_column(loc->getColumn());
		location.set_function(SI.getFunction()->getName().str());
	}
	asgn_instr->source_location = location;
	asgn_instr->type = goto_program_instruction_typet::ASSIGN;
	goto_program.update();
}

void translator::trans_alloca(const AllocaInst &AI) {
	symbolt symbol;
	symbol = symbol_util::create_symbol(AI.getAllocatedType());
	if (alloca_dbg_map.find(&AI) != alloca_dbg_map.end()) {
		auto DI = alloca_dbg_map[&AI]->getVariable();
		symbol.name =
				scope_name_map.find(dyn_cast<DILocalScope>(DI->getScope())->getNonLexicalBlockFileScope())->second
						+ "::" + DI->getName().str();
		symbol.base_name = DI->getName().str();
		source_locationt location;
		location.set_file(DI->getScope()->getFile()->getFilename().str());
		location.set_working_directory(DI->getScope()->getFile()->getDirectory().str());
		location.set_line(DI->getLine());
		location.set_function(AI.getFunction()->getName().str());
		symbol.location = location;
	}
	else {
		if (AI.hasName()) {
			symbol.base_name = AI.getName().str();
			symbol.name = AI.getFunction()->getName().str() + "::"
					+ symbol.base_name.c_str();
		}
		else
			symbol.name = AI.getFunction()->getName().str() + "::"
					+ symbol.name.c_str();
	}
	auto &I = cast<Instruction>(AI);
	var_name_map[&I] = symbol.name.c_str();
	symbol_table.add(symbol);
	auto dclr_instr = goto_program.add_instruction();
	dclr_instr->make_decl();
	dclr_instr->code = code_declt(symbol.symbol_expr());
	source_locationt location;
	if (AI.getMetadata(0)) {
		const auto loc = AI.getDebugLoc();
		location.set_file(loc->getScope()->getFile()->getFilename().str());
		location.set_working_directory(loc->getScope()->getFile()->getDirectory().str());
		location.set_line(loc->getLine());
		location.set_column(loc->getColumn());
	}
	else {
		location.set_file(symbol.location.get_file());
		location.set_line(symbol.location.get_line());
		location.set_working_directory(symbol.location.get_working_directory());
		location.set_function(AI.getFunction()->getName().str());
	}
	dclr_instr->source_location = location;
	dclr_instr->type = goto_program_instruction_typet::DECL;
	goto_program.update();
}

void translator::trans_call(const llvm::CallInst &CI) {
	auto called_func = CI.getCalledFunction();
	if (called_func) {
		if (!called_func->getName().str().compare("__assert_fail")) {
			auto assert_inst = goto_program.add_instruction();
			assert_inst->make_assertion(false_exprt());
			source_locationt location;
			if (CI.getMetadata(0)) {
				const auto loc = CI.getDebugLoc();
				location.set_file(loc->getScope()->getFile()->getFilename().str());
				location.set_working_directory(loc->getScope()->getFile()->getDirectory().str());
				location.set_line(loc->getLine());
				location.set_column(loc->getColumn());
				location.set_function(CI.getFunction()->getName().str());
			}
			assert_inst->source_location = location;
			goto_program.update();
		}
		//		TODO:Implement this
	}
	else {
		auto called_val = CI.getCalledValue()->stripPointerCasts();
		if (!called_val->getName().str().compare("assert")) {
			auto assert_inst = goto_program.add_instruction();
			auto guard_expr = typecast_exprt(get_expr(*CI.getOperand(0)),
					bool_typet());
			assert_inst->make_assertion(guard_expr);
			source_locationt location;
			if (CI.getMetadata(0)) {
				const auto loc = CI.getDebugLoc();
				location.set_file(loc->getScope()->getFile()->getFilename().str());
				location.set_working_directory(loc->getScope()->getFile()->getDirectory().str());
				location.set_line(loc->getLine());
				location.set_column(loc->getColumn());
				location.set_function(CI.getFunction()->getName().str());
			}
			assert_inst->source_location = location;
			goto_program.update();
		}
		//		TODO:Implement this
	}
}

void translator::trans_ret(const ReturnInst &RI) {
	const auto &ll_op1 = RI.getOperand(0);
	auto ret_expr = get_expr(*ll_op1);
	goto_programt::targett ret_inst = goto_program.add_instruction();
	code_returnt cret;
	cret.return_value() = ret_expr;
	ret_inst->make_return();
	ret_inst->code = cret;
	source_locationt location;
	if (RI.getMetadata(0)) {
		const auto loc = RI.getDebugLoc();
		location.set_file(loc->getScope()->getFile()->getFilename().str());
		location.set_working_directory(loc->getScope()->getFile()->getDirectory().str());
		location.set_line(loc->getLine());
		location.set_column(loc->getColumn());
		location.set_function(RI.getFunction()->getName().str());
	}
	ret_inst->source_location = location;
	goto_program.update();
}

void translator::trans_br(const BranchInst &BI) {
	if (BI.getNumSuccessors() == 2) {
		goto_programt::targett cond_true = goto_program.add_instruction();
		goto_programt::targett cond_false = goto_program.add_instruction();
		br_instr_target_map[&BI] = pair<goto_programt::targett,
				goto_programt::targett>(cond_true, cond_false);
	}
	else {
		goto_programt::targett br_ins = goto_program.add_instruction();
		br_instr_target_map[&BI] = pair<goto_programt::targett,
				goto_programt::targett>(br_ins, br_ins);
	}
	goto_program.update();
}

void translator::trans_instruction(const Instruction &I) {
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
//	case Instruction::Switch: {
//		goto_programt sw_gp = trans_Switch(Inst,
//				branch_dest_block_map_switch,
//				*symbol_table);
//		gp.destructive_append(sw_gp);
//		break;
//	}
//	case Instruction::IndirectBr: {
//		gp = trans_IndirectBr(Inst);
//		break;
//	}
//	case Instruction::Invoke: {
//		gp = trans_Invoke(Inst);
//		break;
//	}
//	case Instruction::Resume: {
//		gp = trans_Resume(Inst);
//		break;
//	}
//	case Instruction::Unreachable: {
//		goto_programt unreachable_gp = trans_Unreachable(Inst);
//		gp.destructive_append(unreachable_gp);
//		break;
//	}
//	case Instruction::CleanupRet: {
//		gp = trans_CleanupRet(Inst);
//		break;
//	}
//	case Instruction::CatchRet: {
//		gp = trans_CatchRet(Inst);
//		break;
//	}
//	case Instruction::CatchPad: {
//		gp = trans_CatchPad(Inst);
//		break;
//	}
//	case Instruction::CatchSwitch: {
//		gp = trans_CatchSwitch(Inst);
//		break;
//	}
//	case Instruction::FAdd: {
//		goto_programt fadd_inst = trans_FAdd(Inst, *symbol_table);
//		gp.destructive_append(fadd_inst);
//		break;
//	}
//	case Instruction::Sub: {
//		goto_programt sub_ins = trans_Sub(Inst, *symbol_table);
//		gp.destructive_append(sub_ins);
//		break;
//	}
//	case Instruction::FSub: {
//		goto_programt fsub_inst = trans_FSub(Inst, *symbol_table);
//		gp.destructive_append(fsub_inst);
//		break;
//	}
//	case Instruction::Mul: {
//		goto_programt mul_ins = trans_Mul(Inst, *symbol_table);
//		gp.destructive_append(mul_ins);
//		break;
//	}
//	case Instruction::FMul: {
//		goto_programt fmul_inst = trans_FMul(Inst, *symbol_table);
//		gp.destructive_append(fmul_inst);
//		break;
//	}
//	case Instruction::UDiv: {
//		goto_programt udiv_ins = trans_UDiv(Inst, *symbol_table);
//		gp.destructive_append(udiv_ins);
//		break;
//	}
//	case Instruction::SDiv: {
//		goto_programt sdiv_ins = trans_SDiv(Inst, *symbol_table);
//		gp.destructive_append(sdiv_ins);
//		break;
//	}
//	case Instruction::FDiv: {
//		goto_programt fdiv_inst = trans_FDiv(Inst, *symbol_table);
//		gp.destructive_append(fdiv_inst);
//		break;
//	}
//	case Instruction::URem: {
//		goto_programt urem_ins = trans_URem(Inst, *symbol_table);
//		gp.destructive_append(urem_ins);
//		break;
//	}
//	case Instruction::SRem: {
//		goto_programt srem_ins = trans_URem(Inst, *symbol_table);
//		gp.destructive_append(srem_ins);
//		break;
//	}
//	case Instruction::FRem: {
//		goto_programt frem_inst = trans_FRem(Inst, *symbol_table);
//		gp.destructive_append(frem_inst);
//		break;
//	}
//	case Instruction::And: {
//		goto_programt and_inst = trans_And(Inst, *symbol_table);
//		gp.destructive_append(and_inst);
//		break;
//	}
//	case Instruction::Or: {
//		goto_programt or_inst = trans_Or(Inst, *symbol_table);
//		gp.destructive_append(or_inst);
//		break;
//	}
//	case Instruction::Xor: {
//		goto_programt xor_inst = trans_Xor(Inst, *symbol_table);
//		gp.destructive_append(xor_inst);
//		break;
//	}
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
//	case Instruction::AtomicCmpXchg: {
//		gp = trans_AtomicCmpXchg(Inst);
//		break;
//	}
//	case Instruction::AtomicRMW: {
//		gp = trans_AtomicRMW(Inst);
//		break;
//	}
//	case Instruction::Fence: {
//		gp = trans_Fence(Inst);
//		break;
//	}
//	case Instruction::GetElementPtr: {
//		goto_programt getElementPtr_gp = trans_GetElementPtr(Inst,
//				*symbol_table);
//		gp.destructive_append(getElementPtr_gp);
//		break;
//	}
//	case Instruction::SExt: {
//		goto_programt sext_gp = trans_SExt(Inst, *symbol_table);
//		gp.destructive_append(sext_gp);
//		break;
//	}
//	case Instruction::FPTrunc: {
//		goto_programt fptrunc_gp = trans_FPTrunc(Inst, *symbol_table);
//		gp.destructive_append(fptrunc_gp);
//		break;
//	}
//	case Instruction::FPExt: {
//		goto_programt fpext_gp = trans_FPExt(Inst, *symbol_table);
//		gp.destructive_append(fpext_gp);
//		break;
//	}
//	case Instruction::FPToUI: {
//		goto_programt fptoui_gp = trans_FPToUI(Inst, *symbol_table);
//		gp.destructive_append(fptoui_gp);
//		break;
//	}
//	case Instruction::FPToSI: {
//		goto_programt fptosi_gp = trans_FPToSI(Inst, *symbol_table);
//		gp.destructive_append(fptosi_gp);
//		break;
//	}
//	case Instruction::UIToFP: {
//		goto_programt uitofp_gp = trans_UIToFP(Inst, *symbol_table);
//		gp.destructive_append(uitofp_gp);
//		break;
//	}
//	case Instruction::SIToFP: {
//		goto_programt sitofp_gp = trans_SIToFP(Inst, *symbol_table);
//		gp.destructive_append(sitofp_gp);
//		break;
//	}
//	case Instruction::IntToPtr: {
//		gp = trans_IntToPtr(Inst);
//		break;
//	}
//	case Instruction::PtrToInt: {
//		gp = trans_PtrToInt(Inst, *symbol_table);
//		break;
//	}
//	case Instruction::BitCast: {
//		gp = trans_BitCast(Inst);
//		break;
//	}
//	case Instruction::AddrSpaceCast: {
//		gp = trans_AddrSpaceCast(Inst);
//		break;
//	}
//	case Instruction::ICmp: {
//		goto_programt Icmp_inst = trans_ICmp(Inst, symbol_table);
//		gp.destructive_append(Icmp_inst);
//		break;
//	}
//	case Instruction::FCmp: {
//		goto_programt Fcmp_inst = trans_FCmp(Inst, symbol_table);
//		gp.destructive_append(Fcmp_inst);
//		break;
//	}
//	case Instruction::PHI: {
//		break;
//	}
//	case Instruction::Select: {
//		gp = trans_Select(Inst);
//		break;
//	}
	case Instruction::Call: {
		if (isa<DbgDeclareInst>(I)) {
			break;
		}
		const CallInst &CI = cast<CallInst>(I);
		trans_call(CI);
		break;
	}
//	case Instruction::Shl: {
//		goto_programt shl_Inst = trans_Shl(Inst, *symbol_table);
//		gp.destructive_append(shl_Inst);
//		break;
//	}
//	case Instruction::LShr: {
//		goto_programt lshr_Inst = trans_LShr(Inst, *symbol_table);
//		gp.destructive_append(lshr_Inst);
//		break;
//	}
//	case Instruction::AShr: {
//		goto_programt ashr_Inst = trans_AShr(Inst, *symbol_table);
//		gp.destructive_append(ashr_Inst);
//		break;
//	}
//	case Instruction::VAArg: {
//		gp = trans_VAArg(Inst);
//		break;
//	}
//	case Instruction::ExtractElement: {
//		gp = trans_ExtractElement(Inst);
//		break;
//	}
//	case Instruction::InsertElement: {
//		gp = trans_InsertElement(Inst);
//		break;
//	}
//	case Instruction::ShuffleVector: {
//		gp = trans_ShuffleVector(Inst);
//		break;
//	}
//	case Instruction::ExtractValue: {
//		gp = trans_ExtractValue(Inst);
//		break;
//	}
//	case Instruction::InsertValue: {
//		gp = trans_InsertValue(Inst);
//		break;
//	}
//	case Instruction::LandingPad: {
//		gp = trans_LandingPad(Inst);
//		break;
//	}
//	case Instruction::CleanupPad: {
//		gp = trans_CleanupPad(Inst);
//		break;
//	}
	case Instruction::Add:
	case Instruction::Trunc:
	case Instruction::ZExt:
	case Instruction::SExt:
	case Instruction::Load:
		break;
	default:
		errs() << "Invalid instruction type...\n ";
	}
}

void translator::trans_block(const BasicBlock &BB) {
	for (auto iter = BB.begin(), ie = BB.end(); iter != ie; ++iter) {
		auto &I = *iter;
		trans_instruction(I);
	}
}

void translator::set_branches() {
	for (auto br_inst_iter = br_instr_target_map.begin(), ie =
			br_instr_target_map.end(); br_inst_iter != ie; br_inst_iter++) {
		const auto &BI = br_inst_iter->first;
		if (br_inst_iter->first->isConditional()) {
			const auto &cond = br_inst_iter->first->getCondition();
			auto guard_expr = get_expr(*cond);
			auto then_target = block_target_map[BI->getSuccessor(1)];
			auto else_taget = block_target_map[BI->getSuccessor(0)];
			br_inst_iter->second.first->make_goto(then_target, guard_expr);
			br_inst_iter->second.second->make_goto(else_taget, true_exprt());
		}
		else {
			goto_programt::targett then_part;
			auto guard_expr = true_exprt();
			then_part = block_target_map[BI->getSuccessor(0)];
			br_inst_iter->second.first->make_goto(then_part, guard_expr);
		}
	}
}

void translator::move_symbol(symbolt &symbol, symbolt *&new_symbol) {
	symbol.mode = ID_C;
	if (symbol_table.move(symbol, new_symbol)) {
		assert(false && "failed to move symbol");
	}
}

void translator::add_argc_argv(const symbolt &main_symbol) {
	const code_typet::parameterst &parameters =
			to_code_type(main_symbol.type).parameters();

	if (parameters.empty()) return;

	if (parameters.size() != 2 && parameters.size() != 3) {
		assert(false && "main expected to have no or two or three parameters");
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
			assert(false && "argc argument expected to be integer type");
		}

		move_symbol(argc_symbol, argc_new_symbol);
	}

	{
		if (op1.type().id() != ID_pointer
				|| op1.type().subtype().id() != ID_pointer) {
			assert(false
					&& "argv argument expected to be pointer-to-pointer type");
		}

		// we make the type of this thing an array of pointers
		// need to add one to the size -- the array is terminated
		// with NULL
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
			assert(false && "envp argument expected to be pointer type");
		}

		exprt size_expr = envp_new_size_symbol->symbol_expr();

		envp_symbol.type.id(ID_array);
		envp_symbol.type.add(ID_size).swap(size_expr);

		symbolt *envp_new_symbol;
		move_symbol(envp_symbol, envp_new_symbol);
	}
}

void translator::trans_function(Function &F) {
	symbol_util::set_var_counter(F.arg_size() + 1);
	scope_tree st;
	scope_name_map.clear();
	st.get_scope_name_map(F, &scope_name_map);
	scope_name_map[nullptr] = "";
	Function::const_iterator b = F.begin(), be = F.end();
	for (; b != be; ++b) {
		const BasicBlock &B = *b;
		trans_block(B);
		goto_programt::targett target = goto_program.add_instruction();
		target->make_skip();
		block_target_map.insert(pair<const BasicBlock*, goto_programt::targett>(&(*b),
				target));
	}
	goto_program.add_instruction(END_FUNCTION);
	set_branches();
//	for (auto i = branch_dest_block_map_switch.begin();
//			i != branch_dest_block_map_switch.end(); i++) {
//		map<const BasicBlock*, goto_programt::targett>::iterator then_pair =
//				block_target_map.find(dyn_cast<BasicBlock>(i->second));
//		auto guard = i->first->guard;
//		i->first->make_goto(then_pair->second, guard);
//	}
	goto_program.update();
}

void translator::add_global_symbols() {
	for (auto &G : llvm_module->globals()) {
		G.getType()->dump();
	}
}

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
						auto *AI = cast<AllocaInst>(V);
						alloca_dbg_map[AI] = cast<DbgDeclareInst>(CI);
					}
				}
}

void translator::add_function_symbols() {
	for (Function &F : *llvm_module) {
		symbol_util::set_var_counter(1);
		if (F.isDeclaration()) {
			continue;
		}
		if (!F.getName().str().compare("main"))
			assert(F.arg_size() <= 2
					&& "main function can't take more than two arguments!");
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

void translator::write_goto(const string &filename) {
	ofstream out(filename, ios::binary);
	write_goto_binary(out, symbol_table, goto_functions);
	dbgs() << "GOTO Binary written to file: " << filename << '\n';
}

void translator::trans_module() {
	register_language(new_ansi_c_language);
	for (auto F = llvm_module->getFunctionList().begin();
			F != llvm_module->getFunctionList().end(); F++) {
		if (F->isDeclaration()) {
			continue;
		}
		trans_function(*F);
		const auto *fn = symbol_table.lookup(F->getName().str());
		goto_functions.function_map.find(F->getName().str())->second.body.swap(goto_program);
		(*goto_functions.function_map.find(F->getName().str())).second.type =
				to_code_type(fn->type);
		goto_program.clear();
	}
	remove_skip(goto_functions);
	goto_functions.update();
	set_entry_point(goto_functions, symbol_table);
	config.set_from_symbol_table(symbol_table);
	namespacet ns(symbol_table);
}

bool translator::generate_goto() {
	dbgs() << "Generating GOTO Binary\n";
	initialize_goto();
	add_global_symbols();
	add_function_symbols();
	analyse_ir();
	trans_module();
	dbgs() << "GOTO Binary generated successfully\n";
	return true;
}
