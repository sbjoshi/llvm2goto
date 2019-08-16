/*
 * llvm2goto_translator.cpp
 *
 *  Created on: 21-Feb-2019
 *      Author: Akash Banerjee
 */

#include "llvm2goto.h"

using namespace ll2gb;

void translator::add_global_symbols() {

}

bool translator::generate_goto() {
	llvm::dbgs() << "Generating GOTO Binary\n";
	initialize_goto();
	add_global_symbols();
	for (auto F = llvm_module->getFunctionList().begin();
			F != llvm_module->getFunctionList().end(); F++) {
		F->dump();
	}
	llvm::dbgs() << "GOTO Binary generated successfully\n";
	return true;
}
