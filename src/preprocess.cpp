/*
 * preprocess.cpp
 *
 *  Created on: 16-Aug-2019
 *      Author: Akash Banerjee
 */
#include "llvm2goto.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

unique_ptr<Module> ll2gb::get_llvm_ir(string in_irfile, LLVMContext &context) {
	SMDiagnostic err;
	auto M = parseIRFile(in_irfile, err, context);

	if (!M) {
		err.print(in_irfile.c_str(), errs());
		exit(1);
	}
	dbgs() << "IR File Successfully read!\n";
	return M;
}
