#if 0
int main(int argc, const char **argv)
{
  cbmc_parse_optionst parse_options(argc, argv);

  int res=parse_options.main();


  return 0;
}
cbmc/cbmc_parse_options.h
goto-cc/compile.h
cbmc/bmc.cpp:  languagest languages(ns, new_ansi_c_language());
#endif
#if 0
#include "util/symbol.h"
#include "util/symbol_table.h"
#include "util/std_types.h"
#include "util/arith_tools.h"
#include "util/std_expr.h"
#include "goto-programs/goto_functions.h"
#include "iostream"
#include <fstream>
#include <langapi/languages.h>
#include "langapi/mode.h"
#include "goto-programs/goto_convert_functions.h"
#include <util/ui_message.h>
int main(){
  std::cout << "hello\n";
  symbol_tablet symbol_table;
  symbolt thread_counter;
  thread_counter.clear();
  thread_counter.is_static_lifetime=true;
  thread_counter.is_thread_local=false;
  const irep_idt tmp_bname = "tid";
  const irep_idt tmp_name = "tid";
  thread_counter.mode = ID_C;
  thread_counter.name = tmp_name;
  thread_counter.base_name = tmp_bname;
  thread_counter.type = unsignedbv_typet(8);
  thread_counter.value = from_integer(0,thread_counter.type);
  symbol_table.add(thread_counter);
  goto_functionst goto_functions;
  symbol_table.show(std::cout);
  namespacet ns(symbol_table);
  std::string filename = "demo.c";
  // std::string filename=cmdline.args[0]
  std::cout << "\nhi\n";
  // #ifdef _MSC_VER
  // std::ifstream infile(widen(filename));
  // #else
  std::ifstream infile(filename);
  std::cout << "\nhi\n";
  // #endif
  languaget *language=get_language_from_filename(filename);
  std::cout << "\nhi" << language << " " << infile.is_open() <<" \n";
  // ui_message_handlert ui_message_handler(cmdline, "CBMC " CBMC_VERSION);
  // goto_convert(symbol_table, goto_functions, ui_message_handler);

        if(language->parse(infile, filename))
      {
        std::cout << "PARSING ERROR" << "\n";
        std::cout << "\nhi\n";
        return 6;
      }

  /*    language->show_parse(std::cout);
      std::cout << "\nhi\n";
  goto_functions.output(ns,std::cout);
  std::cout << "\nhi\n";*/
  std::cout << "bye\n";
      return 0;
}
#endif
#if 1
/* Copyright


*/
#include "llvm2goto_translator.h"
// #include <string>
#include <iostream>
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
#include "llvm/IR/DebugInfoMetadata.h"
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
  if(cast<DICompileUnit>(NMD->getOperand(0))->isOptimized()) {
    errs() << "Please turn off all the optimization flags.\n";
    return 1;
  }
  llvm2goto_translator llvm2goto;
  llvm2goto.trans_Program(M);
  return 0;
}
#endif