/*
 * translator.h
 *
 *  Created on: 20-Aug-2019
 *      Author: Akash Banerjee
 */

#ifndef TRANSLATOR_H
#define TRANSLATOR_H

#include "ll2gb.h"

class ll2gb::translator {
private:
	std::unique_ptr<llvm::Module> &llvm_module;
	goto_programt goto_program;
	goto_functionst goto_functions;
	static symbol_tablet symbol_table;

	std::map<const llvm::Instruction*, std::string> var_name_map; ///<map from instructions to their symbol names
	std::map<const llvm::InsertValueInst*, exprt> ins_value_name_map; ///<map from instructions to their symbol names
	static std::map<const llvm::Argument*, std::string> func_arg_name_map; ///<map from func args to their symbol names
	std::map<const llvm::AllocaInst*, llvm::DbgDeclareInst*> alloca_dbg_map; ///<map from Allocas to their DbgDeclare if exists
	std::map<const llvm::CallInst*, std::string> call_ret_sym_map; ///<map from Call Instructions to their return symbol names
	std::map<const llvm::BasicBlock*, goto_programt::targett> block_target_map; ///<map from BB to first goto target for that block
	std::map<const llvm::BranchInst*,
			std::pair<goto_programt::targett, goto_programt::targett>> br_instr_target_map; ///<map from BranchInst to their goto targets
	std::map<const llvm::SwitchInst*, std::vector<goto_programt::targett>> switch_instr_target_map; ///<map from SwitchInst to their goto targets
	static std::map<llvm::DIScope*, std::string> scope_name_map;

	bool trans_instruction(const llvm::Instruction&);
	bool trans_block(const llvm::BasicBlock&);
	void set_branches();
	void set_switches();
	bool trans_function(llvm::Function&);
	bool trans_module();
	void analyse_ir();
	void add_function_symbols();
	void add_global_symbols();
	void add_initial_symbols();
	void set_config();
	void initialize_goto() {
		register_language(new_ansi_c_language);
		set_config();
		add_initial_symbols();
	}
	void add_malloc_support(bool reset_status = false);

	void trans_alloca(const llvm::AllocaInst&);
	void trans_br(const llvm::BranchInst&);
	void trans_call(const llvm::CallInst&);
	void trans_call_llvm_intrinsic(const llvm::IntrinsicInst&);
	void trans_insertvalue(const llvm::InsertValueInst&);
	void trans_ret(const llvm::ReturnInst&);
	void trans_store(const llvm::StoreInst&);
	void trans_switch(const llvm::SwitchInst&);

	exprt get_expr(const llvm::Value&);

	exprt get_expr_phi(const llvm::PHINode&);
	exprt get_expr_extractvalue(const llvm::ExtractValueInst&);
	exprt get_expr_gep(const llvm::GetElementPtrInst&);
	exprt get_expr_bitcast(const llvm::BitCastInst&);
	exprt get_expr_fcmp(const llvm::FCmpInst&);
	exprt get_expr_icmp(const llvm::ICmpInst&);
	exprt get_expr_trunc(const llvm::TruncInst&);
	exprt get_expr_load(const llvm::LoadInst&);
	exprt get_expr_add(const llvm::Instruction&);
	exprt get_expr_sub(const llvm::Instruction&);
	exprt get_expr_mul(const llvm::Instruction&);
	exprt get_expr_sdiv(const llvm::Instruction&);
	exprt get_expr_udiv(const llvm::Instruction&);
	exprt get_expr_and(const llvm::Instruction&);
	exprt get_expr_or(const llvm::Instruction&);
	exprt get_expr_xor(const llvm::Instruction&);
	exprt get_expr_shl(const llvm::Instruction&);
	exprt get_expr_lshr(const llvm::Instruction&);
	exprt get_expr_ashr(const llvm::Instruction&);
	exprt get_expr_zext(const llvm::ZExtInst&);
	exprt get_expr_sext(const llvm::SExtInst&);
	exprt get_expr_fpext(const llvm::FPExtInst&);
	exprt get_expr_fptosi(const llvm::FPToSIInst&);
	exprt get_expr_sitofp(const llvm::SIToFPInst&);
	exprt get_expr_fptoui(const llvm::FPToUIInst&);
	exprt get_expr_uitofp(const llvm::UIToFPInst&);
	exprt get_expr_fptrunc(const llvm::FPTruncInst&);
	exprt get_expr_ptrtoint(const llvm::PtrToIntInst&);
	exprt get_expr_inttoptr(const llvm::IntToPtrInst&);
	exprt get_expr_const(const llvm::Constant&);
	exprt get_expr_select(const llvm::SelectInst&);

	void move_symbol(symbolt&, symbolt*&);
	void add_argc_argv(const symbolt&);

	source_locationt get_location(const llvm::Instruction&);

	class symbol_util; ///<A sub-class to group all the symbol and type related methods.
	class scope_tree; ///<A sub-class to implement the scoping rules.

public:
	static std::string error_state; ///< If any error is encountered, the errmsg is stored in this string.
	translator(std::unique_ptr<llvm::Module> &M) :
			llvm_module { M } {
	}
	bool generate_goto();
	void write_goto(const std::string&);

	/// If the 'error_state' is not empty, then error has been encountered.
	static bool check_state() {
		return !error_state.empty();
	}
	~translator();
};

#endif /* TRANSLATOR_H */
