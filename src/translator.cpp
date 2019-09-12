/*
 * llvm2goto_translator.cpp
 *
 *  Created on: 21-Feb-2019
 *      Author: Akash Banerjee
 */

#include "translator.h"
#include "symbol_util.h"
#include "scope_tree.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

symbol_tablet translator::symbol_table = symbol_tablet();
map<string, string> translator::var_name_map = map<string, string>();
map<DIScope*, string> translator::scope_name_map = map<DIScope*, string>();

void translator::trans_alloca(const AllocaInst &AI) {
	symbolt symbol;
	if (alloca_dbg_map.find(&AI) != alloca_dbg_map.end()) {
		auto DI = dyn_cast<DIVariable>(alloca_dbg_map[&AI]->getVariable());
		symbol = symbol_util::create_symbol(DI);
	}
	else {
		symbol = symbol_util::create_symbol(AI.getAllocatedType(),
				AI.getDebugLoc());
	}
	symbol_table.add(symbol);
}

exprt translator::get_cmp_expr(const Instruction *I) {
	exprt condition;
	User::const_value_op_iterator ub = I->value_op_begin();
	exprt opnd1, opnd2;
	typet type1, type2;
	int flag = 2, f1 = 0, f2 = 0;
	if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
		li->getOperand(0)->dump();
//		opnd1 = get_load(li, *symbol_table);
		f1 = 1;
	}
	else if (dyn_cast<ConstantExpr>(*ub)) {
		User::value_op_iterator temp =
				const_cast<Instruction*>(I)->value_op_begin();
		auto *CE = dyn_cast<ConstantExpr>(*temp);
		GetElementPtrInst *GE =
				dyn_cast<GetElementPtrInst>(CE->getAsInstruction());

		typet dummy;
//		opnd1 = address_of_exprt(trans_ConstGetElementPtr(GE,
//				&dummy,
//				I->getDebugLoc()->getScope()));

		GE->deleteValue();
		f1 = 1;
	}
	if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
		li->getOperand(0)->dump();
//		opnd2 = get_load(li);
		f2 = 1;
	}
	else if (dyn_cast<ConstantExpr>(*(ub + 1))) {
		User::value_op_iterator temp =
				const_cast<Instruction*>(I)->value_op_begin();
		auto *CE = dyn_cast<ConstantExpr>(*(temp + 1));
		GetElementPtrInst *GE =
				dyn_cast<GetElementPtrInst>(CE->getAsInstruction());

		typet dummy;
//		opnd2 = address_of_exprt(trans_ConstGetElementPtr(GE,
//				*symbol_table,
//				&dummy,
//				I->getDebugLoc()->getScope()));

		GE->deleteValue();
		f2 = 1;
	}
	if (f1 == 1 && f2 == 1) {
		errs() << "done!";
	}
	else if (I->getOperand(0)->getType()->isIntegerTy()
			|| I->getOperand(1)->getType()->isIntegerTy()) {
		if (f1 == 0) {
			if (dyn_cast<ConstantInt>(*ub)) {
				flag = 1;
			}
			else {
				opnd1 =
						symbol_table.lookup(symbol_util::lookup_namespace(scope_name_map.find(I->getDebugLoc()->getScope())->second
								+ "::" + ub->getName().str()))->symbol_expr();
			}
		}

		if (f2 == 0) {
			if (dyn_cast<ConstantInt>(*(ub + 1))) {
				flag = 0;
			}
			else {
				const symbolt *op2_sym =
						symbol_table.lookup(symbol_util::lookup_namespace(scope_name_map.find(I->getDebugLoc()->getScope())->second
								+ "::" + (ub + 1)->getName().str()));

				opnd2 = op2_sym->symbol_expr();
			}
		}
		type1 = opnd1.type();
		type2 = opnd2.type();
		if (type2.id() == ID_pointer) {
			type2 = type2.subtype();
		}
		if (type1.id() == ID_pointer) {
			type1 = type1.subtype();
		}
		while (type1.id() == ID_array) {
			type1 = type1.subtype();
		}
		while (type2.id() == ID_array) {
			type2 = type2.subtype();
		}
		typet op_type;
		if (type2.id() == ID_signedbv) {
			op_type = type2;
		}
		if (type1.id() == ID_signedbv) {
			op_type = type1;
		}
		if (type2.id() == ID_unsignedbv) {
			op_type = type2;
		}
		if (type1.id() == ID_unsignedbv) {
			op_type = type1;
		}
		if (op_type.id() == ID_signedbv && flag == 1) {
			uint64_t val = dyn_cast<ConstantInt>(*(ub))->getSExtValue();
			typet type = op_type;
			opnd1 = from_integer(val, type);
		}
		if (op_type.id() == ID_signedbv && flag == 0) {
			uint64_t val = dyn_cast<ConstantInt>(*(ub + 1))->getSExtValue();
			typet type = op_type;
			opnd2 = from_integer(val, type);
		}
		if (op_type.id() == ID_unsignedbv && flag == 1) {
			uint64_t val = dyn_cast<ConstantInt>(*(ub))->getZExtValue();
			typet type = op_type;
			opnd1 = from_integer(val, type);
		}
		if (op_type.id() == ID_unsignedbv && flag == 0) {
			uint64_t val = dyn_cast<ConstantInt>(*(ub + 1))->getZExtValue();
			typet type = op_type;
			opnd2 = from_integer(val, type);
		}
	}
	else {
		if (I->getOperand(0)->getType()->isFloatTy()) {
			if (f1 == 0) {
				if (dyn_cast<ConstantFP>(*ub)) {
					float val =
							dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
					ieee_floatt ieee_fl(float_type());
					ieee_fl.from_float(val);
					opnd1 = ieee_fl.to_expr();
				}
			}
			if (f2 == 0) {
				if (dyn_cast<ConstantFP>(*(ub + 1))) {
					float val =
							dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF().convertToFloat();
					ieee_floatt ieee_fl(float_type());
					ieee_fl.from_double(val);
					opnd2 = ieee_fl.to_expr();
				}
			}
		}
		else if (I->getOperand(0)->getType()->isDoubleTy()) {
			if (f1 == 0) {
				if (dyn_cast<ConstantFP>(*ub)) {
					double val =
							dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
					ieee_floatt ieee_fl(double_type());
					ieee_fl.from_double(val);
					opnd1 = ieee_fl.to_expr();
				}
			}
			if (f2 == 0) {
				if (dyn_cast<ConstantFP>(*(ub + 1))) {
					double val =
							dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF().convertToDouble();
					ieee_floatt ieee_fl(double_type());
					ieee_fl.from_double(val);
					opnd2 = ieee_fl.to_expr();
				}
			}
		}
		else if (I->getOperand(0)->getType()->isPointerTy()) {
			I->getOperand(0)->getType()->dump();
			assert(false && "Pointer datatype has not been handled");
		}
		else {
			assert(false && "This datatype has not been handled");
		}
	}
	if (opnd1.type().id() != opnd2.type().id()) {
		opnd2 = typecast_exprt(opnd2, opnd1.type());
	}
	switch (dyn_cast<CmpInst>(I)->getPredicate()) {
	case CmpInst::Predicate::ICMP_EQ: {
		condition = equal_exprt(opnd1, opnd2);
		break;
	}
	case CmpInst::Predicate::FCMP_OEQ:
	case CmpInst::Predicate::FCMP_UEQ: {
		condition = ieee_float_equal_exprt(opnd1, opnd2);
		break;
	}
	case CmpInst::Predicate::ICMP_NE: {
		condition = notequal_exprt(opnd1, opnd2);
		break;
	}
	case CmpInst::Predicate::FCMP_ONE:
	case CmpInst::Predicate::FCMP_UNE: {
		condition = ieee_float_notequal_exprt(opnd1, opnd2);
		break;
	}
	case CmpInst::Predicate::ICMP_UGT:
	case CmpInst::Predicate::ICMP_SGT:
	case CmpInst::Predicate::FCMP_OGT:
	case CmpInst::Predicate::FCMP_UGT: {
		condition = binary_relation_exprt(opnd1, ID_gt, opnd2);
		break;
	}
	case CmpInst::Predicate::ICMP_UGE:
	case CmpInst::Predicate::ICMP_SGE:
	case CmpInst::Predicate::FCMP_OGE:
	case CmpInst::Predicate::FCMP_UGE: {
		condition = binary_relation_exprt(opnd1, ID_ge, opnd2);
		break;
	}
	case CmpInst::Predicate::ICMP_ULT:
	case CmpInst::Predicate::ICMP_SLT:
	case CmpInst::Predicate::FCMP_OLT:
	case CmpInst::Predicate::FCMP_ULT: {
		condition = binary_relation_exprt(opnd1, ID_lt, opnd2);
		break;
	}
	case CmpInst::Predicate::ICMP_ULE:
	case CmpInst::Predicate::ICMP_SLE:
	case CmpInst::Predicate::FCMP_OLE:
	case CmpInst::Predicate::FCMP_ULE: {
		condition = binary_relation_exprt(opnd1, ID_le, opnd2);
		break;
	}
	case CmpInst::Predicate::BAD_ICMP_PREDICATE: {
		break;
	}
	}
	return condition;
}

void translator::trans_instruction(const Instruction &I) {
//	const Instruction *Inst = &I;
	switch (I.getOpcode()) {
//	case Instruction::Ret: {
//		trans_Ret(Inst, *symbol_table);
//		break;
//	}
//	case Instruction::Br: {
//		goto_programt br_gp = trans_Br(Inst,
//				symbol_table,
//				instruction_target_map);
//		gp.destructive_append(br_gp);
//		break;
//	}
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
//	case Instruction::Add: {
//		goto_programt add_ins = trans_Add(Inst, *symbol_table);
//		gp.destructive_append(add_ins);
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
		const AllocaInst &AI = *dyn_cast<AllocaInst>(&I);
		trans_alloca(AI);
		break;
	}
//	case Instruction::Load: {
//		goto_programt store_gp = trans_Load(Inst);
//		break;
//	}
//	case Instruction::Store: {
//		goto_programt load_gp = trans_Store(Inst, *symbol_table);
//		gp.destructive_append(load_gp);
//		break;
//	}
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
//	case Instruction::Trunc: {
//		goto_programt trunc_gp = trans_Trunc(Inst, *symbol_table);
//		gp.destructive_append(trunc_gp);
//		break;
//	}
//	case Instruction::ZExt: {
//		goto_programt zext_gp = trans_ZExt(Inst, *symbol_table);
//		gp.destructive_append(zext_gp);
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
//	case Instruction::Call: {
//		goto_programt Call_Inst = trans_Call(Inst, symbol_table, &FAM);
//		gp.destructive_append(Call_Inst);
//		break;
//	}
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

void translator::set_branches(map<const BasicBlock*, goto_programt::targett> block_target_map,
		map<const Instruction*,
				pair<goto_programt::targett, goto_programt::targett>> instruction_target_map) {
	for (auto i = instruction_target_map.begin(), ie =
			instruction_target_map.end(); i != ie; i++) {
		if (dyn_cast<BranchInst>((*i).first)->getNumSuccessors() == 2) {
			goto_programt::targett then_part;
			goto_programt::targett else_part;
			exprt guard;
			if (dyn_cast<BranchInst>((*i).first)->isConditional()) {
				auto temp =
						dyn_cast<Instruction>(dyn_cast<BranchInst>((*i).first)->getCondition());
				if (dyn_cast<CmpInst>(temp))
					guard = not_exprt(get_cmp_expr(temp));
//				else if (auto phi = dyn_cast<PHINode>(temp))
//					guard = not_exprt(get_PHI(phi));
			}
			else {
				guard = true_exprt();
			}
			map<const BasicBlock*, goto_programt::targett>::iterator then_pair =
					block_target_map.find(dyn_cast<BasicBlock>(dyn_cast<
							BranchInst>((*i).first)->getSuccessor(1)));
			then_part = (*then_pair).second;
			else_part = block_target_map[dyn_cast<BasicBlock>(dyn_cast<
					BranchInst>((*i).first)->getSuccessor(0))];
			(*i).second.first->make_goto(then_part, guard);
			(*i).second.second->make_goto(else_part, true_exprt());
		}
		else {
			goto_programt::targett then_part;
			exprt guard;
			if (dyn_cast<BranchInst>((*i).first)->isConditional()) {
				guard =
						get_cmp_expr(dyn_cast<Instruction>(dyn_cast<BranchInst>((*i).first)->getCondition()));
			}
			else {
				guard = true_exprt();
			}
			map<const BasicBlock*, goto_programt::targett>::iterator then_pair =
					block_target_map.find(dyn_cast<BasicBlock>(dyn_cast<
							BranchInst>((*i).first)->getSuccessor(0)));
			then_part = (*then_pair).second;
			(*i).second.first->make_goto(then_part, guard);
		}
	}
}

void translator::trans_function(Function &F) {
	scope_tree st;
	scope_name_map.clear();
	st.get_scope_name_map(F, &scope_name_map);
	map<const BasicBlock*, goto_programt::targett> block_target_map;
	map<goto_programt::targett, const BasicBlock*> branch_dest_block_map_switch;
	map<const Instruction*, pair<goto_programt::targett, goto_programt::targett>> instruction_target_map;
	auto func_symbol = namespacet(symbol_table).lookup(F.getName().str());
	Function::const_iterator b = F.begin(), be = F.end();
	for (; b != be; ++b) {
		const BasicBlock &B = *b;
		trans_block(B);
		register_language(new_ansi_c_language);
		goto_programt::targett target = goto_program.add_instruction();
		target->make_skip();
		block_target_map.insert(pair<const BasicBlock*, goto_programt::targett>(&(*b),
				target));
	}
	goto_program.add_instruction(END_FUNCTION);
	set_branches(block_target_map, instruction_target_map);
	goto_program.update();
	for (auto i = branch_dest_block_map_switch.begin();
			i != branch_dest_block_map_switch.end(); i++) {
		map<const BasicBlock*, goto_programt::targett>::iterator then_pair =
				block_target_map.find(dyn_cast<BasicBlock>(i->second));
		auto guard = i->first->guard;
		i->first->make_goto(then_pair->second, guard);
	}
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
		if (F.isDeclaration()) {
			continue;
		}
		if (F.getSubprogram() != NULL) {
			auto *md = cast<DISubprogram>(F.getSubprogram())->getType();
			unsigned int i = 1;
			for (auto arg_iter = F.arg_begin(), arg_end = F.arg_end();
					arg_iter != arg_end; arg_iter++, i++) {
				symbolt arg_symbol = symbol_util::create_symbol(cast<
						DILocalVariable>(&*md->getTypeArray()[i]));
				if (!arg_iter->getName().str().compare("argc"))
					arg_symbol.name = "argc'";
				else
					arg_symbol.name = F.getName().str() + "::"
							+ arg_iter->getName().str();
				if (!arg_iter->getName().str().compare("argv"))
					arg_symbol.name = "argv'";
				else
					arg_symbol.name = F.getName().str() + "::"
							+ arg_iter->getName().str();
				arg_symbol.base_name = arg_iter->getName().str();
				arg_symbol.is_lvalue = true;
				arg_symbol.is_parameter = true;
				arg_symbol.is_state_var = true;
				arg_symbol.is_thread_local = true;
				arg_symbol.is_file_local = true;
				symbol_table.add(arg_symbol);
				var_name_map[arg_symbol.name.c_str()] =
						arg_symbol.base_name.c_str();
			}
		}
		symbolt func_symbol =
				symbol_util::create_goto_func_symbol(F.getFunctionType(), F);
		symbol_table.add(func_symbol);
		goto_functions.function_map[F.getName().str()] =
				goto_functionst::goto_functiont();
	}
}

bool translator::generate_goto() {
	dbgs() << "Generating GOTO Binary\n";

	initialize_goto();
	add_global_symbols();
	add_function_symbols();
	analyse_ir();
	for (auto F = llvm_module->getFunctionList().begin();
			F != llvm_module->getFunctionList().end(); F++) {
		trans_function(*F);
	}

	dbgs() << "GOTO Binary generated successfully\n";
	return true;
}
