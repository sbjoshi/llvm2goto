/*
 * translator.h
 *
 *  Created on: 20-Aug-2019
 *      Author: Akash Banerjee
 */

#ifndef TRANSLATOR_H
#define TRANSLATOR_H

#include "llvm2goto.h"

class ll2gb::translator {
private:
	std::unique_ptr<llvm::Module> &llvm_module;
	goto_programt goto_program;
	goto_functionst goto_functions;
	static symbol_tablet symbol_table;

	std::map<const llvm::Instruction*, std::string> var_name_map; ///<map from instructions to their symbol names
	static std::map<const llvm::Argument*, std::string> func_arg_name_map; ///<map from instructions to their symbol names
	static std::map<llvm::DIScope*, std::string> scope_name_map;
	std::map<const llvm::AllocaInst*, llvm::DbgDeclareInst*> alloca_dbg_map; ///<map from Allocas to their DbgDeclare if exists

	void add_global_symbols();
	void set_config();
	void add_initial_symbols();
	void add_function_symbols();
	void initialize_goto() {
		set_config();
		add_initial_symbols();
	}
	void analyse_ir();
	void trans_instruction(const llvm::Instruction&);
	void trans_block(const llvm::BasicBlock&);
	void trans_function(llvm::Function&);
	void set_branches(std::map<const llvm::BasicBlock*, goto_programt::targett> block_target_map,
			std::map<const llvm::Instruction*,
					std::pair<goto_programt::targett, goto_programt::targett>> instruction_target_map);

	void trans_store(const llvm::StoreInst&);
	void trans_alloca(const llvm::AllocaInst&);
	void trans_ret(const llvm::ReturnInst&);

	exprt get_expr(const llvm::Value&);
	exprt get_expr_const(const llvm::Constant&);
	exprt get_expr_cmp(const llvm::Instruction*);

	void move_symbol(symbolt&, symbolt*&);
	void add_argc_argv(const symbolt&);

	class symbol_util; ///<A sub-class to group all the symbol and type related methods.
	class scope_tree; ///<A sub-class to implement the scoping rules.

public:
	translator(std::unique_ptr<llvm::Module> &M) :
			llvm_module { M } {
	}
	bool generate_goto();
	void write_goto(const std::string&);
};

#endif /* TRANSLATOR_H */
