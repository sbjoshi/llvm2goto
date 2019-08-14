/*
 * llvm2goto.h
 *
 *  Created on: 21-Feb-2019
 *      Author: akash
 */

#ifndef LLVMaaa2GOTO_H_
#define LLVMaaa2GOTO_H_

#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm-c/Core.h>

#include <goto-programs/goto_model.h>
namespace ll2gb {

class translator {

	std::unique_ptr<llvm::Module> &llvm_module;
	goto_modelt gb;

public:
	translator(std::unique_ptr<llvm::Module> &M) :
			llvm_module { M } {
	}

	bool generate_goto();
	void print_help();
	void write_goto(char *op_name);
};

void print_help();
}

#endif /* LLVM2GOTO_H_ */
