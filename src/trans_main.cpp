/* Copyright


*/
#include <iostream>
#include <memory>
#include "llvm2goto_translator.h"
// #include <string>
// #include <list>
// #include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/SourceMgr.h"
// #include "llvm/IR/Function.h"
#include "llvm/IR/LLVMContext.h"
// #include "llvm/IR/Instructions.h"
// #include "llvm/IR/Attributes.h"
// #include "llvm/IR/IntrinsicInst.h"
// #include "llvm/IR/DebugInfoMetadata.h"
#include "goto-programs/goto_functions.h"

using namespace llvm;

int main(int argc, char **argv) {
  if (argc < 2) {
  errs() << "Usage: " << argv[0] << " <llvm IR file>\n";
  return 1;
  }
  // Parse the input LLVM IR file into a module.
  SMDiagnostic Err;
  LLVMContext Context;
  std::unique_ptr<Module> Mod(parseIRFile(argv[1], Err, Context));
  Module *M = Mod.get();
  if (!Mod) {
    errs() << "\nThere is something wrong with the IR file.\n";
  Err.print(argv[0], errs());
  return 1;
  }
  NamedMDNode *NMD = M->getNamedMetadata("llvm.dbg.cu");
  if (cast<DICompileUnit>(NMD->getOperand(0))->isOptimized()) {
    errs() << "Please turn off all the optimization flags.\n";
    return 1;
  }
  llvm2goto_translator llvm2goto;
  llvm2goto.trans_Program(M);
  return 0;
}
