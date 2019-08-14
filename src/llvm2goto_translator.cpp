/*
 * llvm2goto_translator.cpp
 *
 *  Created on: 21-Feb-2019
 *      Author: akash
 */

#include "llvm2goto.h"

using namespace ll2gb;

bool translator::generate_goto() {

	for (auto F = llvm_module->getFunctionList().begin();
			F != llvm_module->getFunctionList().end(); F++) {
		F->dump();
	}
	return false;
}

void ll2gb::print_help() {
	llvm::outs() << "Version: 2.0\n"
			<< "Usage: llvm2goto <ir_file> -o <op_file_name>\n";
}
