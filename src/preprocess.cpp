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

bool ll2gb::run_llvm_passes(Module &llvm_module) {

	legacy::FunctionPassManager FPM(&llvm_module);
	FPM.add(createDemoteRegisterToMemoryPass());
	for (auto &F : llvm_module)
		FPM.run(F);

	legacy::PassManager PM;
	PM.add(createIPSCCPPass());
	PM.add(createGlobalDCEPass());
	PM.run(llvm_module);

//	static cl::opt<bool> DebugPM("debug-pass-manager",
//			cl::Hidden,
//			cl::desc("Print pass management debugging information"));
//	static cl::opt<std::string> AAPipeline("aa-pipeline",
//			cl::desc("A textual description of the alias analysis "
//					"pipeline for handling managed aliasing queries"),
//			cl::Hidden);
//	PassBuilder PB;
//	StringRef Arg0;
//	AAManager AA;
//	if (auto Err = PB.parseAAPipeline(AA, AAPipeline)) {
//		translator::error_state = Arg0.str() + ": " + toString(move(Err));
//		return true;
//	}
//
//	LoopAnalysisManager LAM(DebugPM);
//	FunctionAnalysisManager FAM(DebugPM);
//	CGSCCAnalysisManager CGAM(DebugPM);
//	ModuleAnalysisManager MAM(DebugPM);
//	ModulePassManager MPM(DebugPM);
//	FunctionPassManager FPM(DebugPM);
//
//	FAM.registerPass([&] {return std::move(AA);});
//
//	PB.registerModuleAnalyses(MAM);
//	PB.registerCGSCCAnalyses(CGAM);
//	PB.registerFunctionAnalyses(FAM);
//	PB.registerLoopAnalyses(LAM);
//	PB.crossRegisterProxies(LAM, FAM, CGAM, MAM);
//
//	StringRef ModulePassPipeline("ipsccp,globaldce");
//	if (auto Err = PB.parsePassPipeline(MPM,		//Run all the Module level passes.
//			ModulePassPipeline,
//			false,
//			DebugPM)) {
//		translator::error_state = Arg0.str() + ": " + toString(std::move(Err));
//		return true;
//	}
//	MPM.run(llvm_module, MAM);
//
//	StringRef FunctionPassPipeline("dce,reg2mem");
//	if (auto Err = PB.parsePassPipeline(FPM,
//			FunctionPassPipeline,
//			false,
//			DebugPM)) {
//		translator::error_state = Arg0.str() + ": " + toString(std::move(Err));
//		return true;
//	}
//	FPM.addPass(createDemoteRegisterToMemoryPass());
//	for (auto &F : llvm_module) {
//		FPM.run(F, FAM);
//	}

	return false;
}
