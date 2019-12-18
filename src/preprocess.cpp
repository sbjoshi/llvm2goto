/*
 * preprocess.cpp
 *
 *  Created on: 16-Aug-2019
 *      Author: Akash Banerjee
 */
#include "ll2gb.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

///Return an llvm ir from input file_name.
///LLVMContext is provided separately,
///to provide support for translating
///multiple irs at once.
unique_ptr<Module> ll2gb::get_llvm_ir(string in_irfile, LLVMContext &context) {
	if (verbose) {
		outs().changeColor(raw_ostream::Colors::SAVEDCOLOR, true);
		outs() << "Reading llvm IR: " << in_irfile;
		outs().resetColor();
	}
	SMDiagnostic err;
	auto M = parseIRFile(in_irfile, err, context);

	if (!M) {
		if (!verbose) {
			outs().changeColor(raw_ostream::Colors::SAVEDCOLOR, true);
			outs() << "Reading llvm IR: " << in_irfile;
			outs().resetColor();
		}
		outs() << "  [";
		outs().changeColor(outs().RED, true);
		outs() << "FAILED";
		outs().resetColor();
		outs() << "]\n";
		err.print(in_irfile.c_str(), outs());
		exit(1);
	}
	if (verbose) {
		outs() << "  [";
		outs().changeColor(raw_ostream::Colors::GREEN, true);
		outs() << "OK";
		outs().resetColor();
		outs() << "]\n";
	}
	return M;
}
