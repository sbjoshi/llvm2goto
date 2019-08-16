/*
 * llvm2goto.h
 *
 *  Created on: 21-Feb-2019
 *      Author: Akash Banerjee
 */

#ifndef LLVM2GOTO_H
#define LLVM2GOTO_H

#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm-c/Core.h>

#include <goto-programs/goto_model.h>
#include <util/config.h>
#include <util/c_types.h>
#include <util/arith_tools.h>
#include <linking/static_lifetime_init.h>

namespace ll2gb {

class translator {
private:
	std::unique_ptr<llvm::Module> &llvm_module;
	goto_modelt goto_model;
	symbol_tablet symbol_table;
	std::map<std::string, std::string> var_name_map; //map from unique names to their base_name(pretty_name)

	void write_goto(char *op_name);
	void add_global_symbols();
	void set_config();
	void add_initial_symbols();
	void initialize_goto() {
		set_config();
		add_initial_symbols();
	}

public:
	translator(std::unique_ptr<llvm::Module> &M) :
			llvm_module { M } {
	}
	bool generate_goto();
};

std::unique_ptr<llvm::Module> get_llvm_ir(std::string in_irfile);

void print_help();
void parse_input(int argc,
		char **argv,
		std::string &in_irfile,
		std::string &out_gbfile);
}

#endif /* LLVM2GOTO_H */
