/* Copyright


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
  llvm2goto_translator llvm2goto = llvm2goto_translator(M);
  llvm2goto.trans_Program();
  // scope::calculate_scope(*M);
  return 0;
}
#endif

#if 0
#include "util/arith_tools.h"
#include "util/cmdline.h"
#include "goto-cc/compile.h"
#include "linking/static_lifetime_init.h"
#include "langapi/mode.h"
#include <iostream>
#include "ansi-c/ansi_c_entry_point.h"
#include "ansi-c/ansi_c_language.h"

goto_programt block_to_prog(code_blockt cb) {
  goto_programt gp;
  for (unsigned int b = 0; b < cb.operands().size(); b++) {
    goto_programt::targett ins = gp.add_instruction();
    codet c = to_code(cb.operands()[b]);
    if(ID_assign == c.get_statement()) {
      ins->make_assignment();
      ins->code = code_assignt(c.operands()[0],c.operands()[1]);
    } else if(ID_output == c.get_statement()) {
      ins->make_other(c);
    } else if(ID_label == c.get_statement()) {
      ins->make_skip();
    } else if(ID_function_call == c.get_statement()) {
      ins->make_function_call(c);
    } else {
      ins->code = c;
    }
  }
  gp.add_instruction(END_FUNCTION);
  gp.update();
  return gp;
}

int main() {
  symbol_tablet symbol_table;

  symbolt x;
  // x.clear();
  // thread_counter.is_static_lifetime=true;
  const irep_idt x_bname = "x";
  const irep_idt x_name = "x";
  x.mode = ID_C;
  x.name = x_name;
  x.base_name = x_bname;
  x.type = signedbv_typet(32);
  x.value = from_integer(0,x.type);
  symbol_table.add(x);

  symbolt main;
  // main.clear();
  const irep_idt main_bname = "main";
  const irep_idt main_name = "main";
  main.mode = ID_C;
  main.name = main_name;
  main.base_name = main_bname;
  code_typet ct = code_typet();
  ct.return_type() = unsignedbv_typet(32);
  main.type = ct;
  symbol_table.add(main);

  symbolt initialize_function;
  // initialize_function.clear();
  const irep_idt initialize_function_bname = INITIALIZE_FUNCTION;
  const irep_idt initialize_function_name = INITIALIZE_FUNCTION;
  initialize_function.mode = ID_C;
  initialize_function.name = initialize_function_name;
  initialize_function.base_name = initialize_function_bname;
  initialize_function.type = ct;
  symbol_table.add(initialize_function);

  goto_functionst goto_functions;

  
  goto_programt v;
  code_blockt block;
  goto_programt::targett decl_x = v.add_instruction();
  decl_x->make_decl();
  decl_x->code=code_declt(x.symbol_expr());
  block.add(decl_x->code);
  goto_programt::targett assert_inst = v.add_instruction();
  assert_inst->make_assertion(equal_exprt(x.symbol_expr(),from_integer(0,x.type)));
  block.add(assert_inst->code);
  goto_programt::targett ret_inst = v.add_instruction();
  code_returnt cret;
  cret.return_value() = from_integer(0, x.type);
  ret_inst->make_return();
  ret_inst->code = cret;
  block.add(ret_inst->code);
  goto_programt::targett ef = v.add_instruction(END_FUNCTION);
  block.add(ef->code);
  v.update();
  symbol_table.lookup("main").value.swap(block);

  goto_functions.function_map.insert(
      std::pair<const dstringt, goto_functionst::goto_functiont >(dstringt("main"),
        goto_functionst::goto_functiont()));
  (*goto_functions.function_map.find(dstringt("main"))).second.body.swap(v);
  message_clientt mct;
  ansi_c_entry_point(symbol_table, "main", mct.get_message_handler());
  goto_functions.function_map.insert(
    std::pair<const dstringt, goto_functionst::goto_functiont >(INITIALIZE_FUNCTION,
    goto_functionst::goto_functiont()));
  code_blockt initialize_function_block = to_code_block(to_code(symbol_table.lookup(INITIALIZE_FUNCTION).value));
  goto_programt v1 = block_to_prog(initialize_function_block);
  (*goto_functions.function_map.find(INITIALIZE_FUNCTION)).second.body.swap(v1);

  goto_functions.function_map.insert(
    std::pair<const dstringt, goto_functionst::goto_functiont >("_start",
    goto_functionst::goto_functiont()));
  code_blockt _start_block = to_code_block(to_code(symbol_table.lookup("_start").value));
  goto_programt v2 = block_to_prog(_start_block);
  goto_functions.function_map.insert(
    std::pair<const dstringt, goto_functionst::goto_functiont >("_start",
      goto_functionst::goto_functiont()));
  (*goto_functions.function_map.find("_start")).second.body.swap(v2);

  namespacet ns(symbol_table);
  register_language(new_ansi_c_language);

  symbol_table.show(std::cout);
  goto_functions.output(ns, std::cout);

  cmdlinet cmdline;
  compilet compile(cmdline);
  compile.write_object_file("mew.goto", symbol_table, goto_functions);
}
#endif
