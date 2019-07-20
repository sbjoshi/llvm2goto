/* Copyright
 Author : Rasika

 */

#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm2goto_translator.h"

#include <llvm/IR/Type.h>
#include "llvm-c/Core.h"
#include "llvm/ADT/APFloat.h"

#include <utility>
#include <memory>
#include <string>
#include <map>

#include "symbol_creator.h"
#include "entry_point.h"
#include "scope.h"

#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Constants.h"
//#include "llvm/IR/ConstantsContext.h"
#include "langapi/mode.h"
//#include "solvers/cvc/cvc_conv.h"
#include "ansi-c/ansi_c_language.h"
#include "util/cmdline.h"
#include "goto-cc/compile.h"
#include "util/ieee_float.h"
#include <util/config.h>
#include <util/arith_tools.h>
#include <util/c_types.h>
#include "langapi/language_util.h"
#include <solvers/refinement/string_constraint_generator.h>

#include "goto-programs/write_goto_binary.h"
#include "util/config.h"

#include "pointer-analysis/dereference_callback.h"

using namespace llvm;

std::set<const symbolt*> gep_symbols;
// TODO(Rasika): handle global scope.
// TODO(Rasika): relation between array and pointer.
// TODO(Rasika): arr[5].

llvm2goto_translator::llvm2goto_translator(Module *M) {
  this->M = M;
}

llvm2goto_translator::~llvm2goto_translator() {
}

std::string llvm2goto_translator::get_var(std::string str) {
  while (var_name_map.find(str) == var_name_map.end()) {
    std::string::iterator i = str.end() - 1;
    while (*i != ':' && i >= str.begin()) {
      i--;
    }
    if (i < str.begin()) return str;
    str.erase(i);
    i--;
    str.erase(i);
    i--;
    while (*i != ':' && i >= str.begin()) {
      str.erase(i);
      i--;
    }
  }
  return str;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Ret

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Ret.

 Purpose: Map llvm::Instruction::Ret to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Ret(
    const Instruction *I, const symbol_tablet &symbol_table) {
  goto_programt gp;

  Value *ub = dyn_cast<ReturnInst>(I)->getReturnValue();
  if (!ub) {
    goto_programt::targett ret_inst = gp.add_instruction();
    ret_inst->make_skip();
    return gp;
  }
//  symbolt op1;
  const symbolt* op1 = nullptr;  //akash
  exprt exprt1;
// TODO(Rasika): handle other constant type.
  if (dyn_cast<Constant>(ub)) {
    if (const ConstantInt *cint = dyn_cast<ConstantInt>(ub)) {
      uint64_t val;
      val = cint->getZExtValue();
      const symbolt *func = symbol_table.lookup(
          I->getFunction()->getName().str());
      func->symbol_expr().type().pretty(2, 8);
      code_typet func_code = to_code_type(func->type);
      if (func_code.return_type().id() == ID_unsignedbv) {
        exprt1 = from_integer(val, unsignedbv_typet(config.ansi_c.int_width));
      }
      else if (func_code.return_type().id() == ID_signedbv) {
        exprt1 = from_integer(val, signedbv_typet(config.ansi_c.int_width));
      }
      else {
        from_integer(val, func_code.return_type());
      }
      // TODO(Rasika) : get the type from symbol_table.
      exprt1 = from_integer(val, signedbv_typet(config.ansi_c.int_width));
    }
    else if (dyn_cast<ConstantFP>(ub)) {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((ub)->getType());
      if (floattype->isFloatTy()) {
        float val = dyn_cast<ConstantFP>(ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl(float_type());
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      }
      else if (floattype->isDoubleTy()) {
        double val = dyn_cast<ConstantFP>(ub)->getValueAPF().convertToDouble();
        ieee_floatt ieee_fl(double_type());
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      }
      else {
        ub->dump();
        assert(
            false
                && "This floating point type in above instruction is not handled");
      }
    }
    else {
      ub->dump();
      assert(false && "This constant type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(ub)) {
//      op1 = symbol_table.lookup(
//          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
//              + li->getOperand(0)->getName().str());
      exprt1 = get_load(li, symbol_table, &op1);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
      // }
      // else
      // {
      //   exprt1 = op1.symbol_expr();
      // }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  goto_programt::targett ret_inst = gp.add_instruction();
  code_returnt cret;
  cret.return_value() = exprt1;

  ret_inst->make_return();
  ret_inst->code = cret;
  ret_inst->source_location = location;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Br

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Br.

 Purpose: Map llvm::Instruction::Br to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Br(
    const Instruction *I,
    symbol_tablet *symbol_table,
    std::map<const Instruction*, goto_programt::targett> &instruction_target_map) {
  goto_programt gp;
  I->dump();
  if (dyn_cast<BranchInst>(I)->getNumSuccessors() == 2) {
    goto_programt::targett br_ins = gp.add_instruction();
    instruction_target_map.insert(
        std::pair<const Instruction*, goto_programt::targett>(I, br_ins));
    gp.update();
  }
  else {
    goto_programt::targett br_ins = gp.add_instruction();
    instruction_target_map.insert(
        std::pair<const Instruction*, goto_programt::targett>(I, br_ins));
    gp.update();
  }
  gp.update();
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Switch

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Switch.

 Purpose: Map llvm::Instruction::Switch to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Switch(
    const Instruction *I,
    std::map<goto_programt::targett, const BasicBlock*> &branch_dest_block_map_switch,
    symbol_tablet &symbol_table) {
// TODO(Rasika) : handle constant
  goto_programt gp;
  Value *ub = dyn_cast<SwitchInst>(I)->getCondition();
//  symbolt var;
  const symbolt* var = nullptr;  //akash
  exprt var_expr;
  if (const LoadInst *li = dyn_cast<LoadInst>(ub)) {
//    var = symbol_table.lookup(
//        var_name_map.find(li->getOperand(0)->getName().str())->second);
    var_expr = get_load(li, symbol_table, &var);
    // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
    // {
    //   var_expr = dereference_exprt(var.symbol_expr(), var.type);
    // }
    // else
    // {
    //   var_expr = var.symbol_expr();
    // }
  }
  else {
    var = symbol_table.lookup(
        get_var(
            scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                + ub->getName().str()));
    if (&(dyn_cast<Instruction>(ub)->getDebugLoc()) != NULL) {
      const DebugLoc loc = dyn_cast<Instruction>(ub)->getDebugLoc();
      std::string name = scope_name_map.find(loc->getScope())->second;
      var = symbol_table.lookup(name);
      assert(false);
    }
    var_expr = var->symbol_expr();
  }

  for (auto i = dyn_cast<SwitchInst>(I)->case_begin();
      i != dyn_cast<SwitchInst>(I)->case_end(); i++) {
    goto_programt::targett br_ins = gp.add_instruction();
    branch_dest_block_map_switch.insert(
        std::pair<goto_programt::targett, const BasicBlock*>(
            br_ins, i->getCaseSuccessor()));
    br_ins->make_goto(br_ins);
    br_ins->guard = equal_exprt(var_expr,
                                from_integer(i->getCaseValue()->getZExtValue(),/*TODO(Rasika) : sign*/
                                             var_expr.type()));
  }
  goto_programt::targett default_branch = gp.add_instruction();
  branch_dest_block_map_switch.insert(
      std::pair<goto_programt::targett, const BasicBlock*>(
          default_branch, dyn_cast<SwitchInst>(I)->getDefaultDest()));
  default_branch->make_goto(default_branch);
  default_branch->guard = true_exprt();
// for(auto i = branch_dest_block_map_switch.begin(); i!=branch_dest_block_map_switch.end(); i++){
// 	errs() << from_expr(i->first->guard) << "\n";
// }
// assert(false);
  gp.update();
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_IndirectBr

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::IndirectBr.

 Purpose: Map llvm::Instruction::IndirectBr to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_IndirectBr(const Instruction *I) {
  goto_programt gp;
  assert(false && "IndirectBr is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Invoke

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Invoke.

 Purpose: Map llvm::Instruction::Invoke to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Invoke(const Instruction *I) {
  goto_programt gp;
  assert(false && "Invoke is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Resume

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Resume.

 Purpose: Map llvm::Instruction::Resume to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Resume(const Instruction *I) {
  goto_programt gp;
  assert(false && "Resume is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Unreachable

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Unreachable.

 Purpose: Map llvm::Instruction::Unreachable to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Unreachable(const Instruction *I) {
  goto_programt gp;
  goto_programt::targett load_inst = gp.add_instruction();
  load_inst->make_skip();
  load_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  load_inst->source_location = location;
// assert(false && "Unreachable is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_CleanupRet

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::CleanupRet.

 Purpose: Map llvm::Instruction::CleanupRet to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_CleanupRet(const Instruction *I) {
  goto_programt gp;
  assert(false && "CleanupRet is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_CatchRet

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::CatchRet.

 Purpose: Map llvm::Instruction::CatchRet to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_CatchRet(const Instruction *I) {
  goto_programt gp;
  assert(false && "CatchRet is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_CatchPad

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::CatchPad.

 Purpose: Map llvm::Instruction::CatchPad to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_CatchPad(const Instruction *I) {
  goto_programt gp;
  assert(false && "CatchPad is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_CatchSwitch

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::CatchSwitch.

 Purpose: Map llvm::Instruction::CatchSwitch to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_CatchSwitch(const Instruction *I) {
  goto_programt gp;
  assert(false && "CatchSwitch is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::get_Arith_exprt

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Sub.

 Purpose: Map llvm::Instruction::Sub to corresponding goto instruction.

 \*******************************************************************/
exprt llvm2goto_translator::get_Arith_exprt(const Instruction *I,
                                            symbol_tablet &symbol_table) {

// Operands can be constant integer or a load instruction.
// goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
//  symbolt op1, op2;
  const symbolt* op1 = nullptr, *op2 = nullptr;  //akash
  exprt exprt1, exprt2;
  typet op_type;
  int flag = 2, f1 = 0, f2 = 0;
  if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
//    op1 = symbol_table.lookup(
//        var_name_map.find(li->getOperand(0)->getName().str())->second);
    exprt1 = get_load(li, symbol_table, &op1);
    // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
    // {
    //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
    // }
    // else
    // {
    //   exprt1 = symbol_table.lookup(var_name_map.find(
    //     li->getOperand(0)->getName().str())->second).symbol_expr();
    // }
    f1 = 1;
  }
  if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
    li->getOperand(0)->dump();
//    op2 = symbol_table.lookup(
//        var_name_map.find(li->getOperand(0)->getName().str())->second);
    exprt2 = get_load(li, symbol_table, &op2);
    // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
    // {
    //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
    // }
    // else
    // {
    //   exprt2 = op2.symbol_expr();
    //   errs() << "....   " << op2.type.id().c_str() << "\n";
    // }
    f2 = 1;
  }
  if (f1 == 1 && f2 == 1) {
    op_type = op1->type;
    errs() << "done!";
  }
  else if (I->getOperand(0)->getType()->isIntegerTy()
      || I->getOperand(1)->getType()->isIntegerTy()) {

    if (f1 == 0) {
      if (dyn_cast<ConstantInt>(*ub)) {
        flag = 1;
      }
      else {
        op1 = symbol_table.lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + ub->getName().str()));
        exprt1 = op1->symbol_expr();
      }
    }

    if (f2 == 0) {
      if (dyn_cast<ConstantInt>(*(ub + 1))) {
        flag = 0;
      }
      else {
        op2 = symbol_table.lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + (ub + 1)->getName().str()));
        exprt2 = op2->symbol_expr();
      }
    }
    // typet op_type;
    if (op2) if (op2->type.id() == ID_signedbv) {
      op_type = op2->type;
    }
    if (op1) if (op1->type.id() == ID_signedbv) {
      op_type = op1->type;
    }
    if (op2) if (op2->type.id() == ID_unsignedbv) {
      op_type = op2->type;
    }
    if (op1) if (op1->type.id() == ID_unsignedbv) {
      op_type = op1->type;
    }
    if (op2) if (op2->type.id() == ID_pointer) {
      op_type = op2->type.subtype();
    }
    if (op1) if (op1->type.id() == ID_pointer) {
      op_type = op1->type.subtype();
    }
    if (op_type.id() == ID_signedbv && flag == 1) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub))->getSExtValue();
      typet type = op_type;
      exprt1 = from_integer(val, type);
    }
    if (op_type.id() == ID_signedbv && flag == 0) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub + 1))->getSExtValue();
      typet type = op_type;
      exprt2 = from_integer(val, type);
    }
    if (op_type.id() == ID_unsignedbv && flag == 1) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub))->getZExtValue();
      typet type = op_type;
      exprt1 = from_integer(val, type);
    }
    if (op_type.id() == ID_unsignedbv && flag == 0) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub + 1))->getZExtValue();
      typet type = op_type;
      exprt2 = from_integer(val, type);
    }
  }
// e.op1() = symbol_table.lookup("main::d").symbol_expr();
// return e;

// assert(false);
// Operands can be constant integer or a load instruction.
// goto_programt gp;

  exprt e;
  switch (dyn_cast<Instruction>(I)->getOpcode()) {
    // Standard binary operators...
    case Instruction::Add:
      e = plus_exprt(exprt1, exprt2);
      break;
      // case Instruction::FAdd :
    case Instruction::Sub:
      e = minus_exprt(exprt1, exprt2);
      break;
      // case Instruction::FSub :
    case Instruction::Mul:
      e = mult_exprt(exprt1, exprt2);
      break;
      // case Instruction::FMul :
      // case Instruction::UDiv :
      // case Instruction::SDiv :
      // case Instruction::FDiv :
      // case Instruction::URem :
      // case Instruction::SRem :
      // case Instruction::FRem :

      // Logical operators...
      // case Instruction::And :
      // case Instruction::Or :
      // case Instruction::Xor :

      // Convert instructions...
      // case Instruction::Trunc :
      // case Instruction::ZExt :
      // case Instruction::SExt :
      // case Instruction::FPTrunc :
      // case Instruction::FPExt :
      // case Instruction::FPToUI :
      // case Instruction::FPToSI :
      // case Instruction::UIToFP :
      // case Instruction::SIToFP :
      // case Instruction::IntToPtr :
      // case Instruction::PtrToInt :
      // case Instruction::BitCast :
      // case Instruction::AddrSpaceCast :

      // errs() << "should call trans_instruction expr2\n";
      // assert(false);

      // default:
      // errs() << "No need to get expr2...\n ";
  }
  return e;

}

exprt llvm2goto_translator::get_exprt(const Instruction *I,
                                      symbol_tablet &symbol_table) {
  exprt e, exprt1, exprt2;
  switch (dyn_cast<Instruction>(I)->getOpcode()) {
    // Standard binary operators...
    case Instruction::Add:
    case Instruction::Sub:
    case Instruction::Mul:
      e = get_Arith_exprt(I, symbol_table);
      exprt1 = get_exprt(dyn_cast<Instruction>(I->getOperand(0)), symbol_table);
      exprt2 = get_exprt(dyn_cast<Instruction>(I->getOperand(1)), symbol_table);
      if (exprt1 != exprt()) {
        errs() << "\n e.op0 : " << from_expr(e.op0()) << "\n";
        errs() << "\n exprt1 : " << from_expr(exprt1) << "\n";
        e.op0() = exprt1;
      }
      if (exprt2 != exprt()) {
        errs() << "\n e.op1 : " << from_expr(e.op1()) << "\n";
        errs() << "\n exprt2 : " << from_expr(exprt2) << "\n";
        e.op1() = exprt2;
      }
      // e = plus_exprt(exprt1, exprt2);
      break;
      // case Instruction::FMul :
      // case Instruction::UDiv :
      // case Instruction::SDiv :
      // case Instruction::FDiv :
      // case Instruction::URem :
      // case Instruction::SRem :
      // case Instruction::FRem :

      // Logical operators...
      // case Instruction::And :
      // case Instruction::Or :
      // case Instruction::Xor :

      // Convert instructions...
      // case Instruction::Trunc :
      // case Instruction::ZExt :
      // case Instruction::SExt :
      // case Instruction::FPTrunc :
      // case Instruction::FPExt :
      // case Instruction::FPToUI :
      // case Instruction::FPToSI :
      // case Instruction::UIToFP :
      // case Instruction::SIToFP :
      // case Instruction::IntToPtr :
      // case Instruction::PtrToInt :
      // case Instruction::BitCast :
      // case Instruction::AddrSpaceCast :

      // errs() << "should call trans_instruction expr2\n";
      // assert(false);

      // default:
      // errs() << "No need to get expr2...\n ";
  }
  return e;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Add

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Add.

 Purpose: Map llvm::Instruction::Add to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Add(const Instruction *I,
                                              symbol_tablet &symbol_table) {
// Operands can be constant integer or a load instruction.
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
//  symbolt op1, op2;
  const symbolt* op1 = nullptr, *op2 = nullptr;  //akash
  exprt exprt1, exprt2;
  typet op_type;
  int flag = 2, f1 = 0, f2 = 0;
  if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
//    op1 = symbol_table.lookup(
//        var_name_map.find(li->getOperand(0)->getName().str())->second);
    exprt1 = get_load(li, symbol_table, &op1);
    // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
    // {
    //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
    // }
    // else
    // {
    //   exprt1 = symbol_table.lookup(var_name_map.find(
    //     li->getOperand(0)->getName().str())->second).symbol_expr();
    // }
    f1 = 1;
  }
  if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
    li->getOperand(0)->dump();
//    op2 = symbol_table.lookup(
//        var_name_map.find(li->getOperand(0)->getName().str())->second);
    exprt2 = get_load(li, symbol_table, &op2);
    // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
    // {
    //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
    // }
    // else
    // {
    //   exprt2 = op2.symbol_expr();
    //   errs() << "....   " << op2.type.id().c_str() << "\n";
    // }
    f2 = 1;
  }
  if (f1 == 1 && f2 == 1) {
    op_type = exprt1.type();
//    while (op_type.id() == ID_pointer)
//      op_type = op_type.subtype();
//    if (op1->type.id() == ID_pointer)
//      op_type = op1->type.subtype();
//    else
//      op_type = op1->type;
    errs() << "done!";
  }
  else if (I->getOperand(0)->getType()->isIntegerTy()
      || I->getOperand(1)->getType()->isIntegerTy()) {

    if (f1 == 0) {
      if (dyn_cast<ConstantInt>(*ub)) {
        flag = 1;
      }
      else {
        op1 = symbol_table.lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + ub->getName().str()));
        exprt1 = op1->symbol_expr();
      }
    }

    if (f2 == 0) {
      if (dyn_cast<ConstantInt>(*(ub + 1))) {
        flag = 0;
      }
      else {
        op2 = symbol_table.lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + (ub + 1)->getName().str()));
        exprt2 = op2->symbol_expr();
      }
    }
    // typet op_type;
    if (exprt2.type().id() == ID_signedbv) {
      op_type = exprt2.type();
    }
    if (exprt1.type().id() == ID_signedbv) {
      op_type = exprt1.type();
    }
    if (exprt2.type().id() == ID_unsignedbv) {
      op_type = exprt2.type();
    }
    if (exprt1.type().id() == ID_unsignedbv) {
      op_type = exprt1.type();
    }
//    if (op2) if (op2->type.id() == ID_pointer) {
//      op_type = op2->type.subtype();
//    }
//    if (op1) if (op1->type.id() == ID_pointer) {
//      op_type = op1->type.subtype();
//    }
    if (op_type.id() == ID_signedbv && flag == 1) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub))->getSExtValue();
      typet type = op_type;
      exprt1 = from_integer(val, type);
    }
    if (op_type.id() == ID_signedbv && flag == 0) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub + 1))->getSExtValue();
      typet type = op_type;
      exprt2 = from_integer(val, type);
    }
    if (op_type.id() == ID_unsignedbv && flag == 1) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub))->getZExtValue();
      typet type = op_type;
      exprt1 = from_integer(val, type);
    }
    if (op_type.id() == ID_unsignedbv && flag == 0) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub + 1))->getZExtValue();
      typet type = op_type;
      exprt2 = from_integer(val, type);
    }
  }
//  if (var_name_map.find(I->getName().str()) == var_name_map.end()) {      //akash removed the if condition
  symbolt symbol;
  symbol.base_name = I->getName().str();
// errs() << scope_name_map.find(I->getDebugLoc()->getScope())->second;
  symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
      + I->getName().str();
  var_name_map.insert(
      std::pair<std::string, std::string>(symbol.name.c_str(),
                                          symbol.base_name.c_str()));  //akash fixed
  symbol.type = op_type;
//  symbol.value = from_integer(0, op_type);
  symbol_table.add(symbol);
  goto_programt::targett decl_add = gp.add_instruction();
  decl_add->make_decl();
  decl_add->code = code_declt(symbol.symbol_expr());
  errs() << from_expr(decl_add->code) << "\n";
//  }
//  symbolt result = symbol_table.lookup(var_name_map.find(
//    I->getName().str())->second);
  const symbolt* result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));  //akash
  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
// Add instruction in llvm becomes an assignment statement in goto,
// with a symbol on LHS and plus_exprt on RHS.
  add_inst->code = code_assignt(result->symbol_expr(),
                                plus_exprt(exprt1, exprt2));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
      // exprt e = get_exprt(dyn_cast<Instruction>(I), symbol_table);
      // std::string comment = from_expr(namespacet(symbol_table),
      // 	(symbol_table.symbols.begin()->second.name), e);
      // location.set_comment(comment);
      // std::cout << e1 << "\n";
    }
  }
  add_inst->source_location = location;
  add_inst->type = goto_program_instruction_typet::ASSIGN;

//  errs() << from_expr(namespacet(symbol_table),
//  	(symbol_table.symbols.begin()->second.name), add_inst->code);
// assert(false && "hi");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_FAdd

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::FAdd.

 Purpose: Map llvm::Instruction::FAdd to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_FAdd(const Instruction *I,
                                               symbol_tablet &symbol_table) {
  goto_programt gp;
// Operands can be constant of one of the six floating point types or
// a load instruction.
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
//  symbolt op1, op2;
  const symbolt *op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  if (dyn_cast<ConstantFP>(*ub)) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*ub)->getType());
    if (floattype->isFloatTy()) {
      float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl(float_type());
      ieee_fl.from_float(val);
      exprt1 = ieee_fl.to_expr();
    }
    else if (floattype->isDoubleTy()) {
      double val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl(double_type());
      ieee_fl.from_double(val);
      exprt1 = ieee_fl.to_expr();
    }
    else {
      ub->dump();
      assert(
          false
              && "This floating point type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
      // }
      // else
      // {
      //   exprt1 = op1.symbol_expr();
      // }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  if (dyn_cast<ConstantFP>(*(ub + 1))) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub + 1))->getType());
    if (floattype->isFloatTy()) {
      float val =
          dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl(float_type());
      ieee_fl.from_float(val);
//      exprt rounding = symbol_table.lookup("__CPROVER_rounding_mode")
//          ->symbol_expr();
//      exprt2 = floatbv_typecast_exprt(ieee_fl.to_expr(), rounding,
//                                      float_type());
      exprt2 = ieee_fl.to_expr();
    }
    else if (floattype->isDoubleTy()) {
      double val = dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF()
          .convertToDouble();
      ieee_floatt ieee_fl(double_type());
      ieee_fl.from_double(val);
//      exprt rounding = symbol_table.lookup(
//          var_name_map.find("__CPROVER_rounding_mode")->second)->symbol_expr();
//      exprt rounding = symbol_table.lookup("__CPROVER_rounding_mode")
//          ->symbol_expr();
//      exprt2 = floatbv_typecast_exprt(ieee_fl.to_expr(), rounding,
//                                      double_type());
      exprt2 = ieee_fl.to_expr();
    }
    else {
      (ub + 1)->dump();
      assert(
          false
              && "This floating point type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
      // }
      // else
      // {
      //   exprt2 = op2.symbol_expr();
      // }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
      exprt2 = op2->symbol_expr();
    }
  }
// Symbol corresponding to the value in which result of llvm instruction
// is stored, might have been created in goto symbol table earlier. If so,
// it is used otherwise new symbol is created. And added to the symbol table.
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(
        I->getDebugLoc()->getScope()->getNonLexicalBlockFileScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
//  symbolt result = symbol_table.lookup(var_name_map.find(
//    I->getName().str())->second);
  const symbolt* result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));  //akash
  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
// Add instruction in llvm becomes an assignment statement in goto,
// with a symbol on LHS and plus_exprt on RHS.
  add_inst->code = code_assignt(result->symbol_expr(),
                                plus_exprt(exprt1, exprt2));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  add_inst->source_location = location;
  add_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Sub

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Sub.

 Purpose: Map llvm::Instruction::Sub to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Sub(const Instruction *I,
                                              symbol_tablet &symbol_table) {
// Operands can be constant integer or a load instruction.
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  typet op_type;
  int flag = 2, f1 = 0, f2 = 0;
  if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
//    op1 = symbol_table.lookup(
//        var_name_map.find(li->getOperand(0)->getName().str())->second);
    exprt1 = get_load(li, symbol_table, &op1);
    // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
    // {
    //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
    // }
    // else
    // {
    //   exprt1 = symbol_table.lookup(var_name_map.find(
    //     li->getOperand(0)->getName().str())->second).symbol_expr();
    // }
    f1 = 1;
  }
  if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
    li->getOperand(0)->dump();
//    op2 = symbol_table.lookup(
//        var_name_map.find(li->getOperand(0)->getName().str())->second);
    exprt2 = get_load(li, symbol_table, &op2);
    // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
    // {
    //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
    // }
    // else
    // {
    //   exprt2 = symbol_table.lookup(var_name_map.find(
    //     li->getOperand(0)->getName().str())->second).symbol_expr();
    // }
    f2 = 1;
  }
  if (f1 == 1 && f2 == 1) {
    op_type = exprt1.type();
    errs() << "done!";
  }
  else if (I->getOperand(0)->getType()->isIntegerTy()
      || I->getOperand(1)->getType()->isIntegerTy()) {
    if (f1 == 0) {
      if (dyn_cast<ConstantInt>(*ub)) {
        flag = 1;
      }
      else {
        op1 = symbol_table.lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + ub->getName().str()));
        exprt1 = op1->symbol_expr();
      }
    }

    if (f2 == 0) {
      if (dyn_cast<ConstantInt>(*(ub + 1))) {
        flag = 0;
      }
      else {
        op2 = symbol_table.lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + (ub + 1)->getName().str()));
        exprt2 = op2->symbol_expr();
      }
    }

    if (f2) if (exprt2.type().id() == ID_signedbv) {
      op_type = exprt2.type();
    }
    if (f1) if (exprt1.type().id() == ID_signedbv) {
      op_type = exprt1.type();
    }
    if (f2) if (exprt2.type().id() == ID_unsignedbv) {
      op_type = exprt2.type();
    }
    if (f1) if (exprt1.type().id() == ID_unsignedbv) {
      op_type = exprt1.type();
    }
    if (f2) if (exprt2.type().id() == ID_pointer) {
      op_type = exprt2.type().subtype();
    }
    if (f1) if (exprt1.type().id() == ID_pointer) {
      op_type = exprt1.type().subtype();
    }
    if (op_type.id() == ID_signedbv && flag == 1) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub))->getSExtValue();
      typet type = op_type;
      exprt1 = from_integer(val, type);
    }
    if (op_type.id() == ID_signedbv && flag == 0) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub + 1))->getSExtValue();
      typet type = op_type;
      exprt2 = from_integer(val, type);
    }
    if (op_type.id() == ID_unsignedbv && flag == 1) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub))->getZExtValue();
      typet type = op_type;
      exprt1 = from_integer(val, type);
    }
    if (op_type.id() == ID_unsignedbv && flag == 0) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub + 1))->getZExtValue();
      typet type = op_type;
      exprt2 = from_integer(val, type);
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));

  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
// Add instruction in llvm becomes an assignment statement in goto,
// with a symbol on LHS and minus_exprt on RHS.
  add_inst->code = code_assignt(result->symbol_expr(),
                                minus_exprt(exprt1, exprt2));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  add_inst->source_location = location;
  add_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_FSub

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::FSub.

 Purpose: Map llvm::Instruction::FSub to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_FSub(const Instruction *I,
                                               symbol_tablet &symbol_table) {
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  if (dyn_cast<ConstantFP>(*ub)) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*ub)->getType());
    if (floattype->isFloatTy()) {
      float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl(float_type());
      ieee_fl.from_float(val);
      exprt1 = ieee_fl.to_expr();
    }
    else if (floattype->isDoubleTy()) {
      double val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl(double_type());
      ieee_fl.from_double(val);
      exprt1 = ieee_fl.to_expr();
    }
    else {
      ub->dump();
      assert(
          false
              && "This floating point type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
      // }
      // else
      // {
      //   exprt1 = op1.symbol_expr();
      // }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  if (dyn_cast<ConstantFP>(*(ub + 1))) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub + 1))->getType());
    if (floattype->isFloatTy()) {
      float val =
          dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl(float_type());
      ieee_fl.from_float(val);
      exprt2 = ieee_fl.to_expr();
    }
    else if (floattype->isDoubleTy()) {
      float val =
          dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl(double_type());
      ieee_fl.from_double(val);
      exprt2 = ieee_fl.to_expr();
    }
    else {
      (ub + 1)->dump();
      assert(
          false
              && "This floating point type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
      // }
      // else
      // {
      //   exprt2 = op2.symbol_expr();
      // }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
      exprt2 = op2->symbol_expr();
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(
        dyn_cast<DIScope>(
            I->getDebugLoc()->getScope()->getNonLexicalBlockFileScope()))
        ->second + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));
  goto_programt::targett fsub_inst = gp.add_instruction();
  fsub_inst->make_assignment();
  fsub_inst->code = code_assignt(result->symbol_expr(),
                                 minus_exprt(exprt1, exprt2));
  fsub_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  fsub_inst->source_location = location;
  fsub_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Mul

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Mul.

 Purpose: Map llvm::Instruction::Mul to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Mul(const Instruction *I,
                                              symbol_tablet &symbol_table) {
// Operands can be constant integer or a load instruction.
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  typet op_type;
  int flag = 2, f1 = 0, f2 = 0;
  if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
//    op1 = symbol_table.lookup(
//        var_name_map.find(li->getOperand(0)->getName().str())->second);
    exprt1 = get_load(li, symbol_table, &op1);
    // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
    // {
    //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
    // }
    // else
    // {
    //   exprt1 = symbol_table.lookup(var_name_map.find(
    //     li->getOperand(0)->getName().str())->second).symbol_expr();
    // }
    f1 = 1;
  }
  if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
    li->getOperand(0)->dump();
//    op2 = symbol_table.lookup(
//        var_name_map.find(li->getOperand(0)->getName().str())->second);
    exprt2 = get_load(li, symbol_table, &op2);
    // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
    // {
    //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
    // }
    // else
    // {
    //   exprt2 = symbol_table.lookup(var_name_map.find(
    //     li->getOperand(0)->getName().str())->second).symbol_expr();
    // }
    f2 = 1;
  }
  if (f1 == 1 && f2 == 1) {
    op_type = op1->type;
    errs() << "done!";
  }
  else if (I->getOperand(0)->getType()->isIntegerTy()
      || I->getOperand(1)->getType()->isIntegerTy()) {
    if (f1 == 0) {
      if (dyn_cast<ConstantInt>(*ub)) {
        flag = 1;
      }
      else {
        op1 = symbol_table.lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + ub->getName().str()));
        exprt1 = op1->symbol_expr();
      }
    }

    if (f2 == 0) {
      if (dyn_cast<ConstantInt>(*(ub + 1))) {
        flag = 0;
      }
      else {
        op2 = symbol_table.lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + (ub + 1)->getName().str()));
        exprt2 = op2->symbol_expr();
      }
    }

    if (op2) if (op2->type.id() == ID_signedbv) {
      op_type = op2->type;
    }
    if (op1) if (op1->type.id() == ID_signedbv) {
      op_type = op1->type;
    }
    if (op2) if (op2->type.id() == ID_unsignedbv) {
      op_type = op2->type;
    }
    if (op1) if (op1->type.id() == ID_unsignedbv) {
      op_type = op1->type;
    }
    if (op2) if (op2->type.id() == ID_pointer) {
      op_type = op2->type.subtype();
    }
    if (op1) if (op1->type.id() == ID_pointer) {
      op_type = op1->type.subtype();
    }
    if (op_type.id() == ID_signedbv && flag == 1) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub))->getSExtValue();
      typet type = op_type;
      exprt1 = from_integer(val, type);
    }
    if (op_type.id() == ID_signedbv && flag == 0) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub + 1))->getSExtValue();
      typet type = op_type;
      exprt2 = from_integer(val, type);
    }
    if (op_type.id() == ID_unsignedbv && flag == 1) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub))->getZExtValue();
      typet type = op_type;
      exprt1 = from_integer(val, type);
    }
    if (op_type.id() == ID_unsignedbv && flag == 0) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub + 1))->getZExtValue();
      typet type = op_type;
      exprt2 = from_integer(val, type);
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));

  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
// Add instruction in llvm becomes an assignment statement in goto,
// with a symbol on LHS and mult_exprt on RHS.
  add_inst->code = code_assignt(result->symbol_expr(),
                                mult_exprt(exprt1, exprt2));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
      // exprt e = get_exprt(dyn_cast<Instruction>(I), symbol_table);
      // std::string comment = from_expr(namespacet(symbol_table),
      //   (symbol_table.symbols.begin()->second.name), e);
      // assert(false);
      // location.set_comment(comment);
      // errs() << "\n \n comment : " << comment << "\n\n";
    }
  }
  add_inst->source_location = location;
  add_inst->type = goto_program_instruction_typet::ASSIGN;
// assert(false);
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_FMul

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::FMul.

 Purpose: Map llvm::Instruction::FMul to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_FMul(const Instruction *I,
                                               symbol_tablet &symbol_table) {
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  if (dyn_cast<ConstantFP>(*ub)) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*ub)->getType());
    if (floattype->isFloatTy()) {
      float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl(float_type());
      ieee_fl.from_float(val);
      exprt1 = ieee_fl.to_expr();
    }
    else if (floattype->isDoubleTy()) {
      double val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl(double_type());
      ieee_fl.from_double(val);
      exprt1 = ieee_fl.to_expr();
    }
    else {
      ub->dump();
      assert(
          false
              && "This floating point type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
      // }
      // else
      // {
      //   exprt1 = op1.symbol_expr();
      // }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  if (dyn_cast<ConstantFP>(*(ub + 1))) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub + 1))->getType());
    if (floattype->isFloatTy()) {
      float val =
          dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl(float_type());
      ieee_fl.from_float(val);
      exprt2 = ieee_fl.to_expr();
    }
    else if (floattype->isDoubleTy()) {
      double val = dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF()
          .convertToDouble();
      ieee_floatt ieee_fl(double_type());
      ieee_fl.from_double(val);
      exprt2 = ieee_fl.to_expr();
    }
    else {
      (ub + 1)->dump();
      assert(
          false
              && "This floating point type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
      // }
      // else
      // {
      //   exprt2 = op2.symbol_expr();
      // }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
      exprt2 = op2->symbol_expr();
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(
        dyn_cast<DIScope>(
            I->getDebugLoc()->getScope()->getNonLexicalBlockFileScope()))
        ->second + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));
  goto_programt::targett fmul_inst = gp.add_instruction();
  fmul_inst->make_assignment();
  fmul_inst->code = code_assignt(result->symbol_expr(),
                                 mult_exprt(exprt1, exprt2));
  fmul_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  fmul_inst->source_location = location;
  fmul_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_UDiv

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::UDiv.

 Purpose: Map llvm::Instruction::UDiv to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_UDiv(const Instruction *I,
                                               symbol_tablet &symbol_table) {
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    // By default data type is unsigned here.
    exprt1 = from_integer(val, unsignedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
      // }
      // else
      // {
      //   exprt1 = op1.symbol_expr();
      // }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub + 1))) {
    uint64_t val;
    val = cint->getZExtValue();
    // data type is unsigned by default.
    exprt2 = from_integer(val, unsignedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
      // }
      // else
      // {
      //   exprt2 = op2.symbol_expr();
      // }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
    }
    exprt2 = op2->symbol_expr();
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));

  goto_programt::targett udiv_inst = gp.add_instruction();
  udiv_inst->make_assignment();
  udiv_inst->code = code_assignt(result->symbol_expr(),
                                 div_exprt(exprt1, exprt2));
  udiv_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  udiv_inst->source_location = location;
  udiv_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_SDiv

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::SDiv.

 Purpose: Map llvm::Instruction::SDiv to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_SDiv(const Instruction *I,
                                               symbol_tablet &symbol_table) {
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getSExtValue();
    exprt1 = from_integer(val,
                          signedbv_typet(I->getType()->getIntegerBitWidth()));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
      // }
      // else
      // {
      //   exprt1 = op1.symbol_expr();
      // }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
    }
    exprt1 = op1->symbol_expr();
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub + 1))) {
    uint64_t val;
    val = cint->getSExtValue();
    exprt2 = from_integer(val,
                          signedbv_typet(I->getType()->getIntegerBitWidth()));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
      // }
      // else
      // {
      //   exprt2 = op2.symbol_expr();
      // }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
    }
    exprt2 = op2->symbol_expr();
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt* result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));

  goto_programt::targett sdiv_inst = gp.add_instruction();
  sdiv_inst->make_assignment();
  sdiv_inst->code = code_assignt(result->symbol_expr(),
                                 div_exprt(exprt1, exprt2));
  sdiv_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  sdiv_inst->source_location = location;
  sdiv_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_FDiv

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::FDiv.

 Purpose: Map llvm::Instruction::FDiv to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_FDiv(const Instruction *I,
                                               symbol_tablet &symbol_table) {
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1, *op2;
  exprt exprt1, exprt2;
  if (dyn_cast<ConstantFP>(*ub)) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*ub)->getType());
    if (floattype->isFloatTy()) {
      float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl(float_type());
      ieee_fl.from_float(val);
      exprt1 = ieee_fl.to_expr();
    }
    else if (floattype->isDoubleTy()) {
      double val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl(double_type());
      ieee_fl.from_double(val);
      exprt1 = ieee_fl.to_expr();
    }
    else {
      ub->dump();
      assert(
          false
              && "This floating point type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
      // }
      // else
      // {
      //   exprt1 = op1.symbol_expr();
      // }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  if (dyn_cast<ConstantFP>(*(ub + 1))) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub + 1))->getType());
    if (floattype->isFloatTy()) {
      float val =
          dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl(float_type());
      ieee_fl.from_float(val);
      exprt2 = ieee_fl.to_expr();
    }
    else if (floattype->isDoubleTy()) {
      double val = dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF()
          .convertToDouble();
      ieee_floatt ieee_fl(double_type());
      ieee_fl.from_double(val);
      exprt2 = ieee_fl.to_expr();
    }
    else {
      (ub + 1)->dump();
      assert(
          false
              && "This floating point type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
      // }
      // else
      // {
      //   exprt2 = op2.symbol_expr();
      // }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
      exprt2 = op2->symbol_expr();
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));
  goto_programt::targett fdiv_inst = gp.add_instruction();
  fdiv_inst->make_assignment();
  fdiv_inst->code = code_assignt(result->symbol_expr(),
                                 div_exprt(exprt1, exprt2));
  fdiv_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  fdiv_inst->source_location = location;
  fdiv_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_URem

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::URem.

 Purpose: Map llvm::Instruction::URem to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_URem(const Instruction *I,
                                               symbol_tablet &symbol_table) {
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    // by default unsigned data type.
    exprt1 = from_integer(val, unsignedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
      // }
      // else
      // {
      //   exprt1 = op1.symbol_expr();
      // }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub + 1))) {
    uint64_t val;
    val = cint->getZExtValue();
    // default type is unsigned.
    exprt2 = from_integer(val, unsignedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
      // }
      // else
      // {
      //   exprt2 = op2.symbol_expr();
      // }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
      exprt2 = op2->symbol_expr();
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));

  goto_programt::targett urem_inst = gp.add_instruction();
  urem_inst->make_assignment();
  urem_inst->code = code_assignt(result->symbol_expr(),
                                 mod_exprt(exprt1, exprt2));
  urem_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  urem_inst->source_location = location;
  urem_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_SRem

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::SRem.

 Purpose: Map llvm::Instruction::SRem to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_SRem(const Instruction *I,
                                               symbol_tablet &symbol_table) {
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getSExtValue();
    exprt1 = from_integer(val,
                          signedbv_typet(I->getType()->getIntegerBitWidth()));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
      // }
      // else
      // {
      //   exprt1 = op1.symbol_expr();
      // }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub + 1))) {
    uint64_t val;
    val = cint->getSExtValue();
    exprt2 = from_integer(val,
                          signedbv_typet(I->getType()->getIntegerBitWidth()));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
      // }
      // else
      // {
      //   exprt2 = op2.symbol_expr();
      // }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
      exprt2 = op2->symbol_expr();
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));

  goto_programt::targett srem_inst = gp.add_instruction();
  srem_inst->make_assignment();
  srem_inst->code = code_assignt(result->symbol_expr(),
                                 mod_exprt(exprt1, exprt2));
  srem_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  srem_inst->source_location = location;
  srem_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_FRem

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::FRem.

 Purpose: Map llvm::Instruction::FRem to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_FRem(const Instruction *I,
                                               symbol_tablet &symbol_table) {
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  if (dyn_cast<ConstantFP>(*ub)) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*ub)->getType());
    if (floattype->isFloatTy()) {
      float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl(float_type());
      ieee_fl.from_float(val);
      exprt1 = ieee_fl.to_expr();
    }
    else if (floattype->isDoubleTy()) {
      double val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl(double_type());
      ieee_fl.from_double(val);
      exprt1 = ieee_fl.to_expr();
    }
    else {
      ub->dump();
      assert(
          false
              && "This floating point type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
      // }
      // else
      // {
      //   exprt1 = op1.symbol_expr();
      // }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  if (dyn_cast<ConstantFP>(*(ub + 1))) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub + 1))->getType());
    if (floattype->isFloatTy()) {
      float val =
          dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl(float_type());
      ieee_fl.from_float(val);
      exprt2 = ieee_fl.to_expr();
    }
    else if (floattype->isDoubleTy()) {
      double val = dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF()
          .convertToDouble();
      ieee_floatt ieee_fl(double_type());
      ieee_fl.from_double(val);
      exprt2 = ieee_fl.to_expr();
    }
    else {
      (ub + 1)->dump();
      assert(
          false
              && "This floating point type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
      // }
      // else
      // {
      //   exprt2 = op2.symbol_expr();
      // }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
      exprt2 = op2->symbol_expr();
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));
  goto_programt::targett frem_inst = gp.add_instruction();
  frem_inst->make_assignment();
  frem_inst->code = code_assignt(result->symbol_expr(),
                                 mod_exprt(exprt1, exprt2));
  frem_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  frem_inst->source_location = location;
  frem_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_And

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::And.

 Purpose: Map llvm::Instruction::And to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_And(const Instruction *I,
                                              symbol_tablet &symbol_table) {
// Operands can be constant integer or a load instruction.
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    // will handle sign later.
    exprt1 = from_integer(val, unsignedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
      // }
      // else
      // {
      //   exprt1 = op1.symbol_expr();
      // }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub + 1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, unsignedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
      // }
      // else
      // {
      //   exprt2 = op2.symbol_expr();
      // }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
      exprt2 = op2->symbol_expr();
    }
  }
// Symbol corresponding to the value in which result of llvm instruction
// is stored, might have been created in goto symbol table earlier. If so,
// it is used otherwise new symbol is created. And added to the symbol table.
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt*result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));

  goto_programt::targett and_inst = gp.add_instruction();
  and_inst->make_assignment();
// Add instruction in llvm becomes an assignment statement in goto,
// with a symbol on LHS and bitand_exprt on RHS.
  and_inst->code = code_assignt(result->symbol_expr(),
                                bitand_exprt(exprt1, exprt2));
  and_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  and_inst->source_location = location;
  and_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Or

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Or.

 Purpose: Map llvm::Instruction::Or to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Or(const Instruction *I,
                                             symbol_tablet &symbol_table) {
// Operands can be constant integer or a load instruction.
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt*op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, unsignedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
      // }
      // else
      // {
      //   exprt1 = op1.symbol_expr();
      // }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub + 1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, unsignedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
      // }
      // else
      // {
      //   exprt2 = op2.symbol_expr();
      // }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
      exprt2 = op2->symbol_expr();
    }
  }
// Symbol corresponding to the value in which result of llvm instruction
// is stored, might have been created in goto symbol table earlier. If so,
// it is used otherwise new symbol is created. And added to the symbol table.
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt*result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));

  goto_programt::targett or_inst = gp.add_instruction();
  or_inst->make_assignment();
// Add instruction in llvm becomes an assignment statement in goto,
// with a symbol on LHS and bitor_exprt on RHS.
  or_inst->code = code_assignt(result->symbol_expr(),
                               bitor_exprt(exprt1, exprt2));
  or_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  or_inst->source_location = location;
  or_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Xor

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Xor.

 Purpose: Map llvm::Instruction::Xor to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Xor(const Instruction *I,
                                              symbol_tablet &symbol_table) {
// Operands can be constant integer or a load instruction.
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt*op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, unsignedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
      // }
      // else
      // {
      //   exprt1 = op1.symbol_expr();
      // }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub + 1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, unsignedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
      // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
      // {
      //   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
      // }
      // else
      // {
      //   exprt2 = op2.symbol_expr();
      // }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
      exprt2 = op2->symbol_expr();
    }
  }
// Symbol corresponding to the value in which result of llvm instruction
// is stored, might have been created in goto symbol table earlier. If so,
// it is used otherwise new symbol is created. And added to the symbol table.
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt*result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));

  goto_programt::targett xor_inst = gp.add_instruction();
  xor_inst->make_assignment();
// Add instruction in llvm becomes an assignment statement in goto,
// with a symbol on LHS and bitxor_exprt on RHS.
  xor_inst->code = code_assignt(result->symbol_expr(),
                                bitxor_exprt(exprt1, exprt2));
  xor_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  xor_inst->source_location = location;
  xor_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Alloca

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Alloca.

 Purpose: Map llvm::Instruction::Alloca to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Alloca(const Instruction *I,
                                                 symbol_tablet &symbol_table) {
  goto_programt gp;
  symbolt symbol;
// the type will be set in llvm.dbg.declare
// symbol.type = symbol_creator::create_type(
//   dyn_cast<AllocaInst>(I)->getAllocatedType());
  switch (dyn_cast<AllocaInst>(I)->getAllocatedType()->getTypeID()) {
    // 16-bit floating point type
    case llvm::Type::TypeID::HalfTyID: {
      symbol.type = to_floatbv_type(bitvector_typet(ID_floatbv, 16));
      break;
    }
      // 32-bit floating point type
    case llvm::Type::TypeID::FloatTyID: {
      symbol.type = to_floatbv_type(bitvector_typet(ID_floatbv, 32));
      break;
    }
      // 64-bit floating point type
    case llvm::Type::TypeID::DoubleTyID: {
      symbol.type = to_floatbv_type(bitvector_typet(ID_floatbv, 64));
      break;
    }
      // 80-bit floating point type (X87)
    case llvm::Type::TypeID::X86_FP80TyID: {
      symbol.type = to_floatbv_type(bitvector_typet(ID_floatbv, 80));
      break;
    }
      // 128-bit floating point type (112-bit mantissa)
    case llvm::Type::TypeID::FP128TyID: {
      symbol.type = to_floatbv_type(bitvector_typet(ID_floatbv, 128));
      break;
    }
      // 128-bit floating point type (two 64-bits, PowerPC)
    case llvm::Type::TypeID::PPC_FP128TyID: {
      symbol.type = to_floatbv_type(bitvector_typet(ID_floatbv, 128));
      break;
    }
    case llvm::Type::TypeID::IntegerTyID: {
      if (dyn_cast<AllocaInst>(I)->getAllocatedType()->getIntegerBitWidth()
          == 1) {
        symbol.type = bool_typet();
      }
      else {
        symbol.type = unsignedbv_typet(
            dyn_cast<AllocaInst>(I)->getAllocatedType()->getIntegerBitWidth());
      }
      break;
    }
    case llvm::Type::TypeID::VoidTyID: {
      // typet void_type = create_void_typet();
      symbol.type = void_typet();
      errs() << "void_typet";
      break;
    }
    case llvm::Type::TypeID::StructTyID:
    case llvm::Type::TypeID::ArrayTyID:
    case llvm::Type::TypeID::PointerTyID:
    case llvm::Type::TypeID::VectorTyID:
    case llvm::Type::TypeID::X86_MMXTyID:
    case llvm::Type::TypeID::FunctionTyID:
    case llvm::Type::TypeID::TokenTyID:
    case llvm::Type::TypeID::LabelTyID:
    case llvm::Type::TypeID::MetadataTyID:
      errs() << "\n This type is not handled\n ";
  }
  symbol.base_name = I->getName().str();
  symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
  symbol_table.add(symbol);
  var_name_map.insert(
      std::pair<std::string, std::string>(symbol.name.c_str(),
                                          I->getName().str()));    //akash fixed
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Load

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Load.

 Purpose: Map llvm::Instruction::Load to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Load(const Instruction *I) {
  goto_programt gp;
  goto_programt::targett load_inst = gp.add_instruction();
  load_inst->make_skip();
  load_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  load_inst->source_location = location;
// load_inst->type = goto_program_instruction_typet::ASSIGN;
// errs() << "Load is yet to be mapped \n";
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::get_load

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Store.

 Purpose: Map llvm::Instruction::Store to corresponding goto instruction.
 }

 \*******************************************************************/
exprt llvm2goto_translator::get_load(const LoadInst *I,
                                     const symbol_tablet &symbol_table,
                                     const symbolt **ret_symbol) {
  I->dump();
  if (I->getOperand(0)->hasName()) {
    errs() << "a\n";
    std::string var_name = get_var(
        scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
            + I->getOperand(0)->getName().str());
    if (dyn_cast<GetElementPtrInst>(I->getOperand(0))) {
      *ret_symbol = symbol_table.lookup(var_name);
      return dereference_exprt(symbol_table.lookup(var_name)->symbol_expr());
    }
    else {
      // exprt1 = op1.symbol_expr();
      *ret_symbol = symbol_table.lookup(var_name);
      return symbol_table.lookup(var_name)->symbol_expr();
    }
  }
  else if (auto *CE = dyn_cast<ConstantExpr>(I->getOperand(0))) {
    GetElementPtrInst *GE = dyn_cast<GetElementPtrInst>(CE->getAsInstruction());

    typet dummy;
    exprt value_to_store = trans_ConstGetElementPtr(
        GE, symbol_table, &dummy, I->getDebugLoc()->getScope());

    GE->deleteValue();

    return value_to_store;
  }
  else {
    errs() << "b\n";
    if (BitCastInst *bci = dyn_cast<BitCastInst>(I->getOperand(0))) {
      if (bci->getOperand(0)->hasName()) {
        const symbolt *symbol = symbol_table.lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + bci->getOperand(0)->getName().str()));
        *ret_symbol = symbol;
        exprt value_to_store = symbol->symbol_expr();
        value_to_store = typecast_exprt(
            value_to_store, symbol_creator::create_type(bci->getType()));
//        if (value_to_store.type().id() == ID_floatbv
//            || value_to_store.type().id() == ID_float) {
//          exprt rounding = symbol_table.lookup("__CPROVER_rounding_mode")
//              ->symbol_expr();
//          floatbv_typet temp = to_floatbv_type(value_to_store.type());
//          if (temp.get_width() == 32) value_to_store = floatbv_typecast_exprt(
//              value_to_store, rounding, float_type());
//          if (temp.get_width() == 64) value_to_store = floatbv_typecast_exprt(
//              value_to_store, rounding, double_type());
//        }
        errs() << from_expr(value_to_store) << "\n";
        return value_to_store;
      }
      else {
        assert(false && "bitcast found");
      }
      assert(false && "bitcast");
    }
    else {
      return dereference_exprt(
          get_load(dyn_cast<LoadInst>(I->getOperand(0)), symbol_table,
                   ret_symbol));
    }
  }
}

/*******************************************************************
 Function: llvm2goto_translator::get_load

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Store.

 Purpose: Map llvm::Instruction::Store to corresponding goto instruction.
 }

 \*******************************************************************/
exprt llvm2goto_translator::get_load(const LoadInst *I,
                                     const symbol_tablet &symbol_table) {
  I->dump();
  if (I->getOperand(0)->hasName()) {
    errs() << "a\n";
    std::string var_name = get_var(
        scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
            + I->getOperand(0)->getName().str());
    if (dyn_cast<GetElementPtrInst>(I->getOperand(0))) {
      return dereference_exprt(symbol_table.lookup(var_name)->symbol_expr());
    }
    else {
      // exprt1 = op1.symbol_expr();
      return symbol_table.lookup(var_name)->symbol_expr();
    }
  }
  else {
    errs() << "b\n";
    if (BitCastInst *bci = dyn_cast<BitCastInst>(I->getOperand(0))) {
      if (bci->getOperand(0)->hasName()) {
        const symbolt *symbol = symbol_table.lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + bci->getOperand(0)->getName().str()));
        exprt value_to_store = address_of_exprt(symbol->symbol_expr());
        value_to_store = typecast_exprt(
            value_to_store, symbol_creator::create_type(bci->getType()));
        value_to_store = dereference_exprt(value_to_store);
//        if (value_to_store.type().id() == ID_floatbv
//            || value_to_store.type().id() == ID_float) {
//          exprt rounding = symbol_table.lookup("__CPROVER_rounding_mode")
//              ->symbol_expr();
//          floatbv_typet temp = to_floatbv_type(value_to_store.type());
//          if (temp.get_width() == 32) value_to_store = floatbv_typecast_exprt(
//              value_to_store, rounding, float_type());
//          if (temp.get_width() == 64) value_to_store = floatbv_typecast_exprt(
//              value_to_store, rounding, double_type());
//        }
        errs() << from_expr(value_to_store) << "\n";
        return value_to_store;
      }
      else {
        assert(false && "bitcast found");
      }
      assert(false && "bitcast");
    }
    else if (auto *CE = dyn_cast<ConstantExpr>(I->getOperand(0))) {
      GetElementPtrInst *GE = dyn_cast<GetElementPtrInst>(
          CE->getAsInstruction());

      typet dummy;
      exprt value_to_store = trans_ConstGetElementPtr(
          GE, symbol_table, &dummy, I->getDebugLoc()->getScope());

      GE->deleteValue();

      return value_to_store;
    }
    else {
      return dereference_exprt(
          get_load(dyn_cast<LoadInst>(I->getOperand(0)), symbol_table));
    }
  }
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Store

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Store.

 Purpose: Map llvm::Instruction::Store to corresponding goto instruction.
 }

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Store(const Instruction *I,
                                                symbol_tablet &symbol_table) {
  goto_programt gp;
  int flag = 1;  //akash bad way to prevent &<constant_int> around line:3107
  int function_parameter_flag = 0;
  typet final_type;
  Instruction *ni = nullptr;
// I->dump();
  if (dyn_cast<DbgDeclareInst>(I->getNextNode())) {
//    I->getNextNode()->moveBefore(I);
    goto_programt Call_Inst = trans_Call(I->getNextNode(), &symbol_table);
    gp.destructive_append(Call_Inst);
    ni = const_cast<Instruction*>(I->getNextNode());
  }
  dyn_cast<StoreInst>(I)->getOperand(0)->dump();
  const symbolt *symbol = nullptr;
  exprt expr;
  I->getOperand(1)->dump();
  if (dyn_cast<StoreInst>(I)->getOperand(1)->hasName()) {
    if (!dyn_cast<StoreInst>(I)->getOperand(1)->getName().str().compare(
        "retval")) {
      if (ni) ni->eraseFromParent();
      return gp;
    }
    if (I->hasMetadata()) {
      symbol = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + dyn_cast<StoreInst>(I)->getOperand(1)->getName().str()));
      expr = symbol->symbol_expr();
    }
    else {
      errs()
          << get_var(
              scope_name_map.find(ni->getDebugLoc()->getScope())->second + "::"
                  + dyn_cast<StoreInst>(I)->getOperand(1)->getName().str());
      symbol = symbol_table.lookup(
          get_var(
              scope_name_map.find(ni->getDebugLoc()->getScope())->second + "::"
                  + dyn_cast<StoreInst>(I)->getOperand(1)->getName().str()));
      expr = symbol->symbol_expr();
    }
  }
  else if (LoadInst *li = dyn_cast<LoadInst>(
      dyn_cast<StoreInst>(I)->getOperand(1))) {
    li->dump();
    expr = get_load(li, symbol_table, &symbol);
    expr = dereference_exprt(expr);
    // errs() << from_expr(expr) << "\n";
    // assert(false);
  }
  else if (dyn_cast<GetElementPtrInst>(dyn_cast<StoreInst>(I)->getOperand(1))) {
    if (!I->hasMetadata()) {
      symbol = symbol_table.lookup(
          get_var(
              scope_name_map.find(ni->getDebugLoc()->getScope())->second + "::"
                  + dyn_cast<StoreInst>(I)->getOperand(1)->getName().str()));
      expr = dereference_exprt(symbol->symbol_expr(), symbol->type);
    }
    else {
      symbol = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + dyn_cast<StoreInst>(I)->getOperand(1)->getName().str()));
      expr = dereference_exprt(symbol->symbol_expr(), symbol->type);
    }
    // assert(false);
  }
  else if (auto *CE = dyn_cast<ConstantExpr>(I->getOperand(1))) {
    GetElementPtrInst *GE = dyn_cast<GetElementPtrInst>(CE->getAsInstruction());
    if (!I->hasMetadata()) {
      symbol = symbol_table.lookup(
          get_var(
              scope_name_map.find(ni->getDebugLoc()->getScope())->second + "::"
                  + GE->getOperand(0)->getName().str()));
      expr = trans_ConstGetElementPtr(GE, symbol_table, &final_type,
                                      ni->getDebugLoc()->getScope());

      GE->deleteValue();
    }
    else {
      symbol = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + GE->getOperand(0)->getName().str()));
      expr = trans_ConstGetElementPtr(GE, symbol_table, &final_type,
                                      I->getDebugLoc()->getScope());

      GE->deleteValue();
    }
  }
  else {
    I->getOperand(1)->dump();
    assert(false && "this type is not handled");
  }
  errs() << "2 \n";
  exprt value_to_store;
  for (auto arg = I->getFunction()->arg_begin();
      arg != I->getFunction()->arg_end(); arg++) {
    if (dyn_cast<StoreInst>(I)->getOperand(0)->getName() == arg->getName()) {
      function_parameter_flag = 1;
      const symbolt *func = symbol_table.lookup(
          I->getFunction()->getName().str());

      auto params = to_code_type(func->type).parameters();
      for (auto i = params.begin(); i != params.end(); i++) {
        if (!(I->getFunction()->getName().str() + "::"
            + I->getOperand(0)->getName().str()).compare(
            i->get_identifier().c_str())) {

          value_to_store = symbol_exprt(i->get_identifier(), i->type());
          errs() << "Akash Dunno what to do now\n";
        }
      }
    }
  }
  if (!function_parameter_flag) {
    errs() << "3 \n";
    if (I->getOperand(0)->hasName()) {
      value_to_store = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + I->getOperand(0)->getName().str()))->symbol_expr();
    }
    else if (dyn_cast<Constant>(dyn_cast<StoreInst>(I)->getOperand(0))) {
      if (dyn_cast<ConstantInt>(dyn_cast<StoreInst>(I)->getOperand(0))) {
        uint64_t val = dyn_cast<ConstantInt>(
            dyn_cast<StoreInst>(I)->getOperand(0))->getZExtValue();
        if (dyn_cast<GetElementPtrInst>(
            dyn_cast<StoreInst>(I)->getOperand(1))) {
          dyn_cast<GetElementPtrInst>(dyn_cast<StoreInst>(I)->getOperand(1))
              ->dump();
          errs() << "\n........... " << symbol->type.id().c_str() << " .. "
                 << symbol->type.subtype().id().c_str() << " " << val << "\n";
          // to handle multidimentional array.
          typet t = symbol->type.subtype();
          if (t.id() == ID_struct)
            t = final_type;
          else
            while (!(t.id() == ID_signedbv || t.id() == ID_unsignedbv)) {
              // errs() << "mew " << t.id().c_str() << "\n";

              t = t.subtype();
              // int k;
              // std::cin >> k;
              // errs() << (t.id()==ID_signedbv) << " " << (t.id()==ID_unsignedbv) << " " << !(t.id()==ID_signedbv || t.id()==ID_unsignedbv) << "\n";
            }
          errs() << "hi " << t.id().c_str() << "\n";
          value_to_store = from_integer(val, t);
          flag = 0;
          // assert(false);
        }
        else {
          typet t = symbol->type;

          if (t.id() == ID_struct)
            t = final_type;
          else
            while (!(t.id() == ID_signedbv || t.id() == ID_unsignedbv)) {
              t = t.subtype();
            }
          value_to_store = from_integer(val, t);
          flag = 0;
//        value_to_store = from_integer(val, symbol->type);
        }
      }
      else if (dyn_cast<ConstantFP>(dyn_cast<StoreInst>(I)->getOperand(0))) {
        errs() << "ConstantFP";
        Type *floattype = dyn_cast<Type>(
            dyn_cast<StoreInst>(I)->getOperand(0)->getType());
        if (floattype->isFloatTy()) {
          float val = dyn_cast<ConstantFP>(
              dyn_cast<StoreInst>(I)->getOperand(0))->getValueAPF()
              .convertToFloat();
          ieee_floatt ieee_fl(float_type());
          ieee_fl.from_float(val);
//          exprt rounding = symbol_table.lookup("__CPROVER_rounding_mode")
//              ->symbol_expr();
//          value_to_store = floatbv_typecast_exprt(ieee_fl.to_expr(), rounding,
//                                                  float_type());
          value_to_store = ieee_fl.to_expr();
        }
        else if (floattype->isDoubleTy()) {
          double val = dyn_cast<ConstantFP>(
              dyn_cast<StoreInst>(I)->getOperand(0))->getValueAPF()
              .convertToDouble();
          ieee_floatt ieee_fl(double_type());
          ieee_fl.from_double(val);
//          exprt rounding = symbol_table.lookup("__CPROVER_rounding_mode")
//              ->symbol_expr();
//          value_to_store = floatbv_typecast_exprt(ieee_fl.to_expr(), rounding,
//                                                  double_type());
          value_to_store = ieee_fl.to_expr();
          errs() << "================\n";
          errs() << from_expr(value_to_store);
        }
        else {
          I->dump();
          assert(
              false
                  && "This floating point type in above instruction is not handled");
        }
      }
      else {
        // I->dump();
        if (Instruction *i = dyn_cast<ConstantExpr>(I->getOperand(0))
            ->getAsInstruction()) {
          if (dyn_cast<GetElementPtrInst>(i)) {
            typet dummy;
            value_to_store = trans_ConstGetElementPtr(
                dyn_cast<GetElementPtrInst>(i), symbol_table, &dummy,
                I->getDebugLoc()->getScope());
          }
          else if (PtrToIntInst *ptr_to_int = dyn_cast<PtrToIntInst>(i)) {
            if (!I->hasMetadata()) {
              auto name_of_var = get_var(
                  scope_name_map.find(ni->getDebugLoc()->getScope())->second
                      + "::" + ptr_to_int->getOperand(0)->getName().str());
              const symbolt *var = symbol_table.lookup(name_of_var);
              value_to_store = address_of_exprt(var->symbol_expr());
            }
            else {
              auto name_of_var = get_var(
                  scope_name_map.find(I->getDebugLoc()->getScope())->second
                      + "::" + ptr_to_int->getOperand(0)->getName().str());
              const symbolt *var = symbol_table.lookup(name_of_var);
              value_to_store = address_of_exprt(var->symbol_expr());
            }
          }
          else if (dyn_cast<BitCastInst>(i)) {
            typet temp = expr.type();
            while (temp.id() == ID_pointer || temp.id() == ID_array)
              temp = temp.subtype();
            value_to_store = trans_ConstBitCast(
                i, symbol_table, I->getDebugLoc()->getScope(),
                temp.id() == ID_empty ? true : false, &expr.type());
          }
          else {
            assert(false && "This constant type is not handled");
          }
          i->deleteValue();
        }
        else {
          if (!I->hasMetadata()) {
            auto name_of_var = get_var(
                scope_name_map.find(ni->getDebugLoc()->getScope())->second
                    + "::" + I->getOperand(0)->getName().str());
            const symbolt *var = symbol_table.lookup(name_of_var);
            value_to_store = var->symbol_expr();
          }
          else {
            auto name_of_var = get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + I->getOperand(0)->getName().str());
            const symbolt *var = symbol_table.lookup(name_of_var);
            value_to_store = var->symbol_expr();
          }
        }
      }
    }

    else if (BitCastInst *bci = dyn_cast<BitCastInst>(
        dyn_cast<StoreInst>(I)->getOperand(0))) {
      typet temp = expr.type();
      while (temp.id() == ID_pointer || temp.id() == ID_array)
        temp = temp.subtype();
      if (bci->getOperand(0)->hasName()) {
//        symbol = symbol_table.lookup(
//            get_var(
//                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
//                    + bci->getOperand(0)->getName().str()));
//        value_to_store = symbol->symbol_expr();
        value_to_store = trans_ConstBitCast(
            bci, symbol_table, I->getDebugLoc()->getScope(),
            temp.id() == ID_empty ? true : false, &expr.type());

//        if (gep_symbols.find(symbol) != gep_symbols.end()) {
//          value_to_store = dereference_exprt(value_to_store);
//        }
      }
      else {
        value_to_store = trans_ConstBitCast(
            dyn_cast<Instruction>(I->getOperand(0)), symbol_table,
            I->getDebugLoc()->getScope(), temp.id() == ID_empty ? true : false,
            &expr.type());
      }
      // symbol.show(std::cout);
      // value_to_store = typecast_exprt(value_to_store, symbol.type);
    }
    else {
      if (dyn_cast<StoreInst>(I)->getOperand(0)->hasName()) {
        errs() << dyn_cast<StoreInst>(I)->getOperand(0)->getName();
        errs()
            << "searrching "
            << dyn_cast<StoreInst>(I)->getOperand(0)->getName()
            << "\n"
            << var_name_map.find(
                get_var(
                    scope_name_map.find(I->getDebugLoc()->getScope())->second
                        + "::"
                        + dyn_cast<StoreInst>(I)->getOperand(0)->getName().str()))
                ->first
            << "\n";
        const symbolt *temp_sym = nullptr;
        temp_sym = symbol_table.lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + dyn_cast<StoreInst>(I)->getOperand(0)->getName().str()));
        value_to_store = temp_sym->symbol_expr();
      }
      else if (dyn_cast<LoadInst>(dyn_cast<StoreInst>(I)->getOperand(0))) {
        // if(!dyn_cast<LoadInst>(dyn_cast<StoreInst>(I)->getOperand(0))->hasName())
        // {
        // }
        dyn_cast<LoadInst>(dyn_cast<StoreInst>(I)->getOperand(0))->dump();
        const symbolt *temp_sym = nullptr;
        value_to_store = get_load(
            dyn_cast<LoadInst>(dyn_cast<StoreInst>(I)->getOperand(0)),
            symbol_table, &temp_sym);

//        if (gep_symbols.find(temp_sym) != gep_symbols.end()) {
//          value_to_store = dereference_exprt(value_to_store);
//        }
        // std::string name = var_name_map.find(
        //   dyn_cast<LoadInst>(dyn_cast<StoreInst>(I)->getOperand(0))
        //   ->getOperand(0)->getName().str())->second;
        // value_to_store = symbol_table.lookup(name).symbol_expr();
        errs() << from_expr(value_to_store) << "\n";
        // assert(false);
      }
    }
  }
  errs() << "4 \n";
  typet expr_type = expr.type(), vts_type = value_to_store.type();
// TODO(Rasika) : need to check this. while
  {
    errs() << "5 \n";
    int i = 0;
    while (expr_type.id() == ID_pointer || expr_type.id() == ID_array) {
//    while (expr_type.id() == ID_pointer) {
      expr_type = expr_type.subtype();
      i++;
    }
    errs() << "6 \n";
    if (const Instruction *ins = dyn_cast<Instruction>(I->getOperand(0))) {
      while (!ins->hasName()) {
        ins = dyn_cast<Instruction>(ins->getOperand(0));
//        i--;
      }
    }
    errs() << "7 \n";
    if (dyn_cast<GetElementPtrInst>(I->getOperand(1))) {
      i--;
    }
    while (vts_type.id() == ID_pointer || vts_type.id() == ID_array) {
//    while (expr_type.id() == ID_pointer) {
      vts_type = vts_type.subtype();
      i--;
    }
    errs() << "8 \n";
    if (i > 0) {
      errs() << "address_of_exprt is needed\n";
      errs() << expr_type.id().c_str() << "    ?    " << vts_type.id().c_str();
      pointer_typet ptr_type(expr_type, config.ansi_c.pointer_width);
//      array_typet arr_type(expr_type, from_integer(3, index_type()));
      if (flag) value_to_store = address_of_exprt(value_to_store, ptr_type);
      // expr_type = expr_type.subtype();
      // assert(false);
    }
  }
// expr_type = expr.type(); vts_type = value_to_store.type();
// if(expr_type.id() == ID_pointer)
// {
//   errs() << vts_type.id().c_str() << "\n";
//   value_to_store = address_of_exprt(value_to_store, to_pointer_type(expr_type));
//   expr_type = expr_type.subtype();
// }
  errs() << expr.type().id().c_str() << "             "
         << value_to_store.type().id().c_str();

  if (gep_symbols.find(symbol) != gep_symbols.end()
      && expr.type().id() == ID_pointer) {
    expr = dereference_exprt(expr);
  }

  if (expr.type().id() != value_to_store.type().id()) {
    value_to_store = typecast_exprt(value_to_store, expr.type());
    // assert(false);
  }
  errs() << "5 \n";
  goto_programt::targett store_inst = gp.add_instruction();
  store_inst->make_assignment();
  store_inst->code = code_assignt(expr, value_to_store);
  store_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  errs() << "6 \n";
  store_inst->source_location = location;
  store_inst->type = goto_program_instruction_typet::ASSIGN;
// gp.output(std::cout);
// assert(false);
  if (ni) ni->eraseFromParent();
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_AtomicCmpXchg

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::AtomicCmpXchg.

 Purpose: Map llvm::Instruction::AtomicCmpXchg to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_AtomicCmpXchg(const Instruction *I) {
  goto_programt gp;
  assert(false && "AtomicCmpXchg is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_AtomicRMW

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::AtomicRMW.

 Purpose: Map llvm::Instruction::AtomicRMW to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_AtomicRMW(const Instruction *I) {
  goto_programt gp;
  assert(false && "AtomicRMW is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Fence

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Fence.

 Purpose: Map llvm::Instruction::Fence to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Fence(const Instruction *I) {
  goto_programt gp;
  assert(false && "Fence is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_ConstGetElementPtr

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: exprt containing goto instruction corresponding to
 llvm::ConstantExpression::GetElementPtr.

 Purpose: Map llvm::ConstantExpr::GetElementPtr to corresponding goto instruction.

 \*******************************************************************/
exprt llvm2goto_translator::trans_ConstGetElementPtr(
    const GetElementPtrInst *I, const symbol_tablet &symbol_table,
    typet *final_type, DILocalScope * DIScp) {
  exprt op_expr;
  const symbolt *op_symbol = nullptr;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();

  if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
//    op_symbol = symbol_table.lookup(
//        var_name_map.find(li->getOperand(0)->getName().str())->second);
    op_expr = get_load(li, symbol_table, &op_symbol);
  }

  else {
    auto var = I->getOperand(0);
    std::string var_name = get_var(
        scope_name_map.find(DIScp)->second + "::" + var->getName().str());
    op_symbol = symbol_table.lookup(var_name);
    op_expr = op_symbol->symbol_expr();
  }

  if (op_symbol->type.id() == ID_struct) {
    const struct_typet struct_t = to_struct_type(op_symbol->type);
    for (unsigned i = 2; i < I->getNumOperands(); i++) {
      exprt struct_member_expr;
      unsigned index;
      auto index_operand = I->getOperand(i);

      index = dyn_cast<ConstantInt>(index_operand)->getZExtValue();

      auto component = struct_t.components().at(index);
      *final_type = component.type();
      op_expr = member_exprt(op_expr, component);

      if (component.type().id() == ID_array
          || component.type().id() == ID_pointer) {
        typet temp = component.type();
        while ((temp.id() == ID_array || temp.id() == ID_pointer)
            && i < I->getNumOperands()) {
          temp = temp.subtype();
          *final_type = temp;
          i++;
          index_operand = I->getOperand(i);
          exprt array_index_expr;
          if (dyn_cast<ConstantInt>(index_operand)) {
            index = dyn_cast<ConstantInt>(index_operand)->getZExtValue();
            array_index_expr = from_integer(index, index_type());
          }
          else {
            std::string index_op_name = get_var(
                scope_name_map.find(DIScp)->second + "::"
                    + index_operand->getName().str());
            array_index_expr =
                symbol_table.lookup(index_op_name)->symbol_expr();
          }
          op_expr = index_exprt(op_expr, array_index_expr);
        }
      }
    }
  }
  else
    for (unsigned i = 2; i < I->getNumOperands(); i++) {

      exprt array_index_expr;
      auto index_operand = I->getOperand(i);

      if (dyn_cast<ConstantInt>(index_operand)) {
        unsigned index = dyn_cast<ConstantInt>(index_operand)->getZExtValue();
        array_index_expr = from_integer(index, index_type());
      }
      else {
        std::string index_op_name = get_var(
            scope_name_map.find(DIScp)->second + "::"
                + index_operand->getName().str());
        array_index_expr = symbol_table.lookup(index_op_name)->symbol_expr();
      }
      op_expr = index_exprt(op_expr, array_index_expr);
    }
  return op_expr;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_GetElementPtr

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::GetElementPtr.

 Purpose: Map llvm::Instruction::GetElementPtr to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_GetElementPtr(
    const Instruction *I, symbol_tablet &symbol_table) {
  goto_programt gp;
  I->dump();
  dyn_cast<GetElementPtrInst>(I)->getSourceElementType()->dump();
  dyn_cast<GetElementPtrInst>(I)->getResultElementType()->dump();
  const symbolt *comp = nullptr;
  exprt comp_expr;
  bool bit_cast_flag = false;
  if (dyn_cast<GetElementPtrInst>(I)->getPointerOperand()->hasName()) {
    std::string name_of_composite_var;
    name_of_composite_var =
        get_var(
            scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                + dyn_cast<GetElementPtrInst>(I)->getPointerOperand()->getName()
                    .str());
    errs() << name_of_composite_var << "\n";
    auto vnm = var_name_map.find(name_of_composite_var);
    std::string comp_var_full_name;
    if (vnm == var_name_map.end()) {
      comp_var_full_name = name_of_composite_var;
    }
    else {
      comp_var_full_name = var_name_map.find(name_of_composite_var)->first;
    }
    comp = symbol_table.lookup(comp_var_full_name);
    comp_expr = comp->symbol_expr();
  }
  else if (const BitCastInst *bci = dyn_cast<BitCastInst>(
      dyn_cast<GetElementPtrInst>(I)->getPointerOperand())) {
    bci->getDestTy()->dump();
    bci->getType()->dump();
    if (bci->getOperand(0)->hasName()) {
      comp = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + bci->getOperand(0)->getName().str()));
      comp_expr = comp->symbol_expr();
    }
    comp_expr = typecast_exprt(address_of_exprt(comp_expr),
                               symbol_creator::create_type(bci->getDestTy()));
    bit_cast_flag = true;
    // errs() << from_expr(comp_expr);
    // assert(false && "ge");
  }
  else {
    dyn_cast<GetElementPtrInst>(I)->getPointerOperand()->dump();
    comp_expr = get_load(
        dyn_cast<LoadInst>(dyn_cast<GetElementPtrInst>(I)->getPointerOperand()),
        symbol_table, &comp);
    // assert(false && "unnamed operand in this instruction is not handled");
  }
  int index = 0;
  exprt indx_epr;
  dyn_cast<User>(dyn_cast<GetElementPtrInst>(I)->idx_begin())->dump();
  for (auto i = dyn_cast<GetElementPtrInst>(I)->idx_begin();
      i != dyn_cast<GetElementPtrInst>(I)->idx_end(); i++) {
    if (dyn_cast<ConstantInt>(i)) {
      index = dyn_cast<ConstantInt>(i)->getZExtValue();
//      indx_epr = from_integer(index, unsignedbv_typet(32));
      indx_epr = from_integer(index, index_type());  // akash
    }
    else {
      dyn_cast<User>(i)->dump();
//      errs() << var_name_map.find(dyn_cast<User>(i)->getName().str())->second
//             << "\n";
      indx_epr = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + dyn_cast<User>(i)->getName().str()))->symbol_expr();
      // assert(false && "unknown type");
    }
  }
  dyn_cast<GetElementPtrInst>(I)->getSourceElementType()->dump();
  if (dyn_cast<GetElementPtrInst>(I)->getSourceElementType()->isArrayTy()) {
    I->dump();
    if (var_name_map.find(
        get_var(
            scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                + I->getName().str())) == var_name_map.end()) {
      symbolt symbol;
      symbol.base_name = I->getName().str();
      symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
          + "::" + I->getName().str();
      var_name_map.insert(
          std::pair<std::string, std::string>(symbol.name.c_str(),
                                              symbol.base_name.c_str()));  //akash fixed

      llvm::User::const_value_op_iterator ub = I->value_op_begin();

      const symbolt *op1 = nullptr;
      if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
        li->getOperand(0)->dump();
//        op1 = symbol_table.lookup(
//            var_name_map.find(li->getOperand(0)->getName().str())->second);
        get_load(li, symbol_table, &op1);
        if (op1->type.id() == ID_pointer) {
          symbol.type = pointer_typet(op1->type.subtype().subtype(),
                                      config.ansi_c.pointer_width);
        }
        else {
          symbol.type = pointer_typet(op1->type.subtype(),
                                      config.ansi_c.pointer_width);
        }
      }
      else {
        if (comp->type.id() == ID_pointer && I->getNumOperands() > 2) {
          symbol.type = pointer_typet(comp->type.subtype().subtype(),
                                      config.ansi_c.pointer_width);
        }
        else {
          symbol.type = pointer_typet(comp->type.subtype(),
                                      config.ansi_c.pointer_width);
        }
      }

      symbol_table.add(symbol);
      gep_symbols.insert(symbol_table.lookup(symbol.name));
      goto_programt::targett decl_add = gp.add_instruction();
      decl_add->make_decl();
      decl_add->code = code_declt(symbol.symbol_expr());
      if (!(I->getName().str().compare("___temp_getelementptr"))) {
        decl_add->function = irep_idt(I->getFunction()->getName().str());
      }
      symbol.show(std::cout);
      // decl_add->source_location = location;
    }

    // dyn_cast<GetElementPtrInst>(I)->getPointerOperand ()->dump();
    // // errs() << var_name_map.find(
    // //   dyn_cast<GetElementPtrInst>(I)->getPointerOperand()->getName().str())->second << "\n";
    // // symbol_table.show(std::cout);
    // symbolt symbol = symbol_table.lookup(var_name_map.find(
    //   dyn_cast<GetElementPtrInst>(I)->getPointerOperand()->getName().str())->second);
    // comp.show(std::cout);
    // errs() << symbol.type.subtype().id().c_str() << "\n";
    // symbol.show(std::cout);
    dyn_cast<GetElementPtrInst>(I)->getPointerOperandType()->dump();
    // errs() << dyn_cast<GetElementPtrInst>(I)->getPointerAddressSpace () << "\n";
    // errs() << dyn_cast<GetElementPtrInst>(I)->getNumIndices ()  << "\n";
    // dyn_cast<GetElementPtrInst>(I)->getSourceElementType () ->dump();
    // dyn_cast<GetElementPtrInst>(I)->getResultElementType () ->dump();
    // errs() <<  dyn_cast<GetElementPtrInst>(I)->getAddressSpace () << "\n";
    // I->getMetadata()->dump();
    // symbol_creator::create_ArrayTy(type, mdn);
    goto_programt::targett assgn_inst = gp.add_instruction();
    assgn_inst->make_assignment();

    std::string full_name = get_var(
        scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
            + I->getName().str());
    bool need_deref_flag = true;
    Value* index_operand;
    if (I->getNumOperands() == 2) {
      need_deref_flag = false;
      index_operand = I->getOperand(1);
    }
    else
      index_operand = I->getOperand(2);
    exprt array_index_expr;
    if (dyn_cast<ConstantInt>(index_operand)) {
      unsigned index = dyn_cast<ConstantInt>(index_operand)->getZExtValue();
      array_index_expr = from_integer(index, index_type());
    }
    else {
      std::string index_op_name = get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + index_operand->getName().str());
      array_index_expr = symbol_table.lookup(index_op_name)->symbol_expr();
    }

    const symbolt *op1 = nullptr;
    llvm::User::const_value_op_iterator ub = I->value_op_begin();
    exprt array_expr;
    const symbolt *array_symbol;

    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      array_expr = get_load(li, symbol_table, &op1);
      array_symbol = op1;
    }
    else {
      auto array = I->getOperand(0);
      std::string array_name = get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + array->getName().str());
      array_symbol = symbol_table.lookup(array_name);
      array_expr = array_symbol->symbol_expr();
    }

    if (array_expr.type().id() == ID_array) {
      assgn_inst->code = code_assignt(
          symbol_table.lookup(full_name)->symbol_expr(),
          address_of_exprt(index_exprt(array_expr, array_index_expr)));
    }
    else {
      exprt expr_temp_1;
      if (!need_deref_flag) {
        expr_temp_1 = plus_exprt(array_expr, array_index_expr);
        assgn_inst->code = code_assignt(
            symbol_table.lookup(full_name)->symbol_expr(), expr_temp_1);
      }
      else {
        expr_temp_1 = dereference_exprt(array_expr);

        exprt expr_temp_2 = index_exprt(expr_temp_1, array_index_expr);

        exprt expr_temp_3 = address_of_exprt(expr_temp_2);

        assgn_inst->code = code_assignt(
            symbol_table.lookup(full_name)->symbol_expr(), expr_temp_3);
      }
    }

    if (!(I->getName().str().compare("___temp_getelementptr"))) {
      assgn_inst->function = irep_idt(I->getFunction()->getName().str());
    }
    assgn_inst->type = goto_program_instruction_typet::ASSIGN;
    errs() << assgn_inst->to_string().c_str();
    // assert(false && "Array type is not handled");
  }
  else if (dyn_cast<GetElementPtrInst>(I)->getSourceElementType()->isStructTy()) {
    typet temp = comp->type;
    if (bit_cast_flag) temp = comp_expr.type();
    while (temp.id() != ID_struct && temp.has_subtype())
      temp = temp.subtype();
    if (temp.id() != ID_struct) assert(
        false && "Akash Trying to get struct out of a non struct pointer type");
//    if (I->getNumOperands() <= 2) temp = comp->type;
//    errs()
//        << (to_struct_union_type(temp).components())[index].get_name().c_str();
    if (var_name_map.find(
        get_var(
            scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                + I->getName().str())) == var_name_map.end()) {
      symbolt symbol;
      symbol.base_name = I->getName().str();
      symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
          + "::" + I->getName().str();
      var_name_map.insert(
          std::pair<std::string, std::string>(symbol.name.c_str(),
                                              symbol.base_name.c_str()));  //akash fixed
      if (I->getNumOperands() > 2)
        symbol.type = pointer_typet(
            (to_struct_union_type(temp).components())[index].type(),
            config.ansi_c.pointer_width);
      else
        symbol.type = comp->type;
//      symbol.type = array_typet((to_struct_union_type(comp->type).components())[index].type(),
//          from_integer(index, index_type()));
      symbol_table.add(symbol);
      gep_symbols.insert(symbol_table.lookup(symbol.name));
      goto_programt::targett decl_add = gp.add_instruction();
      decl_add->make_decl();
      decl_add->code = code_declt(symbol.symbol_expr());
      decl_add->function = irep_idt(I->getFunction()->getName().str());
      // decl_add->source_location = location;
    }
//    errs() << "\nAKash :  "
//           << dyn_cast<GetElementPtrInst>(I)->getPointerOperand()->getName()
//           << '\n';
    symbol_exprt sym_exp;
    if (!bit_cast_flag
        && dyn_cast<GetElementPtrInst>(I)->getPointerOperand()->hasName()) sym_exp =
        symbol_table.lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + dyn_cast<GetElementPtrInst>(I)->getPointerOperand()
                        ->getName().str()))->symbol_expr();
//    const irep_idt &i_idt =
//        (to_struct_type(temp).components())[index].get_name();
    if (I->getNumOperands() > 2) {
      const struct_typet struct_t = to_struct_type(temp);
      auto component = struct_t.components().at(index);
      member_exprt member;
      if (bit_cast_flag
          || !dyn_cast<GetElementPtrInst>(I)->getPointerOperand()->hasName())
        member = member_exprt(dereference_exprt(comp_expr), component);
      else if (gep_symbols.find(
          symbol_table.lookup(
              get_var(
                  scope_name_map.find(I->getDebugLoc()->getScope())->second
                      + "::"
                      + dyn_cast<GetElementPtrInst>(I)->getPointerOperand()
                          ->getName().str()))) != gep_symbols.end()) {
        member = member_exprt(dereference_exprt(sym_exp), component);
      }
      else
        member = member_exprt(sym_exp, component);
      goto_programt::targett assgn_inst = gp.add_instruction();
      assgn_inst->make_assignment();
      std::string full_name = get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str());
      assgn_inst->code = code_assignt(
          symbol_table.lookup(full_name)->symbol_expr(),
          address_of_exprt(member));
      assgn_inst->function = irep_idt(I->getFunction()->getName().str());
      assgn_inst->type = goto_program_instruction_typet::ASSIGN;
    }
    else {
      goto_programt::targett assgn_inst = gp.add_instruction();
      assgn_inst->make_assignment();
      exprt lhs = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + I->getName().str()))->symbol_expr();
      exprt rhs = comp_expr;
//      if (dyn_cast<LoadInst>(I->getOperand(0))) {
//        rhs = get_load(dyn_cast<LoadInst>(I->getOperand(0)), symbol_table);
//      }
//      else if (I->getOperand(0)->hasName()) {
//        rhs = symbol_table.lookup(
//            get_var(
//                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
//                    + I->getOperand(0)->getName().str()))->symbol_expr();
//      }
//      else {
//        assert(false && "Akash Please handle this Operand Type");
//      }
      if (dyn_cast<LoadInst>(I->getOperand(1))) {
        rhs = plus_exprt(
            rhs, get_load(dyn_cast<LoadInst>(I->getOperand(1)), symbol_table));
      }
      else if (I->getOperand(1)->hasName()) {
        rhs = plus_exprt(
            rhs,
            symbol_table.lookup(
                get_var(
                    scope_name_map.find(I->getDebugLoc()->getScope())->second
                        + "::" + I->getOperand(1)->getName().str()))
                ->symbol_expr());
      }
      else if (dyn_cast<ConstantInt>(I->getOperand(1))) {
        unsigned index =
            dyn_cast<ConstantInt>(I->getOperand(1))->getZExtValue();
        rhs = plus_exprt(rhs, from_integer(index, index_type()));
      }
      else {
        assert(false && "Akash Please handle this Operand Type");
      }
      assgn_inst->code = code_assignt(lhs, rhs);
      assgn_inst->function = irep_idt(I->getFunction()->getName().str());
      assgn_inst->type = goto_program_instruction_typet::ASSIGN;
    }
  }
  else if (dyn_cast<GetElementPtrInst>(I)->getSourceElementType()->isPointerTy()) {
    if (dyn_cast<GetElementPtrInst>(I)->getNumIndices() == 1) {
      errs() << "(" << from_expr(comp_expr) << ")\n";
      // dyn_cast<GetElementPtrInst>(I)->idx_begin()->dump();
      auto i = dyn_cast<GetElementPtrInst>(I)->idx_begin();
      exprt indx_epr;
      if (dyn_cast<ConstantInt>(i)) {
        int index = dyn_cast<ConstantInt>(i)->getSExtValue();
        indx_epr = from_integer(index, signedbv_typet(config.ansi_c.int_width));
      }
      else {
        dyn_cast<User>(i)->dump();
        errs()
            << var_name_map.find(
                get_var(
                    scope_name_map.find(I->getDebugLoc()->getScope())->second
                        + "::" + dyn_cast<User>(i)->getName().str()))->first
            << "\n";
        indx_epr = symbol_table.lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + dyn_cast<User>(i)->getName().str()))->symbol_expr();
        // assert(false && "unknown type");
      }
      comp_expr = plus_exprt(comp_expr, indx_epr);
      if (var_name_map.find(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + I->getName().str())) == var_name_map.end()) {
        // TODO(Rasika) : handle sign
        symbolt symbol;
        symbol.base_name = I->getName().str();
        symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
            + "::" + I->getName().str();
        var_name_map.insert(
            std::pair<std::string, std::string>(symbol.name.c_str(),
                                                symbol.base_name.c_str()));  //akash fixed
        symbol.type = symbol_creator::create_type(I->getType());
        symbol_table.add(symbol);
        goto_programt::targett decl_comp = gp.add_instruction();
        decl_comp->make_decl();
        decl_comp->code = code_declt(symbol.symbol_expr());
        decl_comp->function = irep_idt(I->getFunction()->getName().str());
        // decl_comp->source_location = location;
        symbol.show(std::cout);
      }
      errs() << "(" << from_expr(comp_expr) << ")\n";
      goto_programt::targett assgn_inst = gp.add_instruction();
      assgn_inst->make_assignment();
      std::string full_name = get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str());
      assgn_inst->code = code_assignt(
          symbol_table.lookup(full_name)->symbol_expr(), comp_expr);
      assgn_inst->function = irep_idt(I->getFunction()->getName().str());
      assgn_inst->type = goto_program_instruction_typet::ASSIGN;
      // assert(false && "pointer arithmetic is not handled yet");
    }
    else {
      assert(
          false && "multiple arguments in GetElementPtrInst with pointer type");
    }
    // assert(false && "pointer type is not handled yet");
  }
  else {
    // TODO(Rasika) : check if the types match in assignment. 0th index
    // array to pointer.
    if (dyn_cast<GetElementPtrInst>(I)->getNumIndices() == 1) {
      errs() << "(" << from_expr(comp_expr) << ")\n";
      // dyn_cast<GetElementPtrInst>(I)->idx_begin()->dump();
      auto i = dyn_cast<GetElementPtrInst>(I)->idx_begin();
      exprt indx_epr;
      if (dyn_cast<ConstantInt>(i)) {
        int index = dyn_cast<ConstantInt>(i)->getSExtValue();
        indx_epr = from_integer(index, signedbv_typet(config.ansi_c.int_width));
      }
      else {
        dyn_cast<User>(i)->dump();
        errs()
            << var_name_map.find(
                get_var(
                    scope_name_map.find(I->getDebugLoc()->getScope())->second
                        + "::" + dyn_cast<User>(i)->getName().str()))->first
            << "\n";
        indx_epr = symbol_table.lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + dyn_cast<User>(i)->getName().str()))->symbol_expr();
        // assert(false && "unknown type");
      }
      comp_expr = plus_exprt(comp_expr, indx_epr);
      if (var_name_map.find(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + I->getName().str())) == var_name_map.end()) {
        // TODO(Rasika) : handle sign
        symbolt symbol;
        symbol.base_name = I->getName().str();
        symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
            + "::" + I->getName().str();
        var_name_map.insert(
            std::pair<std::string, std::string>(symbol.name.c_str(),
                                                symbol.base_name.c_str()));  //akash fixed
        symbol.type = symbol_creator::create_type(I->getType());
        symbol_table.add(symbol);
        gep_symbols.insert(symbol_table.lookup(symbol.name));
        goto_programt::targett decl_comp = gp.add_instruction();
        decl_comp->make_decl();
        decl_comp->code = code_declt(symbol.symbol_expr());
        decl_comp->function = irep_idt(I->getFunction()->getName().str());
        // decl_comp->source_location = location;
        symbol.show(std::cout);
      }
      errs() << "(" << from_expr(comp_expr) << ")\n";
      goto_programt::targett assgn_inst = gp.add_instruction();
      assgn_inst->make_assignment();
      std::string full_name = get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str());
      assgn_inst->code = code_assignt(
          symbol_table.lookup(full_name)->symbol_expr(), comp_expr);
      assgn_inst->function = irep_idt(I->getFunction()->getName().str());
      assgn_inst->type = goto_program_instruction_typet::ASSIGN;
      // assert(false && "pointer arithmetic is not handled yet");
    }
    else {
      errs() << ";;;;;;;;;;;;;;;;;;;\n";
      dyn_cast<GetElementPtrInst>(I)->getSourceElementType()->dump();
      errs() << dyn_cast<GetElementPtrInst>(I)->getNumIndices() << "\n";
      I->dump();
      I->getType()->dump();
      // dyn_cast<GetElementPtrInst>(I)->getSourceElementType()->dump();
      I->getOperand(0)->dump();
      I->getOperand(0)->getType()->dump();
      I->getOperand(1)->dump();
      I->getOperand(1)->getType()->dump();
      assert(false && "this type is not handled");
    }
  }
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Trunc

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Trunc.

 Purpose: Map llvm::Instruction::Trunc to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Trunc(const Instruction *I,
                                                symbol_tablet &symbol_table) {
  assert(
      !dyn_cast<TruncInst>(I)->isLosslessCast()
          && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type = signedbv_typet(
      dyn_cast<TruncInst>(I)->getDestTy()->getIntegerBitWidth());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr;
  exprt exprt1;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    // TODO(Rasika) : sign.
    exprt1 = from_integer(val, signedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
// }
// else
// {
//   exprt1 = op1.symbol_expr();
// }
    }
    else if (const PtrToIntInst *pi = dyn_cast<PtrToIntInst>(*ub)) {
      auto name_of_var = get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + pi->getOperand(0)->getName().str());
      exprt1 = address_of_exprt(
          symbol_table.lookup(name_of_var)->symbol_expr());
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = dest_type;
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));
  goto_programt::targett trunc_inst = gp.add_instruction();
  trunc_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  trunc_inst->code = code_assignt(result->symbol_expr(), tce);
  trunc_inst->function = irep_idt(I->getFunction()->getName().str());
  trunc_inst->source_location = location;
  trunc_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_ZExt

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::ZExt.

 Purpose: Map llvm::Instruction::ZExt to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_ZExt(const Instruction *I,
                                               symbol_tablet &symbol_table) {
  assert(
      !dyn_cast<ZExtInst>(I)->isLosslessCast()
          && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type = signedbv_typet(
      dyn_cast<ZExtInst>(I)->getDestTy()->getIntegerBitWidth());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr;
  exprt exprt1;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    // TODO(Rasika) : sign.
    exprt1 = from_integer(val, signedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
// }
// else
// {
//   exprt1 = op1.symbol_expr();
// }
    }
    else if (const PHINode *PI = dyn_cast<PHINode>(*ub)) {
      exprt1 = get_PHI(PI, symbol_table);
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = dest_type;
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));
  goto_programt::targett zext_inst = gp.add_instruction();
  zext_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  zext_inst->code = code_assignt(result->symbol_expr(), tce);
  zext_inst->function = irep_idt(I->getFunction()->getName().str());
  zext_inst->source_location = location;
  zext_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_SExt

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::SExt.

 Purpose: Map llvm::Instruction::SExt to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_SExt(const Instruction *I,
                                               symbol_tablet &symbol_table) {
  assert(
      !dyn_cast<SExtInst>(I)->isLosslessCast()
          && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type = signedbv_typet(
      dyn_cast<SExtInst>(I)->getDestTy()->getIntegerBitWidth());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr;  //  Akash reminder maybe no used of op1 here.
  exprt exprt1;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    // TODO(Rasika) : sign.
    exprt1 = from_integer(val, signedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
// }
// else
// {
//   exprt1 = op1.symbol_expr();
// }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = dest_type;
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));
  goto_programt::targett zext_inst = gp.add_instruction();
  zext_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  zext_inst->code = code_assignt(result->symbol_expr(), tce);
  zext_inst->function = irep_idt(I->getFunction()->getName().str());
  zext_inst->source_location = location;
  zext_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_FPTrunc

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::FPTrunc.

 Purpose: Map llvm::Instruction::FPTrunc to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_FPTrunc(const Instruction *I,
                                                  symbol_tablet &symbol_table) {
  assert(
      !dyn_cast<FPTruncInst>(I)->isLosslessCast()
          && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type;
  if (dyn_cast<FPTruncInst>(I)->getDestTy()->isFloatTy()) {
    dest_type = to_floatbv_type(bitvector_typet(ID_floatbv, 32));
  }
  else if (dyn_cast<FPTruncInst>(I)->getDestTy()->isDoubleTy()) {
    dest_type = to_floatbv_type(bitvector_typet(ID_floatbv, 64));
  }
  else {
    assert(false && "This floattype is not handled");
  }
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1;
  exprt exprt1;
  if (dyn_cast<ConstantFP>(*ub)) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*ub)->getType());
    if (floattype->isFloatTy()) {
      float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl(float_type());
      ieee_fl.from_float(val);
      exprt1 = ieee_fl.to_expr();
    }
    else if (floattype->isDoubleTy()) {
      double val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl(double_type());
      ieee_fl.from_double(val);
      exprt1 = ieee_fl.to_expr();
    }
    else {
      ub->dump();
      assert(
          false
              && "This floating point type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
// }
// else
// {
//   exprt1 = op1.symbol_expr();
// }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));
  goto_programt::targett fptrunc_inst = gp.add_instruction();
  fptrunc_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  fptrunc_inst->code = code_assignt(result->symbol_expr(), tce);
  fptrunc_inst->function = irep_idt(I->getFunction()->getName().str());
  fptrunc_inst->source_location = location;
  fptrunc_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_FPExt

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::FPExt.

 Purpose: Map llvm::Instruction::FPExt to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_FPExt(const Instruction *I,
                                                symbol_tablet &symbol_table) {
  assert(
      !dyn_cast<FPExtInst>(I)->isLosslessCast()
          && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type;
  if (dyn_cast<FPExtInst>(I)->getDestTy()->isFloatTy()) {
    dest_type = float_type();
  }
  else if (dyn_cast<FPExtInst>(I)->getDestTy()->isDoubleTy()) {
    dest_type = double_type();
  }
  else {
    assert(false && "This floattype is not handled");
  }
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr;
  exprt exprt1;
  if (dyn_cast<ConstantFP>(*ub)) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*ub)->getType());
    floattype->dump();
    if (floattype->isFloatTy()) {
      float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl(float_type());
      ieee_fl.from_float(val);
      exprt1 = ieee_fl.to_expr();
    }
    else if (floattype->isDoubleTy()) {
      double val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl(double_type());
      ieee_fl.from_double(val);
      exprt1 = ieee_fl.to_expr();
    }
    else {
      ub->dump();
      assert(
          false
              && "This floating point type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
// }
// else
// {
//   exprt1 = op1.symbol_expr();
// }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));
  goto_programt::targett fpext_inst = gp.add_instruction();
  fpext_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  fpext_inst->code = code_assignt(result->symbol_expr(), tce);
  fpext_inst->function = irep_idt(I->getFunction()->getName().str());
  fpext_inst->source_location = location;
  fpext_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_FPToUI

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::FPToUI.

 Purpose: Map llvm::Instruction::FPToUI to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_FPToUI(const Instruction *I,
                                                 symbol_tablet &symbol_table) {
  assert(
      !dyn_cast<FPToUIInst>(I)->isLosslessCast()
          && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type = signedbv_typet(
      dyn_cast<FPToUIInst>(I)->getDestTy()->getIntegerBitWidth());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1;
  exprt exprt1;
  if (dyn_cast<ConstantFP>(*ub)) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*ub)->getType());
    if (floattype->isFloatTy()) {
      float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl(float_type());
      ieee_fl.from_float(val);
      exprt1 = ieee_fl.to_expr();
    }
    else if (floattype->isDoubleTy()) {
      double val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl(double_type());
      ieee_fl.from_double(val);
      exprt1 = ieee_fl.to_expr();
    }
    else {
      ub->dump();
      assert(
          false
              && "This floating point type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
// }
// else
// {
//   exprt1 = op1.symbol_expr();
// }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));
  goto_programt::targett fp_to_ui = gp.add_instruction();
  fp_to_ui->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  fp_to_ui->code = code_assignt(result->symbol_expr(), tce);
  fp_to_ui->function = irep_idt(I->getFunction()->getName().str());
  fp_to_ui->source_location = location;
  fp_to_ui->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_FPToSI

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::FPToSI.

 Purpose: Map llvm::Instruction::FPToSI to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_FPToSI(const Instruction *I,
                                                 symbol_tablet &symbol_table) {
  assert(
      !dyn_cast<FPToSIInst>(I)->isLosslessCast()
          && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type = signedbv_typet(
      dyn_cast<FPToSIInst>(I)->getDestTy()->getIntegerBitWidth());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr;
  exprt exprt1;
  if (dyn_cast<ConstantFP>(*ub)) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*ub)->getType());
    if (floattype->isFloatTy()) {
      float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl(float_type());
      ieee_fl.from_float(val);
      exprt1 = ieee_fl.to_expr();
    }
    else if (floattype->isDoubleTy()) {
      double val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl(double_type());
      ieee_fl.from_double(val);
      exprt1 = ieee_fl.to_expr();
    }
    else {
      ub->dump();
      assert(
          false
              && "This floating point type in above instruction is not handled");
    }
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
// }
// else
// {
//   exprt1 = op1.symbol_expr();
// }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));
  goto_programt::targett fp_to_si = gp.add_instruction();
  fp_to_si->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  fp_to_si->code = code_assignt(result->symbol_expr(), tce);
  fp_to_si->function = irep_idt(I->getFunction()->getName().str());
  fp_to_si->source_location = location;
  fp_to_si->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_UIToFP

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::UIToFP.

 Purpose: Map llvm::Instruction::UIToFP to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_UIToFP(const Instruction *I,
                                                 symbol_tablet &symbol_table) {
  assert(
      !dyn_cast<UIToFPInst>(I)->isLosslessCast()
          && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type;
  if (dyn_cast<FPTruncInst>(I)->getDestTy()->isFloatTy()) {
    dest_type = to_floatbv_type(bitvector_typet(ID_floatbv, 32));
  }
  else if (dyn_cast<FPTruncInst>(I)->getDestTy()->isDoubleTy()) {
    dest_type = to_floatbv_type(bitvector_typet(ID_floatbv, 64));
  }
  else {
    assert(false && "This floattype is not handled");
  }
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr;
  exprt exprt1;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    // default type unsigned.
    exprt1 = from_integer(val, signedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
// }
// else
// {
//   exprt1 = op1.symbol_expr();
// }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));
  goto_programt::targett uitofp_inst = gp.add_instruction();
  uitofp_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  uitofp_inst->code = code_assignt(result->symbol_expr(), tce);
  uitofp_inst->function = irep_idt(I->getFunction()->getName().str());
  uitofp_inst->source_location = location;
  uitofp_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_SIToFP

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::SIToFP.

 Purpose: Map llvm::Instruction::SIToFP to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_SIToFP(const Instruction *I,
                                                 symbol_tablet &symbol_table) {
  assert(
      !dyn_cast<SIToFPInst>(I)->isLosslessCast()
          && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type;
  if (dyn_cast<FPTruncInst>(I)->getDestTy()->isFloatTy()) {
    dest_type = to_floatbv_type(bitvector_typet(ID_floatbv, 32));
  }
  else if (dyn_cast<FPTruncInst>(I)->getDestTy()->isDoubleTy()) {
    dest_type = to_floatbv_type(bitvector_typet(ID_floatbv, 64));
  }
  else {
    assert(false && "This floattype is not handled");
  }
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr;
  exprt exprt1;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getSExtValue();
    exprt1 = from_integer(val,
                          signedbv_typet(I->getType()->getIntegerBitWidth()));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
// }
// else
// {
//   exprt1 = op1.symbol_expr();
// }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));
  goto_programt::targett sitofp_inst = gp.add_instruction();
  sitofp_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  sitofp_inst->code = code_assignt(result->symbol_expr(), tce);
  sitofp_inst->function = irep_idt(I->getFunction()->getName().str());
  sitofp_inst->source_location = location;
  sitofp_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_IntToPtr

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::IntToPtr.

 Purpose: Map llvm::Instruction::IntToPtr to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_IntToPtr(const Instruction *I) {
  goto_programt gp;
  assert(false && "IntToPtr is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_PtrToInt

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::PtrToInt.

 Purpose: Map llvm::Instruction::PtrToInt to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_PtrToInt(
    const Instruction *I, symbol_tablet &symbol_table) {
  goto_programt gp;
  const symbolt *op1;
  exprt exprt1;
  typet dest_type;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    // default type unsigned.
    exprt1 = from_integer(val, signedbv_typet(config.ansi_c.int_width));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
      exprt1 = get_load(li, symbol_table, &op1);
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      if (gep_symbols.find(op1) != gep_symbols.end())
        exprt1 = op1->symbol_expr();
      else
        exprt1 = address_of_exprt(op1->symbol_expr());
    }
  }

  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }

  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = unsigned_int_type();
    dest_type = symbol.type;
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));
  goto_programt::targett sitofp_inst = gp.add_instruction();
  sitofp_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  sitofp_inst->code = code_assignt(result->symbol_expr(), tce);
  sitofp_inst->function = irep_idt(I->getFunction()->getName().str());
  sitofp_inst->source_location = location;
  sitofp_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_BitCast

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::BitCast.

 Purpose: Map llvm::Instruction::BitCast to corresponding goto instruction.

 \*******************************************************************/
exprt llvm2goto_translator::trans_ConstBitCast(
    const Instruction *I, const symbol_tablet &symbol_table,
    DILocalScope *DIScp, bool is_void_type, typet *in_type) {
  exprt expr;
  auto *bci = dyn_cast<BitCastInst>(I);
  typet out_type;
  if (in_type)
    out_type = *in_type;
  else
    out_type = symbol_creator::create_type(bci->getDestTy(), is_void_type);
//  const symbolt *symbol = nullptr;
  if (I->getOperand(0)->hasName()) {
    const symbolt *symbol = symbol_table.lookup(
        get_var(
            scope_name_map.find(DIScp)->second + "::"
                + I->getOperand(0)->getName().str()));
    if (gep_symbols.find(symbol) != gep_symbols.end())
      expr = symbol->symbol_expr();
    else
      expr = address_of_exprt(symbol->symbol_expr());
  }
  else if (auto *LI = dyn_cast<LoadInst>(I->getOperand(0)))
    expr = get_load(LI, symbol_table);
  else
    assert(
        false
            && "Akash fix unhandled operand types, like maybe constgetelement ptr, etc");
//  if (is_void_type) out_type = pointer_typet(void_typet(),
//                                             config.ansi_c.pointer_width);
  return typecast_exprt(expr, out_type);
}

/*******************************************************************
 Function: llvm2goto_translator::trans_BitCast

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::BitCast.

 Purpose: Map llvm::Instruction::BitCast to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_BitCast(const Instruction *I) {
  goto_programt gp;
  if (I->hasName()) {
    assert(false && "BitCast is yet to be mapped \n");
  }
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_AddrSpaceCast

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::AddrSpaceCast.

 Purpose: Map llvm::Instruction::AddrSpaceCast to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_AddrSpaceCast(const Instruction *I) {
  goto_programt gp;
  assert(false && "AddrSpaceCast is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Cmp

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::ICmp.

 Purpose: Map llvm::Instruction::ICmp to corresponding goto instruction.

 \*******************************************************************/
exprt llvm2goto_translator::trans_Cmp(const Instruction *I,
                                      symbol_tablet *symbol_table) {
  exprt condition;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  exprt opnd1, opnd2;
  typet type1, type2;
  int flag = 2, f1 = 0, f2 = 0;
  if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    opnd1 = get_load(li, *symbol_table);
    // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
    // {
    //   symbolt op1 = symbol_table->lookup(var_name_map.find(
    //     li->getOperand(0)->getName().str())->second);
    //   opnd1 = dereference_exprt(op1.symbol_expr(), op1.type);
    // }
    // else
    // {
    //   opnd1 = symbol_table->lookup(var_name_map.find(
    //     li->getOperand(0)->getName().str())->second).symbol_expr();
    // }
    f1 = 1;
  }
  else if (dyn_cast<ConstantExpr>(*ub)) {
    llvm::User::value_op_iterator temp = const_cast<Instruction*>(I)
        ->value_op_begin();
    auto *CE = dyn_cast<ConstantExpr>(*temp);
    GetElementPtrInst *GE = dyn_cast<GetElementPtrInst>(CE->getAsInstruction());

    typet dummy;
    opnd1 = address_of_exprt(
        trans_ConstGetElementPtr(GE, *symbol_table, &dummy,
                                 I->getDebugLoc()->getScope()));

    GE->deleteValue();
    f1 = 1;
  }
  if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
    li->getOperand(0)->dump();
    // opnd2 = symbol_table->lookup(var_name_map.find(
    //   li->getOperand(0)->getName().str())->second).symbol_expr();
    opnd2 = get_load(li, *symbol_table);
    f2 = 1;
  }
  else if (dyn_cast<ConstantExpr>(*(ub + 1))) {
    llvm::User::value_op_iterator temp = const_cast<Instruction*>(I)
        ->value_op_begin();
    auto *CE = dyn_cast<ConstantExpr>(*(temp + 1));
    GetElementPtrInst *GE = dyn_cast<GetElementPtrInst>(CE->getAsInstruction());

    typet dummy;
    opnd2 = address_of_exprt(
        trans_ConstGetElementPtr(GE, *symbol_table, &dummy,
                                 I->getDebugLoc()->getScope()));

    GE->deleteValue();
    f2 = 1;
  }
  if (f1 == 1 && f2 == 1) {
    // op_type = op1.type;
    errs() << "done!";
  }
  else if (I->getOperand(0)->getType()->isIntegerTy()
      || I->getOperand(1)->getType()->isIntegerTy()) {
    if (f1 == 0) {
      if (dyn_cast<ConstantInt>(*ub)) {
        flag = 1;
      }
      else {
        opnd1 = symbol_table->lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + ub->getName().str()))->symbol_expr();
      }
    }

    if (f2 == 0) {
      if (dyn_cast<ConstantInt>(*(ub + 1))) {
        flag = 0;
      }
      else {
        const symbolt *op2_sym = symbol_table->lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + (ub + 1)->getName().str()));

        opnd2 = op2_sym->symbol_expr();
      }
    }
    type1 = opnd1.type();
    type2 = opnd2.type();
    if (type2.id() == ID_pointer) {
      type2 = type2.subtype();
    }
    if (type1.id() == ID_pointer) {
      type1 = type1.subtype();
    }
    while (type1.id() == ID_array) {
      type1 = type1.subtype();
    }
    while (type2.id() == ID_array) {
      type2 = type2.subtype();
    }
    typet op_type;
    if (type2.id() == ID_signedbv) {
      op_type = type2;
    }
    if (type1.id() == ID_signedbv) {
      op_type = type1;
    }
    if (type2.id() == ID_unsignedbv) {
      op_type = type2;
    }
    if (type1.id() == ID_unsignedbv) {
      op_type = type1;
    }
    // // assert(false);
    if (op_type.id() == ID_signedbv && flag == 1) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub))->getSExtValue();
      typet type = op_type;
      opnd1 = from_integer(val, type);
    }
    if (op_type.id() == ID_signedbv && flag == 0) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub + 1))->getSExtValue();
      typet type = op_type;
      opnd2 = from_integer(val, type);
    }
    if (op_type.id() == ID_unsignedbv && flag == 1) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub))->getZExtValue();
      typet type = op_type;
      opnd1 = from_integer(val, type);
    }
    if (op_type.id() == ID_unsignedbv && flag == 0) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub + 1))->getZExtValue();
      typet type = op_type;
      opnd2 = from_integer(val, type);
    }
  }
  else {
    if (I->getOperand(0)->getType()->isFloatTy()) {
      if (f1 == 0) {
        if (dyn_cast<ConstantFP>(*ub)) {
          float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
          ieee_floatt ieee_fl(float_type());
          ieee_fl.from_float(val);
          opnd1 = ieee_fl.to_expr();
        }
      }
      if (f2 == 0) {
        if (dyn_cast<ConstantFP>(*(ub + 1))) {
          float val = dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF()
              .convertToFloat();
          ieee_floatt ieee_fl(float_type());
          ieee_fl.from_double(val);
//          exprt rounding = symbol_table->lookup("__CPROVER_rounding_mode")
//              ->symbol_expr();
//          opnd2 = floatbv_typecast_exprt(ieee_fl.to_expr(), rounding,
//                                         float_type());
          opnd2 = ieee_fl.to_expr();
        }
      }
    }
    else if (I->getOperand(0)->getType()->isDoubleTy()) {
      if (f1 == 0) {
        if (dyn_cast<ConstantFP>(*ub)) {
          double val =
              dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
          ieee_floatt ieee_fl(double_type());
          ieee_fl.from_double(val);
          opnd1 = ieee_fl.to_expr();
        }
      }
      if (f2 == 0) {
        if (dyn_cast<ConstantFP>(*(ub + 1))) {
          double val = dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF()
              .convertToDouble();
          ieee_floatt ieee_fl(double_type());
          ieee_fl.from_double(val);
          opnd2 = ieee_fl.to_expr();
        }
      }
    }
    else if (I->getOperand(0)->getType()->isPointerTy()) {
      I->getOperand(0)->getType()->dump();
      assert(false && "Pointer datatype has not been handled");
    }
    else {
      assert(false && "This datatype has not been handled");
    }
  }
  if (opnd1.type().id() != opnd2.type().id()) {
    opnd2 = typecast_exprt(opnd2, opnd1.type());
  }
  switch (dyn_cast<CmpInst>(I)->getPredicate()) {
    case CmpInst::Predicate::ICMP_EQ: {
      condition = equal_exprt(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::FCMP_OEQ:
    case CmpInst::Predicate::FCMP_UEQ: {
      condition = ieee_float_equal_exprt(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_NE: {
      condition = notequal_exprt(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::FCMP_ONE:
    case CmpInst::Predicate::FCMP_UNE: {
      condition = ieee_float_notequal_exprt(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_UGT:
    case CmpInst::Predicate::ICMP_SGT:
    case CmpInst::Predicate::FCMP_OGT:
    case CmpInst::Predicate::FCMP_UGT: {
      condition = binary_relation_exprt(opnd1, ID_gt, opnd2);
// condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_UGE:
    case CmpInst::Predicate::ICMP_SGE:
    case CmpInst::Predicate::FCMP_OGE:
    case CmpInst::Predicate::FCMP_UGE: {
      condition = binary_relation_exprt(opnd1, ID_ge, opnd2);
// condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_ULT:
    case CmpInst::Predicate::ICMP_SLT:
    case CmpInst::Predicate::FCMP_OLT:
    case CmpInst::Predicate::FCMP_ULT: {
      condition = binary_relation_exprt(opnd1, ID_lt, opnd2);
// condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_ULE:
    case CmpInst::Predicate::ICMP_SLE:
    case CmpInst::Predicate::FCMP_OLE:
    case CmpInst::Predicate::FCMP_ULE: {
      condition = binary_relation_exprt(opnd1, ID_le, opnd2);
// condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::BAD_ICMP_PREDICATE: {
      break;
    }
    default:
      errs() << "\nNON ICMP\n";
  }
  std::cout << from_expr(condition) << "\n";
// assert(false && "cmp");
  return condition;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Inverse_Cmp

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::ICmp.

 Purpose: Map llvm::Instruction::ICmp to corresponding goto instruction.

 \*******************************************************************/
exprt llvm2goto_translator::trans_Inverse_Cmp(const Instruction *I,
                                              symbol_tablet *symbol_table) {
// TODO(Rasika) : handle GetElementPtrInst
  exprt condition;
// I->dump();
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  exprt opnd1, opnd2;
  int flag = 2, f1 = 0, f2 = 0;
  if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    opnd1 = get_load(li, *symbol_table);
    // if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
    // {
    //   symbolt op1 = symbol_table->lookup(var_name_map.find(
    //     li->getOperand(0)->getName().str())->second);
    //   opnd1 = dereference_exprt(op1.symbol_expr(), op1.type);
    // }
    // else
    // {
    //   opnd1 = symbol_table->lookup(var_name_map.find(
    //     li->getOperand(0)->getName().str())->second).symbol_expr();
    // }
    f1 = 1;
  }
  if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
    li->getOperand(0)->dump();
    opnd2 = get_load(li, *symbol_table);
    // opnd2 = symbol_table->lookup(var_name_map.find(
    //   li->getOperand(0)->getName().str())->second).symbol_expr();
    f2 = 1;
  }
  if (f1 == 1 && f2 == 1) {
    // op_type = op1.type;
    errs() << "done!";
  }
  else if (I->getOperand(0)->getType()->isIntegerTy()
      || I->getOperand(1)->getType()->isIntegerTy()) {
    if (f1 == 0) {
      if (dyn_cast<ConstantInt>(*ub)) {
        flag = 1;
      }
      else {
        opnd1 = symbol_table->lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + ub->getName().str()))->symbol_expr();
      }
    }

    if (f2 == 0) {
      if (dyn_cast<ConstantInt>(*(ub + 1))) {
        flag = 0;
      }
      else {
        opnd2 = symbol_table->lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + (ub + 1)->getName().str()))->symbol_expr();
      }
    }

    typet op_type;
    if (opnd2.type().id() == ID_signedbv) {
      op_type = opnd2.type();
    }
    if (opnd1.type().id() == ID_signedbv) {
      op_type = opnd1.type();
    }
    if (opnd2.type().id() == ID_unsignedbv) {
      op_type = opnd2.type();
    }
    if (opnd1.type().id() == ID_unsignedbv) {
      op_type = opnd1.type();
    }
    if (opnd2.type().id() == ID_pointer) {
      op_type = opnd2.type().subtype();
    }
    if (opnd1.type().id() == ID_pointer) {
      op_type = opnd1.type().subtype();
    }
    if (op_type.id() == ID_signedbv && flag == 1) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub))->getSExtValue();
      typet type = op_type;
      opnd1 = from_integer(val, type);
    }
    if (op_type.id() == ID_signedbv && flag == 0) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub + 1))->getSExtValue();
      typet type = op_type;
      opnd2 = from_integer(val, type);
    }
    if (op_type.id() == ID_unsignedbv && flag == 1) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub))->getZExtValue();
      typet type = op_type;
      opnd1 = from_integer(val, type);
    }
    if (op_type.id() == ID_unsignedbv && flag == 0) {
      uint64_t val = dyn_cast<ConstantInt>(*(ub + 1))->getZExtValue();
      typet type = op_type;
      opnd2 = from_integer(val, type);
    }
  }
  else {
    if (I->getOperand(0)->getType()->isFloatTy()) {
      if (f1 == 0) {
        if (dyn_cast<ConstantFP>(*ub)) {
          float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
          ieee_floatt ieee_fl(float_type());
          ieee_fl.from_float(val);
          opnd1 = to_constant_expr(ieee_fl.to_expr());
        }
      }
      if (f2 == 0) {
        if (dyn_cast<ConstantFP>(*(ub + 1))) {
          float val = dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF()
              .convertToFloat();
          ieee_floatt ieee_fl(float_type());
          ieee_fl.from_float(val);
          opnd2 = to_constant_expr(ieee_fl.to_expr());
        }
      }
    }
    else if (I->getOperand(0)->getType()->isDoubleTy()) {
      if (f1 == 0) {
        if (dyn_cast<ConstantFP>(*ub)) {
          double val =
              dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
          ieee_floatt ieee_fl(double_type());
          ieee_fl.from_double(val);
          opnd1 = ieee_fl.to_expr();
        }
      }
      if (f2 == 0) {
        if (dyn_cast<ConstantFP>(*(ub + 1))) {
          double val = dyn_cast<ConstantFP>(*(ub + 1))->getValueAPF()
              .convertToDouble();
          ieee_floatt ieee_fl(double_type());
          ieee_fl.from_double(val);
          opnd2 = ieee_fl.to_expr();
        }
      }
    }
    else {
      assert(false && "This datatype has not been handled");
    }
  }
  switch (dyn_cast<ICmpInst>(I)->getInversePredicate()) {
    case CmpInst::Predicate::ICMP_EQ: {
      condition = equal_exprt(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_NE: {
      condition = notequal_exprt(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_UGT:
    case CmpInst::Predicate::ICMP_SGT: {
      condition = exprt(ID_gt);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_UGE: {
      case CmpInst::Predicate::ICMP_SGE:
      condition = exprt(ID_ge);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_ULT:
    case CmpInst::Predicate::ICMP_SLT: {
      condition = exprt(ID_lt);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_ULE:
    case CmpInst::Predicate::ICMP_SLE: {
      condition = exprt(ID_le);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::BAD_ICMP_PREDICATE: {
      break;
    }
    default:
      errs() << "\nNON ICMP\n";
  }
  return condition;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_ICmp

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::ICmp.

 Purpose: Map llvm::Instruction::ICmp to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_ICmp(const Instruction *I,
                                               symbol_tablet *symbol_table) {
  goto_programt gp;
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();

    errs()
        << (scope_name_map.find(I->getDebugLoc()->getScope())
            == scope_name_map.end())
        << "\n";
    symbol.name = scope_name_map.find(
        I->getDebugLoc()->getScope()->getNonLexicalBlockFileScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = bool_typet();
    symbol.value = false_exprt();
    symbol_table->add(symbol);
    goto_programt::targett decl_cmp = gp.add_instruction();
    decl_cmp->make_decl();
    decl_cmp->code = code_declt(symbol.symbol_expr());
    decl_cmp->function = irep_idt(I->getFunction()->getName().str());
    // decl_cmp->source_location = location;
  }
  goto_programt::targett Icmp_inst = gp.add_instruction();

  typet dest_type = unsignedbv_typet(1);
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  Icmp_inst->source_location = location;
  Icmp_inst->make_assignment();
  Icmp_inst->code = code_assignt(
      symbol_table->lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + I->getName().str()))->symbol_expr(),
      trans_Cmp(I, symbol_table));
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_FCmp

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::FCmp.

 Purpose: Map llvm::Instruction::FCmp to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_FCmp(const Instruction *I,
                                               symbol_tablet *symbol_table) {
  goto_programt gp;
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = bool_typet();
    symbol_table->add(symbol);
    goto_programt::targett decl_cmp = gp.add_instruction();
    decl_cmp->make_decl();
    decl_cmp->code = code_declt(symbol.symbol_expr());
    decl_cmp->function = irep_idt(I->getFunction()->getName().str());
    // TODO(Rasika) : set the location
  }
  goto_programt::targett Fcmp_inst = gp.add_instruction();

  typet dest_type = unsignedbv_typet(1);
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  Fcmp_inst->source_location = location;
  Fcmp_inst->make_assignment();
  Fcmp_inst->code = code_assignt(
      symbol_table->lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + I->getName().str()))->symbol_expr(),
      trans_Cmp(I, symbol_table));
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_PHI

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::PHI.

 Purpose: Map llvm::Instruction::PHI to corresponding goto instruction.

 \*******************************************************************/

exprt llvm2goto_translator::get_PHI(const PHINode *I,
                                    symbol_tablet &symbol_table) {
  exprt expr;
  auto i = I->getNumOperands() - 1;
  for (auto &a : I->blocks()) {
    auto bb = I->getIncomingBlock(i);
    auto v = I->getIncomingValue(i);
    if (auto last_ins = dyn_cast<BranchInst>(bb->getTerminator())) {
      if (!last_ins->isConditional()) {
        if (dyn_cast<ConstantInt>(v)) {
          auto val = dyn_cast<ConstantInt>(v)->getSExtValue();
          if (v->getType()->getIntegerBitWidth() == 1) {
            if (val) {
              expr = true_exprt();
            }
            else {
              expr = false_exprt();
            }
          }
        }
        else if (auto temp = dyn_cast<PHINode>(v)) {
          expr = get_PHI(temp, symbol_table);
        }
        else if (v->hasName()) {
          auto name = get_var(
              scope_name_map.find(
                  dyn_cast<Instruction>(v)->getDebugLoc()->getScope())->second
                  + "::" + dyn_cast<Instruction>(v)->getName().str());
          expr = symbol_table.lookup(name)->symbol_expr();
        }
      }
      else {
        exprt cond;
        cond = symbol_table.lookup(
            get_var(
                scope_name_map.find(last_ins->getDebugLoc()->getScope())->second
                    + "::" + last_ins->getOperand(0)->getName().str()))
            ->symbol_expr();
        exprt f;
        if (dyn_cast<ConstantInt>(v)) {
          auto val = dyn_cast<ConstantInt>(v)->getSExtValue();
          if (v->getType()->getIntegerBitWidth() == 1) {
            if (val) {
              f = true_exprt();
            }
            else {
              f = false_exprt();
            }
          }
        }
        else if (auto temp = dyn_cast<PHINode>(v)) {
          f = get_PHI(temp, symbol_table);
        }
        else if (v->hasName()) {
          auto name = get_var(
              scope_name_map.find(
                  dyn_cast<Instruction>(v)->getDebugLoc()->getScope())->second
                  + "::" + dyn_cast<Instruction>(v)->getName().str());
          f = symbol_table.lookup(name)->symbol_expr();
        }
        if (dyn_cast<BasicBlock>(last_ins->getOperand(1)) == I->getParent()) {
          expr = ternary_exprt(ID_if, cond, expr, f, bool_typet());
        }
        else {
          expr = ternary_exprt(ID_if, cond, f, expr, bool_typet());
        }
      }
    }
    else
      assert(
          false
              && "Akash Last instruction of PHINode Incoming Block must be BranchInst!");
    i--;
  }
  return expr;
}

//goto_programt llvm2goto_translator::trans_PHI(
//    const Instruction *I, symbol_tablet *symbol_table,
//    std::map<const BasicBlock*, goto_programt::targett> block_target_map,
//    goto_programt &g_prog) {
//  goto_programt gp;
//  I->dump();
//  errs() << "\n\n";
//  if (var_name_map.find(
//      get_var(
//          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
//              + I->getName().str())) == var_name_map.end()) {
//    symbolt symbol;
//    symbol.base_name = I->getName().str();
//    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
//    var_name_map.insert(
//        std::pair<std::string, std::string>(symbol.name.c_str(),
//                                            symbol.base_name.c_str()));  //akash fixed
//    // TODO(Rasika) : regain sign
//    symbol.type = symbol_creator::create_type(I->getType());
//    symbol_table->add(symbol);
//    goto_programt::targett decl_cmp = gp.add_instruction();
//    decl_cmp->make_decl();
//    decl_cmp->code = code_declt(symbol.symbol_expr());
//    decl_cmp->function = irep_idt(I->getFunction()->getName().str());
//    // TODO(Rasika) : set the location
//  }
//  symbolt s;
//  s.name = I->getName().str() + "_";
//  s.type = unsignedbv_typet(config.ansi_c.int_width);
//  symbol_table->add(s);
//  namespacet ns(*symbol_table);
//  unsigned n = 0;
//  for (auto i = block_target_map.begin(); i != block_target_map.end(); i++) {
//    // i->first->begin()->dump();
//    // gp.output_instruction(
//    //   ns,
//    //  "main",
//    //   std::cout,
//    //   i->second);
//    // std::cout << "\n";
//    goto_programt::targett assign_inst = g_prog.insert_after(i->second);
//    assign_inst->make_assignment();
//    assign_inst->code = code_assignt(
//        s.symbol_expr(),
//        from_integer(n, unsignedbv_typet(config.ansi_c.int_width)));
//    assign_inst->function = irep_idt(I->getFunction()->getName().str());
//
//    goto_programt::targett br = gp.add_instruction();
//
//    goto_programt::targett assign_inst1 = gp.add_instruction();
//    assign_inst1->make_assignment();
//    exprt value = from_integer(n, unsignedbv_typet(config.ansi_c.int_width));
//    errs() << "\n " << n << "   ---";
//    (dyn_cast<PHINode>(I)->getIncomingValue(n))->dump();
//    if (dyn_cast<PHINode>(I)->getIncomingValue(n)->hasName()) {
//      std::string name = dyn_cast<PHINode>(I)->getIncomingValue(n)->getName();
//      value = symbol_table->lookup(
//          get_var(
//              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
//                  + name))->symbol_expr();
//// assert(false && "hasName");
//    }
//    else if (auto a = dyn_cast<Constant>(
//        dyn_cast<PHINode>(I)->getIncomingValue(n))) {
//      if (dyn_cast<ConstantData>(a)) {
//        if (dyn_cast<ConstantInt>(a)) {
//          if (I->getType()->getIntegerBitWidth() == 1) {
//            if (dyn_cast<ConstantInt>(a)->isZero())
//              value = false_exprt();
//            else
//              value = true_exprt();
//          }
//          // dyn_cast<ConstantInt>(a)->dump();
//        }
//      }
//// assert(false);
//    }
//    assign_inst1->code = code_assignt(
//        symbol_table->lookup(
//            get_var(
//                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
//                    + I->getName().str()))->symbol_expr(),
//        value);
//    assign_inst1->function = irep_idt(I->getFunction()->getName().str());
//
//    goto_programt::targett skip = gp.add_instruction();
//    skip->make_skip();
//    br->make_goto(
//        skip,
//        notequal_exprt(
//            s.symbol_expr(),
//            from_integer(n, unsignedbv_typet(config.ansi_c.int_width))));
//    n = n + 1;
//  }
//  g_prog.update();
//  gp.update();
//  errs() << "\n\n";
//// assert(false && "PHI is yet to be mapped \n");
//  return gp;
//}

/*******************************************************************
 Function: llvm2goto_translator::trans_Select

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Select.

 Purpose: Map llvm::Instruction::Select to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Select(const Instruction *I) {
  goto_programt gp;
  assert(false && "Select is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::get_arg_name

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: name of first argument of instruction.

 Purpose: .

 \*******************************************************************/
std::string llvm2goto_translator::get_arg_name(const Instruction *I) {
  std::string temp_str;
  raw_string_ostream rso(temp_str);
  dyn_cast<CallInst>(I)->arg_begin()->get()->print(rso);
  std::string arg = rso.str();
  int i = arg.size();
  for (; i >= 0; i--) {
    if (arg[i] == '%') {
      break;
    }
  }
  return std::string(arg, ++i, arg.size() - 1);
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Call

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Call.

 Purpose: Map llvm::Instruction::Call to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Call(const Instruction *I,
                                               symbol_tablet *symbol_table) {
  goto_programt gp;
  unsigned flag = 0;

  if (auto load_func = dyn_cast<LoadInst>(
      I->getOperand(I->getNumOperands() - 1))) {
    exprt func = get_load(load_func, *symbol_table);

    std::set<const symbolt *> actual_symbols;
    std::set<code_function_callt> func_calls;
    for (auto a : *symbol_table)
      if (a.second.type == func.type().subtype()
          && std::string("main").compare(a.second.name.c_str())) {
        actual_symbols.insert(symbol_table->lookup(a.second.name));
      }
    code_typet func__code_type = to_code_type((*actual_symbols.begin())->type);
    symbolt ret;
    if (func__code_type.return_type() != empty_typet()) {
      ret.base_name = I->getName().str();
      ret.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
          + "::" + I->getName().str();
      var_name_map.insert(
          std::pair<std::string, std::string>(ret.name.c_str(),
                                              ret.base_name.c_str()));  //akash fixed
      ret.type = func__code_type.return_type();
      symbol_table->add(ret);
      goto_programt::targett decl_ret = gp.add_instruction();
      decl_ret->make_decl();
      decl_ret->code = code_declt(ret.symbol_expr());
    }

    for (auto func_sym : actual_symbols) {
      code_function_callt call;
      call.function() = func_sym->symbol_expr();
      call.lhs() = symbol_table->lookup(ret.name)->symbol_expr();
      llvm::User::const_value_op_iterator ub = I->value_op_begin();
      for (code_typet::parameterst::const_iterator p_it = func__code_type
          .parameters().begin(); p_it != func__code_type.parameters().end();
          p_it++) {
        exprt expr;
        if (dyn_cast<ConstantInt>(*ub)) {
          uint64_t val = dyn_cast<ConstantInt>(*ub)->getZExtValue();
          // TODO(Rasika) : get type parameters.
          typet type = unsignedbv_typet(config.ansi_c.int_width);
          dyn_cast<ConstantInt>(*ub)->getType()->dump();
          expr = from_integer(val, type);
        }
        else if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
          li->getOperand(0)->dump();
          expr = get_load(li, *symbol_table);
          // expr = symbol_table->lookup(var_name_map.find(
          //          li->getOperand(0)->getName().str())->second).symbol_expr();
        }
        else {
          expr = symbol_table->lookup(
              get_var(
                  scope_name_map.find(I->getDebugLoc()->getScope())->second
                      + "::" + ub->getName().str()))->symbol_expr();
        }
        call.arguments().push_back(expr);
        ub++;
      }
      func_calls.insert(call);
      errs() << "Akash here\n";
    }
    std::vector<goto_programt::targett> cond_targets;
    std::vector<goto_programt::targett> func_targets;
    std::vector<goto_programt::targett> goto_end_targets;
    for (auto actual_func_call : func_calls) {
      goto_programt::targett temp = gp.add_instruction();
      cond_targets.push_back(temp);
    }
    for (auto actual_func_call : func_calls) {
      goto_programt::targett temp = gp.add_instruction();
      func_targets.push_back(temp);
      goto_programt::targett temp2 = gp.add_instruction();
      goto_end_targets.push_back(temp2);
    }
    goto_programt::targett end = gp.add_instruction();
    end->make_skip();
    int i = 0;
    for (auto actual_func_call : func_calls) {
      func_targets[i]->make_function_call(actual_func_call);
      cond_targets[i]->make_goto(
          func_targets[i],
          equal_exprt(func, address_of_exprt(actual_func_call.function())));
      goto_end_targets[i]->make_goto(end, true_exprt());
      i++;
    }
    return gp;
  }

  if (const DbgDeclareInst *dbgDeclareInst = dyn_cast<DbgDeclareInst>(&*I)) {
    Type *type = &(*dyn_cast<Type>(
        dyn_cast<PointerType>(
            dyn_cast<Type>(dbgDeclareInst->getAddress()->getType()))
            ->getPointerElementType()));
    MDNode *mdn = dyn_cast<MDNode>(dbgDeclareInst->getVariable());
//    std::string name_to_remove = scope_name_map.find(
//        I->getDebugLoc()->getScope())->second + "::" + get_arg_name(I);
//    for (auto a : var_name_map)
//      errs() << a.first << "    " << a.second << '\n';
    std::string name_to_remove = get_var(
        scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
            + get_arg_name(I));
    auto m = var_name_map.find(name_to_remove);
    name_to_remove = m->second;
    for (auto arg = I->getFunction()->arg_begin();
        arg != I->getFunction()->arg_end(); arg++) {
      if (dyn_cast<DIVariable>(mdn)->getName() == arg->getName()) {
        flag = 1;
//        return gp;
      }
    }
//    errs() << "removing " << m->first << "\n";

    std::string full_name_to_remove = m->first;
    if (m != var_name_map.end()) var_name_map.erase(m);
    symbol_table->remove(full_name_to_remove);
    errs()
        << "\n adding "
        << (scope_name_map.find(
            I->getDebugLoc()->getScope()->getNonLexicalBlockFileScope())->second
            + "::" + dyn_cast<DIVariable>(mdn)->getName().str() + "\n");
    symbolt symbol;
    switch (dyn_cast<PointerType>(
        dyn_cast<Type>(dbgDeclareInst->getAddress()->getType()))
        ->getPointerElementType()->getTypeID()) {
// 16-bit floating point type
      case llvm::Type::TypeID::HalfTyID: {
        errs() << "\nHalf type";
        symbol = symbol_creator::create_HalfTy(type, mdn);
        break;
      }
        // 32-bit floating point type
      case llvm::Type::TypeID::FloatTyID: {
        errs() << "\nFloat type";
        symbol = symbol_creator::create_FloatTy(type, mdn);
        break;
      }
        // 64-bit floating point type
      case llvm::Type::TypeID::DoubleTyID: {
        symbol = symbol_creator::create_DoubleTy(type, mdn);
        errs() << "\nDouble type";
        break;
      }
        // 80-bit floating point type (X87)
      case llvm::Type::TypeID::X86_FP80TyID: {
        symbol = symbol_creator::create_X86_FP80Ty(type, mdn);
        errs() << "\nX86_FP80 type";
        break;
      }
        // 128-bit floating point type (112-bit mantissa)
      case llvm::Type::TypeID::FP128TyID: {
        symbol = symbol_creator::create_FP128Ty(type, mdn);
        errs() << "\nFP128 type";
        break;
      }
        // 128-bit floating point type (two 64-bits, PowerPC)
      case llvm::Type::TypeID::PPC_FP128TyID: {
        symbol = symbol_creator::create_PPC_FP128Ty(type, mdn);
        errs() << "\nPPC_FP128 type";
        break;
      }
      case llvm::Type::TypeID::IntegerTyID: {
        symbol = symbol_creator::create_IntegerTy(type, mdn);
        symbol.show(std::cout);
        errs() << "\nInteger type";
        // assert(false);
        break;
      }
      case llvm::Type::TypeID::StructTyID: {
        symbol = symbol_creator::create_StructTy(type, mdn);
        errs() << "\nStruct type";
        break;
      }
      case llvm::Type::TypeID::ArrayTyID: {
        symbol = symbol_creator::create_ArrayTy(type, mdn);
        errs() << "\n hi Array type";
        break;
      }
      case llvm::Type::TypeID::PointerTyID: {
        symbol = symbol_creator::create_PointerTy(type, mdn);
        errs() << "\nPointer type";
        break;
      }
      case llvm::Type::TypeID::VectorTyID: {
        symbol = symbol_creator::create_VectorTy(type, mdn);
        errs() << "\nVector type";
        break;
      }
      case llvm::Type::TypeID::X86_MMXTyID: {
        symbol = symbol_creator::create_X86_MMXTy(type, mdn);
        break;
      }
      case llvm::Type::TypeID::VoidTyID:
      case llvm::Type::TypeID::FunctionTyID:
      case llvm::Type::TypeID::TokenTyID:
      case llvm::Type::TypeID::LabelTyID:
      case llvm::Type::TypeID::MetadataTyID:
      default:
        errs() << "\ninvalid type for global variable";
    }
    if (flag) {
      symbol.name = full_name_to_remove;
      symbol.base_name = name_to_remove;
      var_name_map.insert(
          std::pair<std::string, std::string>(symbol.name.c_str(),
                                              symbol.base_name.c_str()));  //akash fixed
    }
    else {
//      symbol.name = scope_name_map.find(
//          dyn_cast<DILocalScope>(I->getDebugLoc()->getScope())
//              ->getNonLexicalBlockFileScope())->second + "::"
//          + dyn_cast<DIVariable>(mdn)->getName().str();
      symbol.name = scope_name_map.find(
          dyn_cast<DILocalScope>(I->getDebugLoc()->getScope())
              ->getNonLexicalBlockFileScope())->second + "::" + name_to_remove;
      symbol.base_name = dyn_cast<DIVariable>(mdn)->getName().str();
      var_name_map.insert(
          std::pair<std::string, std::string>(symbol.name.c_str(),
                                              symbol.base_name.c_str()));  //akash fixed
    }
    symbol_table->add(symbol);
    goto_programt::targett decl_symbol = gp.add_instruction();
    decl_symbol->make_decl();
    decl_symbol->code = code_declt(symbol.symbol_expr());
    source_locationt location = symbol.location;
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
    decl_symbol->source_location = location;
  }
  else if (dyn_cast<CallInst>(I)->getCalledFunction() == NULL) {
    // dyn_cast<CallInst>(I)->dump();
    const Value *called_val = dyn_cast<CallInst>(I)->getCalledValue();
    const Function *function = dyn_cast<Function>(
        called_val->stripPointerCasts());
    if (function->getName().str() == "__CPROVER_assume"
        || function->getName().str() == "assert") {
      goto_programt::targett ass_inst;
      if (function->getName().str() == "__CPROVER_assume") {
        ass_inst = gp.add_instruction(ASSUME);
      }
      else {
        ass_inst = gp.add_instruction(ASSERT);
      }
      exprt guard;
      if (const ConstantInt *i = dyn_cast<ConstantInt>(*I->value_op_begin())) {
        if (i->isZero()) {
          guard = false_exprt();
        }
        else {
          guard = true_exprt();
        }
      }
      else {
        const Instruction *op = dyn_cast<Instruction>(*(I->value_op_begin()));
        std::string op_code_name(op->getOpcodeName());

        auto op_name = op->getName().str();

        if (!(op_code_name.compare("zext") || op_code_name.compare("sext"))) {
          op_name = op->value_op_begin()->getName().str();
        }
        exprt op_symbol_expr;
        if (const LoadInst *li = dyn_cast<LoadInst>(op)) {
          op_symbol_expr = get_load(li, *symbol_table);
        }
        else {
          auto op_symbol_name = get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + op_name);
          op_symbol_expr = symbol_table->lookup(op_symbol_name)->symbol_expr();
        }
//        const Instruction *akash = dyn_cast<Instruction>(dyn_cast<Instruction>(I->getOperand(0))->getOperand(0));
//        guard = trans_Cmp(akash, symbol_table);
        guard = typecast_exprt(op_symbol_expr, bool_typet());
      }
      errs() << from_expr(guard) << "\n";
      ass_inst->guard = guard;
      source_locationt location;
      if (I->hasMetadata()) {
        if (&(I->getDebugLoc()) != NULL) {
          const DebugLoc loc = I->getDebugLoc();
          location.set_file(loc->getScope()->getFile()->getFilename().str());
          location.set_working_directory(
              loc->getScope()->getFile()->getDirectory().str());
          location.set_line(loc->getLine());
          location.set_column(loc->getColumn());
          // exprt e = trans_Cmp(dyn_cast<Instruction>(
          //   dyn_cast<Instruction>(I->op_begin())->op_begin()), symbol_table);
          // location.set_comment(
          //   from_expr(namespacet(*symbol_table),
          //     (symbol_table->symbols.begin()->second.name), e));
        }
      }
      ass_inst->source_location = location;
    }
  }
  else {
    const Function *function = dyn_cast<CallInst>(I)->getCalledFunction();
//    if (function->begin() != function->end()) {
    code_function_callt call;
    side_effect_expr_nondett nondef_func;
    std::string func_name = function->getName().str();
    symbolt symbol;

    if (!func_name.compare("nondet_int") || !func_name.compare("nondet_uint")) {
      typet ret_type;
      switch (function->getReturnType()->getTypeID()) {

        case llvm::Type::TypeID::HalfTyID: {
          ret_type = to_floatbv_type(bitvector_typet(ID_floatbv, 16));
          break;
        }
          // 32-bit floating point type
        case llvm::Type::TypeID::FloatTyID: {
          ret_type = to_floatbv_type(bitvector_typet(ID_floatbv, 32));
          break;
        }
          // 64-bit floating point type
        case llvm::Type::TypeID::DoubleTyID: {
          ret_type = to_floatbv_type(bitvector_typet(ID_floatbv, 64));
          break;
        }
          // 80-bit floating point type (X87)
        case llvm::Type::TypeID::X86_FP80TyID: {
          ret_type = to_floatbv_type(bitvector_typet(ID_floatbv, 80));
          break;
        }
          // 128-bit floating point type (112-bit mantissa)
        case llvm::Type::TypeID::FP128TyID: {
          ret_type = to_floatbv_type(bitvector_typet(ID_floatbv, 128));
          break;
        }
          // 128-bit floating point type (two 64-bits, PowerPC)
        case llvm::Type::TypeID::PPC_FP128TyID: {
          ret_type = to_floatbv_type(bitvector_typet(ID_floatbv, 128));
          break;
        }
        case llvm::Type::TypeID::IntegerTyID: {
          if (function->getReturnType()->getIntegerBitWidth() == 1) {
            ret_type = bool_typet();
          }
          else {
            ret_type = signedbv_typet(
                function->getReturnType()->getIntegerBitWidth());
          }
          break;
        }
        case llvm::Type::TypeID::VoidTyID: {
          // typet void_type = create_void_typet();
          ret_type = void_typet();
          errs() << "void_typet";
          break;
        }
        case llvm::Type::TypeID::StructTyID:
        case llvm::Type::TypeID::ArrayTyID:
        case llvm::Type::TypeID::PointerTyID:
        case llvm::Type::TypeID::VectorTyID:
        case llvm::Type::TypeID::X86_MMXTyID:
        case llvm::Type::TypeID::FunctionTyID:
        case llvm::Type::TypeID::TokenTyID:
        case llvm::Type::TypeID::LabelTyID:
        case llvm::Type::TypeID::MetadataTyID:
          errs() << "\n This type is not handled\n ";
      }
      source_locationt location;
      if (I->hasMetadata()) {
        if (&(I->getDebugLoc()) != NULL) {
          const DebugLoc loc = I->getDebugLoc();
          location.set_file(loc->getScope()->getFile()->getFilename().str());
          location.set_working_directory(
              loc->getScope()->getFile()->getDirectory().str());
          location.set_line(loc->getLine());
          location.set_column(loc->getColumn());
        }
      }

      nondef_func = side_effect_expr_nondett(ret_type, location);

      symbolt function_call_lhs;
      if (!function->getReturnType()->isVoidTy()) {
        function_call_lhs.base_name = I->getName().str();
        function_call_lhs.name = scope_name_map.find(
            I->getDebugLoc()->getScope())->second + "::" + I->getName().str();
        var_name_map.insert(
            std::pair<std::string, std::string>(
                function_call_lhs.name.c_str(),
                function_call_lhs.base_name.c_str()));    //akash fixed
        function_call_lhs.type = ret_type;
        symbol_table->add(function_call_lhs);
        goto_programt::targett decl_ret = gp.add_instruction();
        decl_ret->make_decl();
        decl_ret->code = code_declt(function_call_lhs.symbol_expr());
      }
      else {
        return gp;
      }

      goto_programt::targett store_inst = gp.add_instruction();
      store_inst->make_assignment();
      if (ret_type.id() != function_call_lhs.type.id()) {
        store_inst->code = code_assignt(
            function_call_lhs.symbol_expr(),
            typecast_exprt(nondef_func, function_call_lhs.type));
      }
      else
        store_inst->code = code_assignt(function_call_lhs.symbol_expr(),
                                        nondef_func);
      store_inst->function = irep_idt(I->getFunction()->getName().str());
      store_inst->source_location = location;
      store_inst->type = goto_program_instruction_typet::ASSIGN;
      return gp;
    }

    symbol = namespacet(*symbol_table).lookup(dstringt(func_name));
    call.function() = symbol.symbol_expr();
    if (to_code_type(symbol.type).return_type() != empty_typet()) {
      symbolt ret;
      ret.base_name = I->getName().str();
      ret.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
          + "::" + I->getName().str();
      var_name_map.insert(
          std::pair<std::string, std::string>(ret.name.c_str(),
                                              ret.base_name.c_str()));  //akash fixed
      ret.type = to_code_type(symbol.type).return_type();
      symbol_table->add(ret);
      goto_programt::targett decl_ret = gp.add_instruction();
      decl_ret->make_decl();
      decl_ret->code = code_declt(ret.symbol_expr());
      call.lhs() = ret.symbol_expr();
    }
    llvm::User::const_value_op_iterator ub = I->value_op_begin();
    for (code_typet::parameterst::const_iterator p_it = to_code_type(
        symbol.type).parameters().begin();
        p_it != to_code_type(symbol.type).parameters().end(); p_it++) {
      exprt expr;
      const symbolt *expr_symbol = nullptr;
      if (dyn_cast<ConstantInt>(*ub)) {
        uint64_t val = dyn_cast<ConstantInt>(*ub)->getZExtValue();
        // TODO(Rasika) : get type parameters.
        typet type = unsignedbv_typet(config.ansi_c.int_width);
        dyn_cast<ConstantInt>(*ub)->getType()->dump();
        expr = from_integer(val, type);
      }
      else if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
        li->getOperand(0)->dump();
        expr = get_load(li, *symbol_table, &expr_symbol);
        // expr = symbol_table->lookup(var_name_map.find(
        //          li->getOperand(0)->getName().str())->second).symbol_expr();
      }
      else {
        expr_symbol = symbol_table->lookup(
            get_var(
                scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                    + ub->getName().str()));
        expr = address_of_exprt(expr_symbol->symbol_expr());
      }
//      if (expr_symbol && used_load_inst) {
      if (gep_symbols.find(expr_symbol) != gep_symbols.end()) {
        expr = dereference_exprt(expr);
      }
//      }
      call.arguments().push_back(expr);
      assert(p_it->get_identifier() != irep_idt());
      ub++;
    }
    goto_programt::targett call_inst = gp.add_instruction();
    call_inst->make_function_call(call);
//    }
  }
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Shl

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::Shl.

 Purpose: Map llvm::Instruction::Shl to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Shl(const Instruction *I,
                                              symbol_tablet &symbol_table) {
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val,
                          unsignedbv_typet(I->getType()->getIntegerBitWidth()));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
// }
// else
// {
//   exprt1 = op1.symbol_expr();
// }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub + 1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, signed_int_type());
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt2 = dereference_exprt(op1.symbol_expr(), op2.type);
// }
// else
// {
//   exprt2 = op2.symbol_expr();
// }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
      exprt2 = op2->symbol_expr();
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));

  goto_programt::targett shl_inst = gp.add_instruction();
  shl_inst->make_assignment();
  shl_inst->code = code_assignt(result->symbol_expr(),
                                shl_exprt(exprt1, exprt2));
  shl_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  shl_inst->source_location = location;
  shl_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_LShr

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::LShr.

 Purpose: Map llvm::Instruction::LShr to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_LShr(const Instruction *I,
                                               symbol_tablet &symbol_table) {
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val,
                          unsignedbv_typet(I->getType()->getIntegerBitWidth()));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
// }
// else
// {
//   exprt1 = op1.symbol_expr();
// }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub + 1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val,
                          unsignedbv_typet(I->getType()->getIntegerBitWidth()));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt2 = dereference_exprt(op2->symbol_expr(), op2.type);
// }
// else
// {
//   exprt2 = op2.symbol_expr();
// }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
      exprt2 = op2->symbol_expr();
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    symbol.type = exprt1.type();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str()));

  goto_programt::targett lshr_inst = gp.add_instruction();
  lshr_inst->make_assignment();
  lshr_inst->code = code_assignt(result->symbol_expr(),
                                 lshr_exprt(exprt1, exprt2));
  lshr_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  lshr_inst->source_location = location;
  lshr_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_AShr

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::AShr.

 Purpose: Map llvm::Instruction::AShr to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_AShr(const Instruction *I,
                                               symbol_tablet &symbol_table) {
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  const symbolt *op1 = nullptr, *op2 = nullptr;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val,
                          unsignedbv_typet(I->getType()->getIntegerBitWidth()));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
      li->getOperand(0)->dump();
//      op1 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt1 = get_load(li, symbol_table, &op1);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt1 = dereference_exprt(op1.symbol_expr(), op1.type);
// }
// else
// {
//   exprt1 = op1.symbol_expr();
// }
    }
    else {
      op1 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + ub->getName().str()));
      exprt1 = op1->symbol_expr();
    }
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub + 1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val,
                          unsignedbv_typet(I->getType()->getIntegerBitWidth()));
  }
  else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
//      op2 = symbol_table.lookup(
//          var_name_map.find(li->getOperand(0)->getName().str())->second);
      exprt2 = get_load(li, symbol_table, &op2);
// if(dyn_cast<GetElementPtrInst>(li->getOperand(0)))
// {
//   exprt2 = dereference_exprt(op2.symbol_expr(), op2.type);
// }
// else
// {
//   exprt2 = op2.symbol_expr();
// }
    }
    else {
      op2 = symbol_table.lookup(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + (ub + 1)->getName().str()));
      exprt2 = op2->symbol_expr();
    }
  }
  if (var_name_map.find(
      get_var(
          scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
              + I->getName().str())) == var_name_map.end()) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
        + "::" + I->getName().str();
    var_name_map.insert(
        std::pair<std::string, std::string>(symbol.name.c_str(),
                                            symbol.base_name.c_str()));  //akash fixed
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code = code_declt(symbol.symbol_expr());
  }
  const symbolt *result = symbol_table.lookup(
      get_var(
          get_var(
              scope_name_map.find(I->getDebugLoc()->getScope())->second + "::"
                  + I->getName().str())));

  goto_programt::targett ashr_inst = gp.add_instruction();
  ashr_inst->make_assignment();
  ashr_inst->code = code_assignt(result->symbol_expr(),
                                 ashr_exprt(exprt1, exprt2));
  ashr_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (I->hasMetadata()) {
    if (&(I->getDebugLoc()) != NULL) {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc->getScope()->getFile()->getFilename().str());
      location.set_working_directory(
          loc->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  ashr_inst->source_location = location;
  ashr_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_VAArg

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::VAArg.

 Purpose: Map llvm::Instruction::VAArg to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_VAArg(const Instruction *I) {
  goto_programt gp;
  assert(false && "VAArg is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_ExtractElement

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::ExtractElement.

 Purpose: Map llvm::Instruction::ExtractElement to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_ExtractElement(const Instruction *I) {
  goto_programt gp;
  assert(false && "ExtractElement is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_InsertElement

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::InsertElement.

 Purpose: Map llvm::Instruction::InsertElement to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_InsertElement(const Instruction *I) {
  goto_programt gp;
  assert(false && "InsertElement is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_ShuffleVector

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::ShuffleVector.

 Purpose: Map llvm::Instruction::ShuffleVector to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_ShuffleVector(const Instruction *I) {
  goto_programt gp;
  assert(false && "ShuffleVector is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_ExtractValue

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::ExtractValue.

 Purpose: Map llvm::Instruction::ExtractValue to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_ExtractValue(const Instruction *I) {
  goto_programt gp;
  assert(false && "ExtractValue is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_InsertValue

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::InsertValue.

 Purpose: Map llvm::Instruction::InsertValue to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_InsertValue(const Instruction *I) {
  goto_programt gp;
  assert(false && "InsertValue is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_LandingPad

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::LandingPad.

 Purpose: Map llvm::Instruction::LandingPad to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_LandingPad(const Instruction *I) {
  goto_programt gp;
  assert(false && "LandingPad is yet to be mapped \n");
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_CleanupPad

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 llvm::Instruction::CleanupPad.

 Purpose: Map llvm::Instruction::CleanupPad to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_CleanupPad(const Instruction *I) {
  goto_programt gp;
  assert(false && "CleanupPad is yet to be mapped \n");
  return gp;
}

exprt llvm2goto_translator::get_initializer_list_exprt(
    Constant* llvm_list_val, typet array_type, symbol_tablet & symbol_table) {
  array_exprt array_list(to_array_type(array_type));
  if (auto temp = dyn_cast<ConstantArray>(llvm_list_val)) {
    for (unsigned i = 0; i < temp->getNumOperands(); i++) {
      auto val = temp->getAggregateElement(i);
      if (val->hasName()) {
        array_list.add_to_operands(
            address_of_exprt(
                symbol_table.lookup(val->getName().str())->symbol_expr()));
      }
      else
        array_list.add_to_operands(
            get_initializer_list_exprt(val, array_type.subtype(),
                                       symbol_table));
    }
  }
  else if (auto temp = dyn_cast<ConstantAggregateZero>(llvm_list_val)) {
    for (unsigned i = 0; i < temp->getNumElements(); i++) {
      if (array_type.subtype().has_subtype())
        array_list.add_to_operands(
            get_initializer_list_exprt(llvm_list_val, array_type.subtype(),
                                       symbol_table));
      else
        array_list.add_to_operands(from_integer(0, array_type.subtype()));
    }

  }
  else if (auto element = dyn_cast<ConstantDataArray>(llvm_list_val)) {
    for (unsigned i = 0; i < element->getNumElements(); i++) {
      auto val = element->getAggregateElement(i);
      if (auto temp = dyn_cast<ConstantInt>(val)) {
        array_list.add_to_operands(
            from_integer(temp->getZExtValue(), array_type.subtype()));
      }
      else if (auto cfp = dyn_cast<ConstantFP>(val)) {
        Type *floattype = dyn_cast<Type>(element->getElementType());
        if (floattype->isFloatTy()) {
          float float_val = cfp->getValueAPF().convertToFloat();
          ieee_floatt ieee_fl(float_type());
          ieee_fl.from_float(float_val);
          array_list.add_to_operands(ieee_fl.to_expr());
        }
        else if (floattype->isDoubleTy()) {
          double double_val = cfp->getValueAPF().convertToDouble();
          ieee_floatt ieee_fl(double_type());
          ieee_fl.from_double(double_val);
          array_list.add_to_operands(ieee_fl.to_expr());
        }
      }
    }
  }

  return array_list;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Globals

 Inputs:
 Mod - Pointer to the llvm module.

 Outputs: Object of namespacet.

 Purpose: Create apropriate goto symbol in symbol table corresponding to
 llvm global variable.

 \*******************************************************************/
symbol_tablet llvm2goto_translator::trans_Globals(const Module *Mod) {
// TODO(Rasika): signed type.
// TODO(Rasika): various name fields(cbmc).
  errs() << "in trans_Globals\n";
  symbol_tablet symbol_table;
  for (auto &GV : Mod->globals()) {
    SmallVector<MDNode *, 1> MDs;
    if (!GV.isDeclaration()) {
      GV.getMetadata(LLVMContext::MD_dbg, MDs);
      if (!MDs.empty()) {
        for (auto md = MDs.begin(), mde = MDs.end(); md != mde; md++) {
//          symbolt global_variable;
//          global_variable.clear();
//          global_variable.is_static_lifetime = true;
          for (auto mmd = (*md)->op_begin(); mmd != (*md)->op_end(); ++mmd) {
//            if (mmd->get()) {
            if (dyn_cast<DIGlobalVariable>(*mmd)) {
              switch (GV.getValueType()->getTypeID()) {
                // 16-bit floating point type
                case llvm::Type::TypeID::HalfTyID: {
                  errs() << "\nHalf type";
                  symbolt symbol = symbol_creator::create_HalfTy(
                      GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  var_name_map.insert(
                      std::pair<std::string, std::string>(
                          symbol.name.c_str(), symbol.base_name.c_str()));  //akash fixed
                  symbol_table.add(symbol);
                  break;
                }
                  // 32-bit floating point type
                case llvm::Type::TypeID::FloatTyID: {
                  errs() << "\nFloat type";
                  symbolt symbol = symbol_creator::create_FloatTy(
                      GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  var_name_map.insert(
                      std::pair<std::string, std::string>(
                          symbol.name.c_str(), symbol.base_name.c_str()));  //akash fixed
                  symbol_table.add(symbol);
                  break;
                }
                  // 64-bit floating point type
                case llvm::Type::TypeID::DoubleTyID: {
                  symbolt symbol = symbol_creator::create_DoubleTy(
                      GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  var_name_map.insert(
                      std::pair<std::string, std::string>(
                          symbol.name.c_str(), symbol.base_name.c_str()));  //akash fixed
                  symbol_table.add(symbol);
                  errs() << "\nDouble type";
                  break;
                }
                  // 80-bit floating point type (X87)
                case llvm::Type::TypeID::X86_FP80TyID: {
                  symbolt symbol = symbol_creator::create_X86_FP80Ty(
                      GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  var_name_map.insert(
                      std::pair<std::string, std::string>(
                          symbol.name.c_str(), symbol.base_name.c_str()));  //akash fixed
                  symbol_table.add(symbol);
                  errs() << "\nX86_FP80 type";
                  break;
                }
                  // 128-bit floating point type (112-bit mantissa)
                case llvm::Type::TypeID::FP128TyID: {
                  symbolt symbol = symbol_creator::create_FP128Ty(
                      GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  var_name_map.insert(
                      std::pair<std::string, std::string>(
                          symbol.name.c_str(), symbol.base_name.c_str()));  //akash fixed
                  symbol_table.add(symbol);
                  errs() << "\nFP128 type";
                  break;
                }
                  // 128-bit floating point type (two 64-bits, PowerPC)
                case llvm::Type::TypeID::PPC_FP128TyID: {
                  symbolt symbol = symbol_creator::create_PPC_FP128Ty(
                      GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  var_name_map.insert(
                      std::pair<std::string, std::string>(
                          symbol.name.c_str(), symbol.base_name.c_str()));  //akash fixed
                  symbol_table.add(symbol);
                  errs() << "\nPPC_FP128 type";
                  break;
                }
                case llvm::Type::TypeID::IntegerTyID: {
                  symbolt symbol = symbol_creator::create_IntegerTy(
                      GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  if (auto temp = dyn_cast<ConstantInt>(GV.getOperand(0)))
                    symbol.value = from_integer(temp->getZExtValue(),
                                                symbol.type);
                  else
                    errs()
                        << "Akash: Global init_value type could not be determined!\n";
                  var_name_map.insert(
                      std::pair<std::string, std::string>(
                          symbol.name.c_str(), symbol.base_name.c_str()));  //akash fixed
                  symbol_table.add(symbol);
                  errs() << "\nInteger type";
                  break;
                }
                case llvm::Type::TypeID::StructTyID: {
                  const MDNode *dit = dyn_cast<MDNode>(*mmd);
                  symbolt symbol = symbol_creator::create_StructTy(
                      GV.getValueType(), dit);
                  symbol.name = symbol.base_name;
                  var_name_map.insert(
                      std::pair<std::string, std::string>(
                          symbol.name.c_str(), symbol.base_name.c_str()));  //akash fixed
                  symbol_table.add(symbol);
                  errs() << "\nStruct type";
                  break;
                }
                case llvm::Type::TypeID::ArrayTyID: {
                  symbolt symbol = symbol_creator::create_ArrayTy(
                      GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  auto temp_type = symbol.type;
                  while (temp_type.has_subtype() && temp_type.id() != ID_struct) {
                    temp_type = temp_type.subtype();
                  }
                  if (temp_type.id() != ID_struct) symbol.value =
                      get_initializer_list_exprt(
                          dyn_cast<Constant>(GV.getOperand(0)), symbol.type,
                          symbol_table);
                  var_name_map.insert(
                      std::pair<std::string, std::string>(
                          symbol.name.c_str(), symbol.base_name.c_str()));  //akash fixed
                  symbol_table.add(symbol);
                  errs() << "\nArray type";
                  break;
                }
                case llvm::Type::TypeID::PointerTyID: {
                  symbolt symbol = symbol_creator::create_PointerTy(
                      GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;

                  if (GV.getOperand(0)->hasName())
                    symbol.value = address_of_exprt(
                        symbol_table.lookup(GV.getOperand(0)->getName().str())
                            ->symbol_expr());
                  else
                    errs()
                        << "Akash: Global init_value type could not be determined!\n";
                  var_name_map.insert(
                      std::pair<std::string, std::string>(
                          symbol.name.c_str(), symbol.base_name.c_str()));  //akash fixed
                  symbol_table.add(symbol);
                  errs() << "\nPointer type";
                  break;
                }
                case llvm::Type::TypeID::VectorTyID: {
                  symbolt symbol = symbol_creator::create_VectorTy(
                      GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  var_name_map.insert(
                      std::pair<std::string, std::string>(
                          symbol.name.c_str(), symbol.base_name.c_str()));  //akash fixed
                  symbol_table.add(symbol);
                  errs() << "\nVector type";
                  break;
                }
                case llvm::Type::TypeID::X86_MMXTyID: {
                  symbolt symbol = symbol_creator::create_X86_MMXTy(
                      GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  var_name_map.insert(
                      std::pair<std::string, std::string>(
                          symbol.name.c_str(), symbol.base_name.c_str()));  //akash fixed
                  symbol_table.add(symbol);
                  break;
                }
                case llvm::Type::TypeID::VoidTyID:
                case llvm::Type::TypeID::FunctionTyID:
                case llvm::Type::TypeID::TokenTyID:
                case llvm::Type::TypeID::LabelTyID:
                case llvm::Type::TypeID::MetadataTyID:
                  errs() << "\ninvalid type for global variable";
                  ;
              }
            }
          }
        }
      }
    }
  }
  return symbol_table;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_instruction

 Inputs:
 I - Pointer to the llvm instruction.

 Outputs: Object of goto_programt containing goto instruction corresponding to
 given llvm instruction.

 Purpose: Map llvm::Instruction to corresponding goto instruction.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_instruction(
    const Instruction &I,
    symbol_tablet *symbol_table,
    std::map<const Instruction*, goto_programt::targett> &instruction_target_map,
    std::map<goto_programt::targett, const BasicBlock*> &branch_dest_block_map_switch,
    std::map<const BasicBlock*, goto_programt::targett> &block_target_map) {
  errs() << "\n\t\t\tin trans_instruction\n\t\t\t\t";
  I.dump();
  const Instruction *Inst = &I;
  goto_programt gp;
  switch (I.getOpcode()) {
    // Terminators
    case Instruction::Ret: {
      goto_programt ret_gp = trans_Ret(Inst, *symbol_table);
      gp.destructive_append(ret_gp);
      break;
    }
    case Instruction::Br: {
      goto_programt br_gp = trans_Br(Inst, symbol_table,
                                     instruction_target_map);
      gp.destructive_append(br_gp);
      break;
    }
    case Instruction::Switch: {
      goto_programt sw_gp = trans_Switch(Inst, branch_dest_block_map_switch,
                                         *symbol_table);
      gp.destructive_append(sw_gp);
      break;
    }
    case Instruction::IndirectBr: {
      gp = trans_IndirectBr(Inst);
      break;
    }
    case Instruction::Invoke: {
      gp = trans_Invoke(Inst);
      break;
    }
    case Instruction::Resume: {
      gp = trans_Resume(Inst);
      break;
    }
    case Instruction::Unreachable: {
// gp = trans_Unreachable(Inst);
      goto_programt unreachable_gp = trans_Unreachable(Inst);
      gp.destructive_append(unreachable_gp);
      break;
    }
    case Instruction::CleanupRet: {
      gp = trans_CleanupRet(Inst);
      break;
    }
    case Instruction::CatchRet: {
      gp = trans_CatchRet(Inst);
      break;
    }
    case Instruction::CatchPad: {
      gp = trans_CatchPad(Inst);
      break;
    }
    case Instruction::CatchSwitch: {
      gp = trans_CatchSwitch(Inst);
      break;
    }

// Standard binary operators...
    case Instruction::Add: {
      goto_programt add_ins = trans_Add(Inst, *symbol_table);
      gp.destructive_append(add_ins);
      break;
    }
    case Instruction::FAdd: {
      goto_programt fadd_inst = trans_FAdd(Inst, *symbol_table);
      gp.destructive_append(fadd_inst);
      break;
    }
    case Instruction::Sub: {
      goto_programt sub_ins = trans_Sub(Inst, *symbol_table);
      gp.destructive_append(sub_ins);
      break;
    }
    case Instruction::FSub: {
      goto_programt fsub_inst = trans_FSub(Inst, *symbol_table);
      gp.destructive_append(fsub_inst);
      break;
    }
    case Instruction::Mul: {
      goto_programt mul_ins = trans_Mul(Inst, *symbol_table);
      gp.destructive_append(mul_ins);
      break;
    }
    case Instruction::FMul: {
      goto_programt fmul_inst = trans_FMul(Inst, *symbol_table);
      gp.destructive_append(fmul_inst);
      break;
    }
    case Instruction::UDiv: {
      goto_programt udiv_ins = trans_UDiv(Inst, *symbol_table);
      gp.destructive_append(udiv_ins);
      break;
    }
    case Instruction::SDiv: {
      goto_programt sdiv_ins = trans_SDiv(Inst, *symbol_table);
      gp.destructive_append(sdiv_ins);
      break;
    }
    case Instruction::FDiv: {
      goto_programt fdiv_inst = trans_FDiv(Inst, *symbol_table);
      gp.destructive_append(fdiv_inst);
      break;
    }
    case Instruction::URem: {
      goto_programt urem_ins = trans_URem(Inst, *symbol_table);
      gp.destructive_append(urem_ins);
      break;
    }
    case Instruction::SRem: {
      goto_programt srem_ins = trans_URem(Inst, *symbol_table);
      gp.destructive_append(srem_ins);
      break;
    }
    case Instruction::FRem: {
      goto_programt frem_inst = trans_FRem(Inst, *symbol_table);
      gp.destructive_append(frem_inst);
      break;
    }

// Logical operators...
    case Instruction::And: {
      goto_programt and_inst = trans_And(Inst, *symbol_table);
      gp.destructive_append(and_inst);
      break;
    }
    case Instruction::Or: {
      goto_programt or_inst = trans_Or(Inst, *symbol_table);
      gp.destructive_append(or_inst);
      break;
    }
    case Instruction::Xor: {
      goto_programt xor_inst = trans_Xor(Inst, *symbol_table);
      gp.destructive_append(xor_inst);
      break;
    }

// Memory instructions...
    case Instruction::Alloca: {
      trans_Alloca(Inst, *symbol_table);
      break;
    }
    case Instruction::Load: {
      goto_programt store_gp = trans_Load(Inst);
//      gp.destructive_append(store_gp);
      break;
    }
    case Instruction::Store: {
      goto_programt load_gp = trans_Store(Inst, *symbol_table);
      gp.destructive_append(load_gp);
      break;
    }
    case Instruction::AtomicCmpXchg: {
      gp = trans_AtomicCmpXchg(Inst);
      break;
    }
    case Instruction::AtomicRMW: {
      gp = trans_AtomicRMW(Inst);
      break;
    }
    case Instruction::Fence: {
      gp = trans_Fence(Inst);
      break;
    }
    case Instruction::GetElementPtr: {
// goto_programt load_gp = trans_Store(Inst, *symbol_table);
// break;
      goto_programt getElementPtr_gp = trans_GetElementPtr(Inst, *symbol_table);
      gp.destructive_append(getElementPtr_gp);
      break;
    }

// Convert instructions...
    case Instruction::Trunc: {
      goto_programt trunc_gp = trans_Trunc(Inst, *symbol_table);
      gp.destructive_append(trunc_gp);
      break;
    }
    case Instruction::ZExt: {
      goto_programt zext_gp = trans_ZExt(Inst, *symbol_table);
      gp.destructive_append(zext_gp);
      break;
    }
    case Instruction::SExt: {
      goto_programt sext_gp = trans_SExt(Inst, *symbol_table);
      gp.destructive_append(sext_gp);
      break;
    }
    case Instruction::FPTrunc: {
      goto_programt fptrunc_gp = trans_FPTrunc(Inst, *symbol_table);
      gp.destructive_append(fptrunc_gp);
      break;
    }
    case Instruction::FPExt: {
      goto_programt fpext_gp = trans_FPExt(Inst, *symbol_table);
      gp.destructive_append(fpext_gp);
      break;
    }
    case Instruction::FPToUI: {
      goto_programt fptoui_gp = trans_FPToUI(Inst, *symbol_table);
      gp.destructive_append(fptoui_gp);
      break;
    }
    case Instruction::FPToSI: {
      goto_programt fptosi_gp = trans_FPToSI(Inst, *symbol_table);
      gp.destructive_append(fptosi_gp);
      break;
    }
    case Instruction::UIToFP: {
      goto_programt uitofp_gp = trans_UIToFP(Inst, *symbol_table);
      gp.destructive_append(uitofp_gp);
      break;
    }
    case Instruction::SIToFP: {
      goto_programt sitofp_gp = trans_SIToFP(Inst, *symbol_table);
      gp.destructive_append(sitofp_gp);
      break;
    }
    case Instruction::IntToPtr: {
      gp = trans_IntToPtr(Inst);
      break;
    }
    case Instruction::PtrToInt: {
      gp = trans_PtrToInt(Inst, *symbol_table);
      break;
    }
    case Instruction::BitCast: {
      gp = trans_BitCast(Inst);
      break;
    }
    case Instruction::AddrSpaceCast: {
      gp = trans_AddrSpaceCast(Inst);
      break;
    }

// Other instructions...
    case Instruction::ICmp: {
      goto_programt Icmp_inst = trans_ICmp(Inst, symbol_table);
      gp.destructive_append(Icmp_inst);
      break;
    }
    case Instruction::FCmp: {
      goto_programt Fcmp_inst = trans_FCmp(Inst, symbol_table);
      gp.destructive_append(Fcmp_inst);
      break;
    }
    case Instruction::PHI: {
//      gp = trans_PHI(Inst, symbol_table, block_target_map, gp);
      break;
    }
    case Instruction::Select: {
      gp = trans_Select(Inst);
      break;
    }
    case Instruction::Call: {
      goto_programt Call_Inst = trans_Call(Inst, symbol_table);
      gp.destructive_append(Call_Inst);
      break;
    }
    case Instruction::Shl: {
      goto_programt shl_Inst = trans_Shl(Inst, *symbol_table);
      gp.destructive_append(shl_Inst);
      break;
    }
    case Instruction::LShr: {
      goto_programt lshr_Inst = trans_LShr(Inst, *symbol_table);
      gp.destructive_append(lshr_Inst);
      break;
    }
    case Instruction::AShr: {
      goto_programt ashr_Inst = trans_AShr(Inst, *symbol_table);
      gp.destructive_append(ashr_Inst);
      break;
    }
    case Instruction::VAArg: {
      gp = trans_VAArg(Inst);
      break;
    }
    case Instruction::ExtractElement: {
      gp = trans_ExtractElement(Inst);
      break;
    }
    case Instruction::InsertElement: {
      gp = trans_InsertElement(Inst);
      break;
    }
    case Instruction::ShuffleVector: {
      gp = trans_ShuffleVector(Inst);
      break;
    }
    case Instruction::ExtractValue: {
      gp = trans_ExtractValue(Inst);
      break;
    }
    case Instruction::InsertValue: {
      gp = trans_InsertValue(Inst);
      break;
    }
    case Instruction::LandingPad: {
      gp = trans_LandingPad(Inst);
      break;
    }
    case Instruction::CleanupPad: {
      gp = trans_CleanupPad(Inst);
      break;
    }

    default:
      errs() << "Invalid instruction type...\n ";
  }
//  gp.update();
//  gp.output(std::cout);
  errs() << "\t\t\tin trans_instruction";
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Block

 Inputs:
 I - Pointer to the llvm basic block.

 Outputs: Object of goto_programt containing goto instruction corresponding
 to llvm instruction in given llvm basic block.

 Purpose: Map llvm::Instruction to corresponding goto instruction in given
 llvm basic block.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Block(
    const BasicBlock &b,
    symbol_tablet *symbol_table,
    std::map<const Instruction*, goto_programt::targett> &instruction_target_map,
    std::map<goto_programt::targett, const BasicBlock*> &branch_dest_block_map_switch,
    std::map<const BasicBlock*, goto_programt::targett> block_target_map) {
  errs() << "\t\tin trans_Block\n";
  goto_programt gp;
  for (BasicBlock::const_iterator i = b.begin(), ie = b.end(); i != ie; ++i) {
    goto_programt goto_instr = trans_instruction(*i, symbol_table,
                                                 instruction_target_map,
                                                 branch_dest_block_map_switch,
                                                 block_target_map);
    gp.destructive_append(goto_instr);
    gp.update();
    errs() << "";
  }
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Function

 Inputs:
 I - Pointer to the llvm function.

 Outputs: Object of goto_programt containing goto instruction corresponding
 to llvm instruction in given llvm function.

 Purpose: Map llvm::Instruction to corresponding goto instruction in given
 llvm function.

 \*******************************************************************/
goto_programt llvm2goto_translator::trans_Function(
    const Function &F, symbol_tablet *symbol_table) {
// TODO(Rasika): check if definition
//  is available or not, in built functions...

  goto_programt gp;

  if (!F.getName().str().compare("nondet_int")
      || !F.getName().str().compare("nondet_uint")) {
    return gp;
  }
  scope_tree st;
  scope_name_map.clear();
  st.get_scope_name_map(F, &scope_name_map);
  std::map<const BasicBlock*, goto_programt::targett> block_target_map;
  std::map<goto_programt::targett, const BasicBlock*> branch_dest_block_map_switch;
  std::map<const Instruction*, goto_programt::targett> instruction_target_map;
  errs() << "\tin trans_Function\n";
  symbolt symbol = namespacet(*symbol_table).lookup(
      dstringt(F.getName().str()));
  Function::const_iterator b = F.begin(), be = F.end();
  for (; b != be; ++b) {
    const BasicBlock &B = *b;
    goto_programt goto_block = trans_Block(B, symbol_table,
                                           instruction_target_map,
                                           branch_dest_block_map_switch,
                                           block_target_map);
    register_language(new_ansi_c_language);
    goto_programt::targett target = goto_block.instructions.begin();
    gp.destructive_append(goto_block);
    gp.update();
    block_target_map.insert(
        std::pair<const BasicBlock*, goto_programt::targett>(&(*b), target));
  }
  gp.add_instruction(END_FUNCTION);
  errs() << "\n\n *********************************************\n";
  set_branches(symbol_table, block_target_map, instruction_target_map);
  errs() << "\n\n *********************************************\n";
  gp.update();
  for (auto i = branch_dest_block_map_switch.begin();
      i != branch_dest_block_map_switch.end(); i++) {
    std::map<const BasicBlock*, goto_programt::targett>::iterator then_pair =
        block_target_map.find(dyn_cast<BasicBlock>(i->second));
    auto guard = i->first->guard;
    errs() << from_expr(guard) << "\n";
    i->first->make_goto(then_pair->second, guard);
  }
// assert(false);
  gp.update();
  errs() << "\tout of trans_Function " + F.getName().str() + "\n";
  return gp;
}

/*******************************************************************
 Function: llvm2goto_translator::set_branches

 Inputs:
 I - Pointer to the llvm module.

 Outputs: Object of goto_functionst containing goto function corresponding
 to given llvm function.

 Purpose: Translate llvm module into goto functions. Call required functions
 e.g. trans_Gloabals, trans_Block, etc.

 \*******************************************************************/

void llvm2goto_translator::set_branches(
    symbol_tablet *symbol_table,
    std::map<const BasicBlock*, goto_programt::targett> block_target_map,
    std::map<const Instruction*, goto_programt::targett> instruction_target_map) {
  for (auto i = instruction_target_map.begin(), ie =
      instruction_target_map.end(); i != ie; i++) {
    if (dyn_cast<BranchInst>((*i).first)->getNumSuccessors() == 2) {
      goto_programt::targett then_part;
      exprt guard;
      if (dyn_cast<BranchInst>((*i).first)->isConditional()) {
        auto temp = dyn_cast<Instruction>(
            dyn_cast<BranchInst>((*i).first)->getCondition());
        if (dyn_cast<CmpInst>(temp))
          guard = not_exprt(trans_Cmp(temp, symbol_table));
        else if (auto phi = dyn_cast<PHINode>(temp)) guard = not_exprt(
            get_PHI(phi, *symbol_table));
      }
      else {
        guard = true_exprt();
      }
      std::map<const BasicBlock*, goto_programt::targett>::iterator then_pair =
          block_target_map.find(
              dyn_cast<BasicBlock>(
                  dyn_cast<BranchInst>((*i).first)->getSuccessor(1)));
      then_part = (*then_pair).second;
      (*i).second->make_goto(then_part, guard);
    }
    else {
      goto_programt::targett then_part;
      exprt guard;
      if (dyn_cast<BranchInst>((*i).first)->isConditional()) {
        guard = trans_Cmp(
            dyn_cast<Instruction>(
                dyn_cast<BranchInst>((*i).first)->getCondition()),
            symbol_table);
      }
      else {
        guard = true_exprt();
      }
      std::map<const BasicBlock*, goto_programt::targett>::iterator then_pair =
          block_target_map.find(
              dyn_cast<BasicBlock>(
                  dyn_cast<BranchInst>((*i).first)->getSuccessor(0)));
      then_part = (*then_pair).second;
      (*i).second->make_goto(then_part, guard);
    }
  }
}

/*******************************************************************
 Function: llvm2goto_translator::trans_Program

 Inputs:
 I - Pointer to the llvm module.

 Outputs: Object of goto_functionst containing goto function corresponding
 to given llvm function.

 Purpose: Translate llvm module into goto functions. Call required functions
 e.g. trans_Gloabals, trans_Block, etc.

 \*******************************************************************/
goto_functionst llvm2goto_translator::trans_Program(std::string filename) {
  auto pass_manager = LLVMCreatePassManager();
  register_language(new_ansi_c_language);
  cmdlinet cmdline;
  config.set(cmdline);
  config.ansi_c.set_64();
  config.ansi_c.rounding_mode = ieee_floatt::ROUND_TO_EVEN;
  config.ansi_c.set_c11();
  config.ansi_c.single_precision_constant = true;
//  config.ansi_c.long_double_width = 64;
//  config.ansi_c.
// TODO(Rasika): check for presence of function body
  errs() << "in trans_Program\n";
  goto_functionst goto_functions;
  symbol_tablet symbol_table = trans_Globals(M);
  {
    symbolt initialize_function;
    initialize_function.clear();
    initialize_function.is_static_lifetime = true;
    initialize_function.is_thread_local = false;
    const irep_idt initialize_function_bname = INITIALIZE_FUNCTION;
    const irep_idt initialize_function_name = INITIALIZE_FUNCTION;
    initialize_function.mode = ID_C;
    initialize_function.name = initialize_function_name;
    initialize_function.base_name = initialize_function_bname;
    code_typet ct = code_typet();
    ct.return_type() = unsignedbv_typet(config.ansi_c.int_width);
    initialize_function.value = exprt();
    initialize_function.type = ct;
    symbol_table.add(initialize_function);

    symbolt cprover_rounding_mode;
    cprover_rounding_mode.name = "__CPROVER_rounding_mode";
    cprover_rounding_mode.base_name = "__CPROVER_rounding_mode";
    cprover_rounding_mode.type = signed_int_type();
    cprover_rounding_mode.mode = ID_C;
    cprover_rounding_mode.value = from_integer(0, cprover_rounding_mode.type);
    cprover_rounding_mode.is_thread_local = true;
    cprover_rounding_mode.is_static_lifetime = true;
    cprover_rounding_mode.is_lvalue = true;
    var_name_map.insert(
        std::pair<std::string, std::string>(
            cprover_rounding_mode.name.c_str(),
            cprover_rounding_mode.base_name.c_str()));    //akash fixed
    symbol_table.add(cprover_rounding_mode);

    symbolt cprover_deallocated;
    cprover_deallocated.name = "__CPROVER_deallocated";
    cprover_deallocated.base_name = "__CPROVER_deallocated";
    cprover_deallocated.type = pointer_typet(void_typet(),
                                             config.ansi_c.pointer_width);
    cprover_deallocated.value = null_pointer_exprt(
        to_pointer_type(cprover_deallocated.type));
    cprover_deallocated.mode = ID_C;
    cprover_deallocated.is_lvalue = true;
    cprover_deallocated.is_static_lifetime = true;
    var_name_map.insert(
        std::pair<std::string, std::string>(
            cprover_deallocated.name.c_str(),
            cprover_deallocated.base_name.c_str()));    //akash fixed
    symbol_table.add(cprover_deallocated);

    symbolt cprover_dead_object;
    cprover_dead_object.name = "__CPROVER_dead_object";
    cprover_dead_object.base_name = "__CPROVER_dead_object";
    cprover_dead_object.type = pointer_typet(void_typet(),
                                             config.ansi_c.pointer_width);
    cprover_dead_object.value = null_pointer_exprt(
        to_pointer_type(cprover_dead_object.type));
    cprover_dead_object.mode = ID_C;
    cprover_dead_object.is_lvalue = true;
    cprover_dead_object.is_static_lifetime = true;
    var_name_map.insert(
        std::pair<std::string, std::string>(
            cprover_dead_object.name.c_str(),
            cprover_dead_object.base_name.c_str()));    //akash fixed
    symbol_table.add(cprover_dead_object);

    symbolt cprover_malloc_object;
    cprover_malloc_object.name = "__CPROVER_malloc_object";
    cprover_malloc_object.base_name = "__CPROVER_malloc_object";
    cprover_malloc_object.type = pointer_typet(void_typet(),
                                               config.ansi_c.pointer_width);
    cprover_malloc_object.value = null_pointer_exprt(
        to_pointer_type(cprover_malloc_object.type));
    cprover_malloc_object.mode = ID_C;
    cprover_malloc_object.is_lvalue = true;
    cprover_malloc_object.is_static_lifetime = true;
    var_name_map.insert(
        std::pair<std::string, std::string>(
            cprover_malloc_object.name.c_str(),
            cprover_malloc_object.base_name.c_str()));    //akash fixed
    symbol_table.add(cprover_malloc_object);

    symbolt cprover_malloc_size;
    cprover_malloc_size.name = "__CPROVER_malloc_size";
    cprover_malloc_size.base_name = "__CPROVER_malloc_size";
    cprover_malloc_size.type = unsignedbv_typet(config.ansi_c.int_width);
    cprover_malloc_size.value = from_integer(0, cprover_malloc_size.type);
    cprover_malloc_size.mode = ID_C;
    cprover_malloc_size.is_lvalue = true;
    cprover_malloc_size.is_static_lifetime = true;
    var_name_map.insert(
        std::pair<std::string, std::string>(
            cprover_malloc_size.name.c_str(),
            cprover_malloc_size.base_name.c_str()));    //akash fixed
    symbol_table.add(cprover_malloc_size);
  }

  goto_programt gp;
  for (Function &F : *M) {
    if (!F.getName().str().compare("nondet_int")
        || !F.getName().str().compare("nondet_uint")) {
      continue;
    }
    if (F.getSubprogram() != NULL) {
// errs() << "hello\n";
// dyn_cast<DISubroutineType>(F.getSubprogram()->getType())->getTypeArray()->dump();
// errs() << "hello\n";
      DISubroutineType *md = (dyn_cast<DISubprogram>(F.getSubprogram()))
          ->getType();
// md->dump();
// DIType *mdn = dyn_cast<DIType>(&*md->getTypeArray()[0]);
      unsigned int i = 1;
      for (Function::arg_iterator arg_b = F.arg_begin(), arg_e = F.arg_end();
          arg_b != arg_e; arg_b++) {
        symbolt arg;
        // TODO(Rasika) : get type from metadata.
        arg.type = symbol_creator::create_type(
            arg_b->getType(), dyn_cast<DIType>(&*md->getTypeArray()[i]));
        i++;
        if (!arg_b->getName().str().compare("argc"))
          arg.name = "argc'";
        else
          arg.name = F.getName().str() + "::" + arg_b->getName().str();
        if (!arg_b->getName().str().compare("argv"))
          arg.name = "argv'";
        else
          arg.name = F.getName().str() + "::" + arg_b->getName().str();
        arg.base_name = arg_b->getName().str();
        arg.is_lvalue = true;
        arg.is_parameter = true;
        arg.is_state_var = true;
        arg.is_thread_local = true;
        arg.is_file_local = true;
        symbol_table.add(arg);
        var_name_map.insert(
            std::pair<std::string, std::string>(arg.name.c_str(),
                                                arg.base_name.c_str()));  //akash fixed
      }
    }
    Type *functt = (dyn_cast<Type>(F.getFunctionType()));
    symbolt fn = symbol_creator::create_FunctionTy(functt, F);
    fn.name = dstringt(F.getName().str());
    fn.base_name = fn.name;
    fn.is_lvalue = true;
    symbol_table.add(fn);
    goto_functions.function_map.insert(
        std::pair<const dstringt, goto_functionst::goto_functiont>(
            dstringt(F.getName()), goto_functionst::goto_functiont()));
  }
// symbol_table.show(std::cout);
//  for (Function &F : *M) {
//    unsigned i = 0;
//    for (BasicBlock &B : F) {
//      for (Instruction &I : B) {
//        if (I.getOpcode() == Instruction::PHI) {
////          if (!I.hasName()) {
////            I.setName("_phi_" + std::to_string(i));
////            i++;
////          }
//        }
//      }
//    }
//    // F.dump();
//  }
// assert(false);
  for (Function &F : *M) {
    if (!F.getName().str().compare("nondet_int")
        || !F.getName().str().compare("nondet_uint")) {
      continue;
    }
    const symbolt *fn = symbol_table.lookup(F.getName().str());
    goto_programt func_gp = trans_Function(F, &symbol_table);
    gp.destructive_append(func_gp);
    (*goto_functions.function_map.find(dstringt(F.getName()))).second.body.swap(
        gp);
    (*goto_functions.function_map.find(dstringt(F.getName()))).second.type =
        to_code_type(fn->type);
  }
  set_entry_point(goto_functions, symbol_table);
//  cmdlinet cmdline;

//  configt config;

//  ui_message_handlert umht;

//  compilet compile(cmdline, umht, false);
  config.set_from_symbol_table(symbol_table);
  if (filename == "") {
//    compile.write_object_file(M->getSourceFileName()
//      + ".goto", symbol_table, goto_functions);
    std::ofstream out(M->getSourceFileName() + ".gb", std::ios::binary);
    write_goto_binary(out, symbol_table, goto_functions);
  }
  else {
//    compile.write_object_file(filename, symbol_table, goto_functions);
    std::ofstream out(filename, std::ios::binary);
    write_goto_binary(out, symbol_table, goto_functions);
  }

  namespacet ns(symbol_table);
//  ns.get_symbol_table().show(std::cout);
  errs() << "\n";
//  goto_functions.output(ns, std::cout);
  errs() << "\n";
  errs() << "in trans_Program\n";
  return goto_functions;
}

//Analysis pass should calculate return types for non-defined functions
//that dont have debug information.
