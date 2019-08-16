/*
 * preprocess.cpp
 *
 *  Created on: 16-Aug-2019
 *      Author: Akash Banerjee
 */
#include "llvm2goto.h"

std::unique_ptr<llvm::Module> ll2gb::get_llvm_ir(std::string in_irfile) {
	static llvm::LLVMContext context;
	llvm::SMDiagnostic err;
	auto M = llvm::parseIRFile(in_irfile, err, context);

	if (!M) {
		err.print(in_irfile.c_str(), llvm::errs());
		exit(1);
	}
	llvm::dbgs() << "IR File Successfully read!\n";
	return M;
}
