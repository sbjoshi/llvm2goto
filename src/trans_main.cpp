/* Copyright
Author : Rasika

*/
#if 1
#include <iostream>
#include <memory>

#include "llvm2goto_translator.h"
// #include "scope.h"
// #include "entry_point.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/IR/LLVMContext.h"

#include "goto-programs/goto_functions.h"

using namespace llvm;

int main(int argc, char **argv)
{
  std::string filename="";
  if(argc < 2)
  {
  errs() << "Usage: " << argv[0] << " <llvm IR file>\n";
  return 1;
  }
  for(int i=1; i<argc; i++)
  {
    if(argv[i][0] == '-')
    {
      if(argv[i][1] == 'o')
      {
          i++;
          filename = argv[i];
      }
      else
      {
          errs() << "unknown option " << argv[i] << "\n";
          return 1;
      }
    }
  }
  // Parse the input LLVM IR file into a module.
  SMDiagnostic Err;
  LLVMContext Context;
  std::unique_ptr<Module> Mod(parseIRFile(argv[1], Err, Context));
  Module *M = Mod.get();
  if(!Mod)
  {
    errs() << "\nThere is something wrong with the IR file.\n";
  Err.print(argv[0], errs());
  return 1;
  }
  NamedMDNode *NMD = M->getNamedMetadata("llvm.dbg.cu");
  if(cast<DICompileUnit>(NMD->getOperand(0))->isOptimized())
  {
    errs() << "Please turn off all the optimization flags.\n";
    return 1;
  }
  llvm2goto_translator llvm2goto = llvm2goto_translator(M);
  llvm2goto.trans_Program(filename);
  return 0;
}
#endif
