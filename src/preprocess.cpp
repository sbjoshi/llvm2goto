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
unique_ptr<Module> ll2gb::get_llvm_ir(LLVMContext &context) {
	if (verbose) {
		outs().changeColor(raw_ostream::Colors::SAVEDCOLOR, true);
		outs() << "Reading llvm IR: " << InputFilename;
		outs().resetColor();
	}
	SMDiagnostic err;
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

bool ll2gb::run_llvm_passes(Module &llvm_module) {
//	if (optimizeEnabled) {
//		static cl::opt<bool> DebugPM("debug-pass-manager",
//				cl::Hidden,
//				cl::desc("Print pass management debugging information"));
//		static cl::opt<std::string> AAPipeline("aa-pipeline",
//				cl::desc("A textual description of the alias analysis "
//						"pipeline for handling managed aliasing queries"),
//				cl::Hidden);
//		PassBuilder PB;
//		StringRef Arg0;
//		AAManager AA;
//		if (auto Err = PB.parseAAPipeline(AA, AAPipeline)) {
//			translator::error_state = Arg0.str() + ": " + toString(move(Err));
//			return true;
//		}
//
//		LoopAnalysisManager LAM(DebugPM);
//		FunctionAnalysisManager FAM(DebugPM);
//		CGSCCAnalysisManager CGAM(DebugPM);
//		ModuleAnalysisManager MAM(DebugPM);
//		ModulePassManager MPM(DebugPM);
//		FunctionPassManager FPM(DebugPM);
//
//		PB.registerModuleAnalyses(MAM);
//		PB.registerCGSCCAnalyses(CGAM);
//		PB.registerFunctionAnalyses(FAM);
//		PB.registerLoopAnalyses(LAM);
//		PB.crossRegisterProxies(LAM, FAM, CGAM, MAM);
//
//		StringRef ModulePassPipeline("ipsccp,globaldce");
//		if (auto Err = PB.parsePassPipeline(MPM,	//Run all the Module level passes.
//				ModulePassPipeline,
//				false,
//				DebugPM)) {
//			translator::error_state = Arg0.str() + ": " + toString(std::move(Err));
//			return true;
//		}
//		MPM.run(llvm_module, MAM);
//
//		StringRef FunctionPassPipeline("mem2reg,loop-simplify,jump-threading,require<domtree>,require<aa>,require<assumptions>,require<loops>,require<memoryssa>,require<scalar-evolution>,lcssa");
//		if (auto Err = PB.parsePassPipeline(FPM,
//				FunctionPassPipeline,
//				false,
//				DebugPM)) {
//			translator::error_state = Arg0.str() + ": " + toString(std::move(Err));
//			return true;
//		}
//
//		for (auto &F : llvm_module) {
//			if (F.isDeclaration()) continue;
//			FPM.run(F, FAM);
//			//It is much easier to run Loop Passes in the following manner instead of
//			//using the LoopPassManager.
//			FunctionToLoopPassAdaptor<LoopStrengthReducePass> str_reduce_pass {
//					LoopStrengthReducePass() };
//			str_reduce_pass.run(F, FAM);
//			FunctionToLoopPassAdaptor<IndVarSimplifyPass> ind_vars_pass {
//					IndVarSimplifyPass() };
//			ind_vars_pass.run(F, FAM);
//		}
//
//		//The loop transform passes might introduce some bad code,
//		//this will help clean those up.
//		MPM.run(llvm_module, MAM);
//		for (auto &F : llvm_module) {
//			if (F.isDeclaration()) continue;
//			FPM.run(F, FAM);
//		}
//	}

	legacy::FunctionPassManager FPM(&llvm_module);
	legacy::PassManager MPM;
	if (optimizeEnabled) {
		MPM.add(createPromoteMemoryToRegisterPass());
		MPM.add(createLoopSimplifyPass());
		MPM.add(createLoopRotatePass());
		MPM.add(createIndVarSimplifyPass());
		MPM.add(createLoopStrengthReducePass());
		MPM.add(createDeadArgEliminationPass());
		MPM.add(createGlobalDCEPass());
		MPM.add(createIPSCCPPass());
		MPM.add(createDeadInstEliminationPass());
		MPM.add(createIPConstantPropagationPass());
		FPM.add(createEarlyCSEPass());
		FPM.add(createConstantPropagationPass());
		FPM.add(createAggressiveDCEPass());
		FPM.add(createInstructionCombiningPass());
		FPM.add(createSCCPPass());
		FPM.add(createJumpThreadingPass());
	}
	FPM.add(createDemoteRegisterToMemoryPass());
	MPM.run(llvm_module);
	for (auto &F : llvm_module)
		FPM.run(F);

	return false;
}
