/*
 * preprocess.cpp
 *
 *  Created on: 16-Aug-2019
 *      Author: Akash Banerjee
 */
#include "ll2gb.h"
#include "translator.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

///Return an llvm ir from input file_name.
///LLVMContext is provided separately.
unique_ptr<Module> ll2gb::get_llvm_ir() {
	if (verbose) {
		outs().changeColor(raw_ostream::Colors::SAVEDCOLOR, true);
		outs() << "Reading llvm IR: " << InputFilename;
		outs().resetColor();
	}
	SMDiagnostic err;
	static LLVMContext context;
	auto M = parseIRFile(InputFilename, err, context);

	if (!M) {
		if (!verbose) {
			outs().changeColor(raw_ostream::Colors::SAVEDCOLOR, true);
			outs() << "Reading llvm IR: " << InputFilename;
			outs().resetColor();
		}
		outs() << "  [";
		outs().changeColor(outs().RED, true);
		outs() << "FAILED";
		outs().resetColor();
		outs() << "]\n";
		err.print(InputFilename.c_str(), outs());
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

void translator::check_optimizations_safe(const Module &llvm_module) {
	if (!optimizeEnabled || (optimizeForced && optimizeEnabled)) return;
	for (auto &F : llvm_module)
		for (auto &BB : F)
			for (auto &I : BB) {
				if (isa<CallInst>(&I)) {
					auto &CI = cast<CallInst>(I);
					switch (get_intrinsic_id(CI.getCalledValue()->stripPointerCasts()->getName().str())) {
					case intrinsics::fegetround:
					case intrinsics::fesetround:
						optimizeEnabled = false;
						return;
					default:
						;
					}
				}
			}
}

bool ll2gb::run_llvm_passes(Module &llvm_module) {
	translator::check_optimizations_safe(llvm_module);
	if (optimizeEnabled) {
		if (verbose) {
			outs().changeColor(raw_ostream::Colors::SAVEDCOLOR, true);
			outs() << "Optimizer ";
			outs().resetColor();
			outs().changeColor(raw_ostream::Colors::GREEN, true);
			outs() << "Enabled\n";
			outs().resetColor();
		}
		legacy::FunctionPassManager FPM(&llvm_module);
		legacy::PassManager MPM;
		PassManagerBuilder PM;
		PM.OptLevel = 1;
		PM.SizeLevel = 0;
		PM.LoopVectorize = false;
		PM.SLPVectorize = false;
		PM.DisableUnrollLoops = true;
		PM.Inliner = createAlwaysInlinerLegacyPass();
		PM.populateFunctionPassManager(FPM);
		PM.populateModulePassManager(MPM);
		FPM.doInitialization();
		for (auto &F : llvm_module)
			FPM.run(F);
		FPM.doFinalization();
		MPM.run(llvm_module);
	}

	legacy::FunctionPassManager FPM(&llvm_module);
	FPM.add(createDemoteRegisterToMemoryPass());

	FPM.doInitialization();
	for (auto &F : llvm_module)
		FPM.run(F);
	FPM.doFinalization();

	if (verbose >= 10 && optimizeEnabled) {
		outs().changeColor(outs().BLUE, true);
		outs() << "LLVM IR: ";
		outs().resetColor();
		outs().changeColor(outs().SAVEDCOLOR, true);
		outs() << llvm_module.getName() << " - Optimized:\n";
		outs().changeColor(outs().YELLOW, true);
		outs() << "------------------------------------------------------\n";
		outs().resetColor();
		outs() << llvm_module << '\n';
		outs().changeColor(outs().YELLOW, true);
		outs() << "------------------------------------------------------\n";
		outs().resetColor();
		outs().flush();
	}
	return false;
}
