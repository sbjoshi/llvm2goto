/* Copyright


*/
/*
code_function_callt f;
    // we don't bother setting the type
    f.lhs()=cf.lhs();
    f.function()=symbol_exprt("pthread_create", code_typet());
    exprt n=null_pointer_exprt(pointer_typet(empty_typet()));
    f.arguments().push_back(n);
    f.arguments().push_back(n);
    f.arguments().push_back(cf.function());
    f.arguments().push_back(cf.arguments().front());
*/
#if 0
#include "util/arith_tools.h"
#include "util/ieee_float.h"
#include "util/symbol_table.h"
#include "util/std_types.h"
#include "util/std_expr.h"
#include "util/source_location.h"
#include "langapi/mode.h"
// #include <string.h>
#include <iostream>
#include "ansi-c/ansi_c_language.h"
#include "goto-programs/goto_functions.h"
#include "goto-programs/goto_functions_template.h"



// 



int main(){

  symbol_tablet symbol_table;

  symbolt x;
  x.clear();
  x.is_static_lifetime=true;
  x.is_thread_local=false;
  const irep_idt x_bname = "x";
  const irep_idt x_name = "x";
  x.mode = ID_C;
  x.name = x_name;
  x.base_name = x_bname;
  x.type = signedbv_typet(32);
  // x.value = from_integer(0,x.type);
  symbol_table.add(x);

  symbolt main;
  main.clear();
  main.is_static_lifetime=true;
  main.is_thread_local=false;
  const irep_idt main_bname = "main";
  const irep_idt main_name = "main";
  main.mode = ID_C;
  main.name = main_name;
  main.base_name = main_bname;
  code_typet ct = code_typet();
  code_typet::parameterst para;
  code_typet::parametert p1(x.type);
  para.push_back(p1);
  ct.parameters() = para;
  ct.return_type() = unsignedbv_typet(32);
  // static_cast<unsignedbv_typet &>(rt);
  main.type = ct;
  // main.value = from_integer(0,main.type);
  symbol_table.add(main);

  symbolt y;
  y.clear();
  y.is_static_lifetime=true;
  y.is_thread_local=false;
  const irep_idt y_bname = "y";
  const irep_idt y_name = "y";
  y.mode = ID_C;
  y.name = y_name;
  y.base_name = y_bname;
  y.type = signedbv_typet(32);
  // y.value = from_integer(1,y.type);
  symbol_table.add(y);

  symbolt z;
  z.clear();
  z.is_static_lifetime=true;
  z.is_thread_local=false;
  const irep_idt z_bname = "z";
  const irep_idt z_name = "z";
  z.mode = ID_C;
  z.name = z_name;
  z.base_name = z_bname;
  z.type = signedbv_typet(32);
  // z.value = from_integer(2,z.type);
  symbol_table.add(z);

  symbolt v1;
  v1.clear();
  v1.is_static_lifetime=true;
  v1.is_thread_local=false;
  const irep_idt v1_bname = "v1";
  const irep_idt v1_name = "v1";
  v1.mode = ID_C;
  v1.name = v1_name;
  v1.base_name = v1_bname;
  v1.type = unsignedbv_typet(32);
  v1.value = from_integer(3,v1.type);
  symbol_table.add(v1);

  symbolt v2;
  v2.clear();
  v2.is_static_lifetime=true;
  v2.is_thread_local=false;
  const irep_idt v2_bname = "v2";
  const irep_idt v2_name = "v2";
  v2.mode = ID_C;
  v2.name = v2_name;
  v2.base_name = v2_bname;
  v2.type = unsignedbv_typet(32);
  v2.value = from_integer(4,v2.type);
  symbol_table.add(v2);

  namespacet ns(symbol_table);
  register_language(new_ansi_c_language);

  ns.get_symbol_table().show(std::cout);

  goto_programt xz;
  goto_programt::targett xz_ins = xz.add_instruction();
   
  //build x=z
  xz_ins->make_assignment();
  xz_ins->code = code_assignt(x.symbol_expr(),mod_exprt(y.symbol_expr(),z.symbol_expr()));
  // std::cout << "\nhello    " << (mod_exprt(y.symbol_expr(),z.symbol_expr())).pretty() << "\n............................................\n";
  // std::cout << "\nhello    " << (plus_exprt(y.symbol_expr(),z.symbol_expr())).pretty() << "\n............................................\n";
  // from_expr(ns, "main", xz_ins->code);
  std::cout << " xz ....\n";
  xz.update();
  xz.output(ns, "x", std::cout);
  std::cout << "xz................\n";
  xz.output(std::cout);
   
  // build x=y;skip;
  goto_programt xy;
  goto_programt::targett xy_ins = xy.add_instruction();
  xy_ins->make_assignment();
  xy_ins->code = code_assignt(x.symbol_expr(),y.symbol_expr());
  // goto_programt::targett sk1_ins = xy.add_instruction();
  // sk1_ins->make_skip();
  xy.update();
  std::cout << "xy................\n";
  xy.output(std::cout);
  // xy.output(ns, "x", std::cout);
   
  //jump to skip after x=z
  goto_programt::targett tmp1_ins = xz.add_instruction();
  tmp1_ins->make_goto(xy_ins);
   
   
  //build if(v1==v2) then jump to x=y
  goto_programt v;
  goto_programt::targett v_ins = v.add_instruction();
  v_ins->make_goto(xy_ins);
  exprt guard = exprt(ID_lt);
  guard.copy_to_operands(v1.symbol_expr(), v2.symbol_expr());
  v_ins->guard = guard;
  // v_ins->guard = equal_exprt(v1.symbol_expr(),v2.symbol_expr());

  v.destructive_append(xz);
  v.destructive_append(xy);

  goto_programt::targett v_ins1 = v.add_instruction();
  v_ins1->guard = equal_exprt(z.symbol_expr(),y.symbol_expr());
  v_ins1->make_assumption(v_ins1->guard);

  // goto_programt::targett asech = v.add_instruction();
  // asech->guard = equal_exprt(v1.symbol_expr(), z.symbol_expr());
  // asech->make_assertion(asech->guard);
  // asech->code = code_assertt(asech->guard);

  /*goto_programt::targett ifelse = v.add_instruction();
  // ifelse->make_ifthenelse();
  ifelse->make_goto(xy_ins);
  code_ifthenelset mewwwwwwwwwww;
  mewwwwwwwwwww.cond() = equal_exprt(z.symbol_expr(),y.symbol_expr());
  mewwwwwwwwwww.then_case() = code_assignt(x.symbol_expr(), plus_exprt(y.symbol_expr(), from_integer(1,y.type)));
  mewwwwwwwwwww.else_case() = code_assignt(x.symbol_expr(), plus_exprt(y.symbol_expr(), from_integer(10,y.type)));
  ifelse->code = mewwwwwwwwwww;*/
  v.update();

  std::cout << "v.................\n";
  v.output(ns, "x", std::cout);


  goto_functionst goto_functions;
  // goto_programt gp;
  goto_functions.function_map.insert(
      std::pair<const dstringt, goto_functionst::goto_functiont >(dstringt("main"),
        goto_functionst::goto_functiont()));
  std::cout << "\nname :" << (*goto_functions.function_map.find(dstringt("main"))).first.c_str();
  (*goto_functions.function_map.find(dstringt("main"))).second.body.swap(v);
  std::cout << "\n goto_functions:";
  goto_functions.output(ns,std::cout);
  // std::cout << "\n goto_functions.function_map.find(dstringt(\"main\"))->second:";
  // goto_functions.function_map.find(dstringt("main"))->second.output(std::cout);
  std::cout << "\n (*goto_functions.function_map.find(dstringt(\"main\"))).second.body:";
  (*goto_functions.function_map.find(dstringt("main"))).second.body.output(std::cout);
  std::cout << "(\"rem\" \"\" (\"symbol\" \"type\" (\"signedbv\" \"width\" (\"32\")) \"identifier\" (\"y\")) \"\" (\"symbol\" \"type\" (\"signedbv\" \"width\" (\"32\")) \"identifier\" (\"z\")) \"type\" (\"signedbv\" \"width\" (\"32\")))";

  return 0;
}

#endif
#if 1
#include <iostream>
#include <memory>

#include "llvm2goto_translator.h"
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
  llvm2goto_translator llvm2goto;
  llvm2goto.trans_Program(M);
  return 0;
}
#endif
