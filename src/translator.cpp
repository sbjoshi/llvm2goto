/*
 * llvm2goto_translator.cpp
 *
 *  Created on: 21-Feb-2019
 *      Author: Akash Banerjee
 */

#include "translator.h"
#include "symbol_util.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

symbol_tablet translator::symbol_table = symbol_tablet();
map<string, string> translator::var_name_map = map<string, string>();

void translator::trans_function(Function &F) {
//	scope_tree st;
//	scope_name_map.clear();
//	st.get_scope_name_map(F, &scope_name_map);
//	std::map<const BasicBlock*, goto_programt::targett> block_target_map;
//	std::map<goto_programt::targett, const BasicBlock*> branch_dest_block_map_switch;
//	std::map<const Instruction*,
//			std::pair<goto_programt::targett, goto_programt::targett>> instruction_target_map;
//	errs() << "\tin trans_Function\n";
//	symbolt symbol =
//			namespacet(*symbol_table).lookup(dstringt(F.getName().str()));
//	Function::const_iterator b = F.begin(), be = F.end();
//	for (; b != be; ++b) {
//		const BasicBlock &B = *b;
//		goto_programt goto_block = trans_Block(B,
//				symbol_table,
//				instruction_target_map,
//				branch_dest_block_map_switch,
//				block_target_map,
//				FAM);
//		register_language (new_ansi_c_language);
//		goto_programt::targett target = goto_block.instructions.begin();
//		gp.destructive_append(goto_block);
//		gp.update();
//		block_target_map.insert(std::pair<const BasicBlock*,
//				goto_programt::targett>(&(*b), target));
//	}
//	gp.add_instruction(END_FUNCTION);
//	errs() << "\n\n *********************************************\n";
//	set_branches(symbol_table, block_target_map, instruction_target_map);
//	errs() << "\n\n *********************************************\n";
//	gp.update();
//	for (auto i = branch_dest_block_map_switch.begin();
//			i != branch_dest_block_map_switch.end(); i++) {
//		std::map<const BasicBlock*, goto_programt::targett>::iterator then_pair =
//				block_target_map.find(dyn_cast<BasicBlock>(i->second));
//		auto guard = i->first->guard;
//		errs() << from_expr(guard) << "\n";
//		i->first->make_goto(then_pair->second, guard);
//	}
//	// assert(false);
//	gp.update();
//	errs() << "\tout of trans_Function " + F.getName().str() + "\n";
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
				symbolt arg_symbol =
						symbol_util::create_symbol(cast<DIType>(&*md->getTypeArray()[i]));

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
