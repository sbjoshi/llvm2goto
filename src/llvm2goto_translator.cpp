/* Copyright


*/

#include "llvm2goto_translator.h"

#include <llvm/IR/Type.h>
#include "llvm/ADT/APFloat.h"

#include <utility>
#include <memory>
#include <string>
#include <map>

#include "symbol_creator.h"

#include "llvm/IR/IntrinsicInst.h"
#include "langapi/mode.h"

#include "ansi-c/ansi_c_language.h"
#include "util/ieee_float.h"
using namespace llvm;

// TODO(Rasika): handle signed comparison.

llvm2goto_translator::llvm2goto_translator(Module *M) {
    this->M = M;
}

llvm2goto_translator::~llvm2goto_translator() {
}

/*******************************************************************\

   Function: llvm2goto_translator::trans_Ret

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::Ret.

    Purpose: Map llvm::Instruction::Ret to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_Ret(const Instruction *I,
  const symbol_tablet &symbol_table) {
  goto_programt gp;
  goto_programt::targett ret_inst = gp.add_instruction();
  code_returnt cret;
  dyn_cast<ReturnInst>(I)->getReturnValue()->dump();
  // symbolt ret_symb = symbol_table.lookup(I->getFunction()->getName()->c_str()
  //   + "::" + );
  // temp.name = irep_idt("temp");
  // temp.type = unsignedbv_typet(32);
  // cret.return_value() = temp.symbol_expr();
  ret_inst->make_return();
  ret_inst->code = cret;
  // to_code_return(ret_inst->code).return_value() = exprt();
  // assert(false && "Ret is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_Br

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::Br.

    Purpose: Map llvm::Instruction::Br to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_Br(const Instruction *I,
  symbol_tablet *symbol_table,
  std::map <const Instruction*, goto_programt::targett>
  &instruction_target_map) {
  goto_programt gp;
  // errs() << "Br is yet to be mapped \n";
  I->dump();
  if (dyn_cast<BranchInst>(I)->getNumSuccessors() == 2) {
    goto_programt::targett br_ins = gp.add_instruction();
    instruction_target_map.insert(std::pair<const Instruction*,
      goto_programt::targett>(I, br_ins));
    gp.update();
  } else {
    goto_programt::targett br_ins = gp.add_instruction();
    instruction_target_map.insert(std::pair<const Instruction*,
      goto_programt::targett>(I, br_ins));
    gp.update();
  }
  gp.update();
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_Switch

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::Switch.

    Purpose: Map llvm::Instruction::Switch to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_Switch(const Instruction *I) {
  goto_programt gp;
  assert(false && "Switch is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

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

 /*******************************************************************\

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

 /*******************************************************************\

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

 /*******************************************************************\

   Function: llvm2goto_translator::trans_Unreachable

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::Unreachable.

    Purpose: Map llvm::Instruction::Unreachable to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_Unreachable(const Instruction *I) {
  goto_programt gp;
  assert(false && "Unreachable is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

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

 /*******************************************************************\

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

 /*******************************************************************\

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

 /*******************************************************************\

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

 /*******************************************************************\

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
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  // Symbol corresponding to the value in which result of llvm instruction
  // is stored, might have been created in goto symbol table earlier. If so,
  // it is used otherwise new symbol is created. And added to the symbol table.
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());

  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
  // Add instruction in llvm becomes an assignment statement in goto,
  // with a symbol on LHS and plus_exprt on RHS.
  add_inst->code = code_assignt(result.symbol_expr(),
    plus_exprt(exprt1, exprt2));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  add_inst->source_location = location;
  add_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

 /*******************************************************************\

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
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (dyn_cast<ConstantFP>(*ub)) {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((*ub)->getType());
      if (floattype->isFloatTy()) {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      } else if (floattype->isDoubleTy()) {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      } else {
        assert(false && "This floating point type in above instruction is not handled");
      }
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (dyn_cast<ConstantFP>(*(ub+1))) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub+1))->getType());
    if (floattype->isFloatTy()) {
      float val = dyn_cast<ConstantFP>(*(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_float(val);
      exprt2 = ieee_fl.to_expr();
    } else if (floattype->isDoubleTy()) {
      float val = dyn_cast<ConstantFP>(*(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_double(val);
      exprt2 = ieee_fl.to_expr();
    } else {
      assert(false && "This floating point type in above instruction is not handled");
    }
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  // Symbol corresponding to the value in which result of llvm instruction
  // is stored, might have been created in goto symbol table earlier. If so,
  // it is used otherwise new symbol is created. And added to the symbol table.
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
  // Add instruction in llvm becomes an assignment statement in goto,
  // with a symbol on LHS and plus_exprt on RHS.
  add_inst->code = code_assignt(result.symbol_expr(),
    plus_exprt(exprt1, exprt2));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  add_inst->source_location = location;
  add_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_Sub

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::Sub.

    Purpose: Map llvm::Instruction::Sub to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_Sub(const Instruction *I,
  symbol_tablet &symbol_table) {
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());

  goto_programt::targett fadd_inst = gp.add_instruction();
  fadd_inst->make_assignment();
  fadd_inst->code = code_assignt(result.symbol_expr(),
    minus_exprt(exprt1, exprt2));
  fadd_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  fadd_inst->source_location = location;
  fadd_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

 /*******************************************************************\

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
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (dyn_cast<ConstantFP>(*ub)) {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((*ub)->getType());
      if (floattype->isFloatTy()) {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      } else if (floattype->isDoubleTy()) {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      } else {
        assert(false && "This floating point type in above instruction is not handled");
      }
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (dyn_cast<ConstantFP>(*(ub+1))) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub+1))->getType());
    if (floattype->isFloatTy()) {
      float val = dyn_cast<ConstantFP>(*(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_float(val);
      exprt2 = ieee_fl.to_expr();
    } else if (floattype->isDoubleTy()) {
      float val = dyn_cast<ConstantFP>(*(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_double(val);
      exprt2 = ieee_fl.to_expr();
    } else {
      assert(false && "This floating point type in above instruction is not handled");
    }
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  goto_programt::targett fsub_inst = gp.add_instruction();
  fsub_inst->make_assignment();
  fsub_inst->code = code_assignt(result.symbol_expr(),
    minus_exprt(exprt1, exprt2));
  fsub_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  fsub_inst->source_location = location;
  fsub_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_Mul

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::Mul.

    Purpose: Map llvm::Instruction::Mul to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_Mul(const Instruction *I,
  symbol_tablet &symbol_table) {
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());

  goto_programt::targett mul_inst = gp.add_instruction();
  mul_inst->make_assignment();
  mul_inst->code = code_assignt(result.symbol_expr(),
    mult_exprt(exprt1, exprt2));
  mul_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  mul_inst->source_location = location;
  mul_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

 /*******************************************************************\

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
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (dyn_cast<ConstantFP>(*ub)) {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((*ub)->getType());
      if (floattype->isFloatTy()) {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      } else if (floattype->isDoubleTy()) {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      } else {
        assert(false && "This floating point type in above instruction is not handled");
      }
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (dyn_cast<ConstantFP>(*(ub+1))) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub+1))->getType());
    if (floattype->isFloatTy()) {
      float val = dyn_cast<ConstantFP>(*(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_float(val);
      exprt2 = ieee_fl.to_expr();
    } else if (floattype->isDoubleTy()) {
      float val = dyn_cast<ConstantFP>(*(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_double(val);
      exprt2 = ieee_fl.to_expr();
    } else {
      assert(false && "This floating point type in above instruction is not handled");
    }
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  goto_programt::targett fmul_inst = gp.add_instruction();
  fmul_inst->make_assignment();
  fmul_inst->code = code_assignt(result.symbol_expr(),
    mult_exprt(exprt1, exprt2));
  fmul_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  fmul_inst->source_location = location;
  fmul_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

 /*******************************************************************\

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
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());

  goto_programt::targett udiv_inst = gp.add_instruction();
  udiv_inst->make_assignment();
  udiv_inst->code = code_assignt(result.symbol_expr(),
    div_exprt(exprt1, exprt2));
  udiv_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  udiv_inst->source_location = location;
  udiv_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

 /*******************************************************************\

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
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());

  goto_programt::targett sdiv_inst = gp.add_instruction();
  sdiv_inst->make_assignment();
  sdiv_inst->code = code_assignt(result.symbol_expr(),
    div_exprt(exprt1, exprt2));
  sdiv_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  sdiv_inst->source_location = location;
  sdiv_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

 /*******************************************************************\

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
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (dyn_cast<ConstantFP>(*ub)) {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((*ub)->getType());
      if (floattype->isFloatTy()) {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      } else if (floattype->isDoubleTy()) {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      } else {
        assert(false && "This floating point type in above instruction is not handled");
      }
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (dyn_cast<ConstantFP>(*(ub+1))) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub+1))->getType());
    if (floattype->isFloatTy()) {
      float val = dyn_cast<ConstantFP>(*(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_float(val);
      exprt2 = ieee_fl.to_expr();
    } else if (floattype->isDoubleTy()) {
      float val = dyn_cast<ConstantFP>(*(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_double(val);
      exprt2 = ieee_fl.to_expr();
    } else {
      assert(false && "This floating point type in above instruction is not handled");
    }
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  goto_programt::targett fdiv_inst = gp.add_instruction();
  fdiv_inst->make_assignment();
  fdiv_inst->code = code_assignt(result.symbol_expr(),
    div_exprt(exprt1, exprt2));
  fdiv_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  fdiv_inst->source_location = location;
  fdiv_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

 /*******************************************************************\

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
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());

  goto_programt::targett urem_inst = gp.add_instruction();
  urem_inst->make_assignment();
  urem_inst->code = code_assignt(result.symbol_expr(),
    mod_exprt(exprt1, exprt2));
  urem_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  urem_inst->source_location = location;
  urem_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

 /*******************************************************************\

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
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());

  goto_programt::targett srem_inst = gp.add_instruction();
  srem_inst->make_assignment();
  srem_inst->code = code_assignt(result.symbol_expr(),
    mod_exprt(exprt1, exprt2));
  srem_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  srem_inst->source_location = location;
  srem_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

 /*******************************************************************\

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
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (dyn_cast<ConstantFP>(*ub)) {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((*ub)->getType());
      if (floattype->isFloatTy()) {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      } else if (floattype->isDoubleTy()) {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      } else {
        assert(false && "This floating point type in above instruction is not handled");
      }
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (dyn_cast<ConstantFP>(*(ub+1))) {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub+1))->getType());
    if (floattype->isFloatTy()) {
      float val = dyn_cast<ConstantFP>(*(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_float(val);
      exprt2 = ieee_fl.to_expr();
    } else if (floattype->isDoubleTy()) {
      float val = dyn_cast<ConstantFP>(*(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_double(val);
      exprt2 = ieee_fl.to_expr();
    } else {
      assert(false && "This floating point type in above instruction is not handled");
    }
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  goto_programt::targett frem_inst = gp.add_instruction();
  frem_inst->make_assignment();
  frem_inst->code = code_assignt(result.symbol_expr(),
    mod_exprt(exprt1, exprt2));
  frem_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  frem_inst->source_location = location;
  frem_inst->type = goto_program_instruction_typet::ASSIGN;
  return gp;
}

 /*******************************************************************\

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
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  // Symbol corresponding to the value in which result of llvm instruction
  // is stored, might have been created in goto symbol table earlier. If so,
  // it is used otherwise new symbol is created. And added to the symbol table.
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());

  goto_programt::targett and_inst = gp.add_instruction();
  and_inst->make_assignment();
  // Add instruction in llvm becomes an assignment statement in goto,
  // with a symbol on LHS and bitand_exprt on RHS.
  and_inst->code = code_assignt(result.symbol_expr(),
    bitand_exprt(exprt1, exprt2));
  and_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  and_inst->source_location = location;
  and_inst->type = goto_program_instruction_typet::ASSIGN;
  // assert(false && "And is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

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
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  // Symbol corresponding to the value in which result of llvm instruction
  // is stored, might have been created in goto symbol table earlier. If so,
  // it is used otherwise new symbol is created. And added to the symbol table.
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());

  goto_programt::targett or_inst = gp.add_instruction();
  or_inst->make_assignment();
  // Add instruction in llvm becomes an assignment statement in goto,
  // with a symbol on LHS and bitor_exprt on RHS.
  or_inst->code = code_assignt(result.symbol_expr(),
    bitor_exprt(exprt1, exprt2));
  or_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  or_inst->source_location = location;
  or_inst->type = goto_program_instruction_typet::ASSIGN;
  // assert(false && "And is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

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
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*ub)) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op1 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + ub->getName().str());
    }
    exprt1 = op1.symbol_expr();
  }
  if (const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1))) {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  } else {
    if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + li->getOperand(0)->getName().str());
    } else {
      op2 = symbol_table.lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str());
    }
    exprt2 = op2.symbol_expr();
  }
  // Symbol corresponding to the value in which result of llvm instruction
  // is stored, might have been created in goto symbol table earlier. If so,
  // it is used otherwise new symbol is created. And added to the symbol table.
  try {
    symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(I->getFunction()->getName().str() + "::" + I->getName().str());

  goto_programt::targett xor_inst = gp.add_instruction();
  xor_inst->make_assignment();
  // Add instruction in llvm becomes an assignment statement in goto,
  // with a symbol on LHS and bitxor_exprt on RHS.
  xor_inst->code = code_assignt(result.symbol_expr(),
    bitxor_exprt(exprt1, exprt2));
  xor_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if (&(I->getDebugLoc()) != NULL) {
    const DebugLoc loc = I->getDebugLoc();
    location.set_file(loc
          ->getScope()->getFile()->getFilename().str());
    location.set_working_directory(loc
          ->getScope()->getFile()->getDirectory().str());
    location.set_line(loc->getLine());
    location.set_column(loc->getColumn());
  }
  xor_inst->source_location = location;
  xor_inst->type = goto_program_instruction_typet::ASSIGN;
  // assert(false && "And is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

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
  // errs() << "Alloca is yet to be mapped \n";
  symbolt symbol;
  symbol.type = symbol_creator::create_type(
    dyn_cast<AllocaInst>(I)->getAllocatedType());
  symbol.base_name = I->getName().str();
  symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
  symbol_table.add(symbol);
  // goto_programt::targett decl_alloc = gp.add_instruction();
  //   decl_alloc->make_decl();
  //   decl_alloc->code=code_declt(symbol.symbol_expr());
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_Load

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::Load.

    Purpose: Map llvm::Instruction::Load to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_Load(const Instruction *I) {
  goto_programt gp;
  errs() << "Load is yet to be mapped \n";
  /*errs() << " getIterator :";
  (*dyn_cast<LoadInst>(I)->getIterator()).dump();
  errs() << " getNumOperands :" << dyn_cast<LoadInst>(I)->getNumOperands();
  errs() << " getOperand :";
  dyn_cast<LoadInst>(I)->getOperand(0)->dump();
  errs() << " getType :";
  dyn_cast<LoadInst>(I)->getType()->dump();*/
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_Store

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::Store.

    Purpose: Map llvm::Instruction::Store to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_Store(const Instruction *I,
  const symbol_tablet &symbol_table) {
  // errs() << "few things need to be handled in Store Instruction \n";
  goto_programt gp;
  // symbol_table.show(std::cout);
  symbolt symbol = symbol_table.lookup(I->getFunction()->getName().str() + "::" +
    dyn_cast<StoreInst>(I)->getOperand(1)->getName().str());
  exprt value_to_store;
  if (dyn_cast<Constant>(dyn_cast<StoreInst>(I)->getOperand(0))) {
    if (dyn_cast<ConstantInt>(dyn_cast<StoreInst>(I)->getOperand(0))) {
      uint64_t val = dyn_cast<ConstantInt>(
      dyn_cast<StoreInst>(I)->getOperand(0))->getZExtValue();
      value_to_store = from_integer(val, symbol.type);
    } else if (dyn_cast<ConstantFP>(dyn_cast<StoreInst>(I)->getOperand(0))) {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>(dyn_cast<StoreInst>(I)->getOperand(0)->getType());
      if (floattype->isFloatTy()) {
        float val = dyn_cast<ConstantFP>(dyn_cast<StoreInst>(I)->getOperand(0))->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        value_to_store = ieee_fl.to_expr();
      } else if (floattype->isDoubleTy()) {
        float val = dyn_cast<ConstantFP>(dyn_cast<StoreInst>(I)->getOperand(0))->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        value_to_store = ieee_fl.to_expr();
      } else {
        assert(false && "This floating point type in above instruction is not handled");
      }
      // assert(false && "This constant type is not handled");
    } else {
      assert(false && "This constant type is not handled");
    }
  } else {
    if (dyn_cast<StoreInst>(I)->getOperand(0)->hasName()) {
      errs() << dyn_cast<StoreInst>(I)->getOperand(0)->getName();
      // assert(false && "stop here\n");
      value_to_store = symbol_table.lookup(I->getFunction()->getName().str() + "::" +
      dyn_cast<StoreInst>(I)->getOperand(0)->getName().str()).symbol_expr();
    } else if (dyn_cast<LoadInst>(dyn_cast<StoreInst>(I)->getOperand(0))) {
      std::string name = I->getFunction()->getName().str() + "::" +
        dyn_cast<LoadInst>(dyn_cast<StoreInst>(I)->getOperand(0))
        ->getOperand(0)->getName().str();
      value_to_store = symbol_table.lookup(name).symbol_expr();
    }
  }
  goto_programt::targett store_inst = gp.add_instruction();
  store_inst->make_assignment();
  store_inst->code = code_assignt(symbol.symbol_expr(), value_to_store);
  store_inst->function = irep_idt(I->getFunction()->getName().str());
  // errs() << "\n      Instruction metadata is :";
  SmallVector<std::pair<unsigned, MDNode *>, 4> MDs;
  I->getAllMetadata(MDs);
  SmallVector<std::pair<unsigned, MDNode *>, 4>::iterator md = MDs.begin();
  source_locationt location;
  // errs() << md;
  // md->second->dump();
  // TODO(Rasika) : use getDILoc()
  /*if (dyn_cast<DILocation>(md->second)) {
    location.set_file(dyn_cast<DIFile>(
      dyn_cast<DISubprogram>(
        dyn_cast<DILocation>(md->second)->getScope())
      ->getFile())->getFilename().str());
    location.set_working_directory(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)
          ->getScope())->getFile())->getDirectory().str());
    location.set_line(dyn_cast<DILocation>(md->second)->getLine());
  }*/
  store_inst->source_location = location;
  store_inst->type = goto_program_instruction_typet::ASSIGN;
  namespacet ns(symbol_table);
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_AtomicCmpXchg

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::AtomicCmpXchg.

    Purpose: Map llvm::Instruction::AtomicCmpXchg to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_AtomicCmpXchg(
  const Instruction *I) {
  goto_programt gp;
  assert(false && "AtomicCmpXchg is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

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

 /*******************************************************************\

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

 /*******************************************************************\

   Function: llvm2goto_translator::trans_GetElementPtr

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::GetElementPtr.

    Purpose: Map llvm::Instruction::GetElementPtr to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_GetElementPtr(
  const Instruction *I) {
  goto_programt gp;
  assert(false && "GetElementPtr is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_Trunc

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::Trunc.

    Purpose: Map llvm::Instruction::Trunc to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_Trunc(const Instruction *I) {
  goto_programt gp;
  assert(false && "Trunc is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_ZExt

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::ZExt.

    Purpose: Map llvm::Instruction::ZExt to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_ZExt(const Instruction *I) {
  goto_programt gp;
  // assert(false && "ZExt is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_SExt

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::SExt.

    Purpose: Map llvm::Instruction::SExt to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_SExt(const Instruction *I) {
  goto_programt gp;
  // assert(false && "SExt is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_FPTrunc

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::FPTrunc.

    Purpose: Map llvm::Instruction::FPTrunc to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_FPTrunc(const Instruction *I) {
  goto_programt gp;
  assert(false && "FPTrunc is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_FPExt

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::FPExt.

    Purpose: Map llvm::Instruction::FPExt to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_FPExt(const Instruction *I) {
  goto_programt gp;
  // errs() << "FPExt is yet to be mapped \n";
  assert(false && "FPExt is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_FPToUI

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::FPToUI.

    Purpose: Map llvm::Instruction::FPToUI to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_FPToUI(const Instruction *I) {
  goto_programt gp;
  assert(false && "FPToUI is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_FPToSI

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::FPToSI.

    Purpose: Map llvm::Instruction::FPToSI to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_FPToSI(const Instruction *I) {
  goto_programt gp;
  assert(false && "FPToSI is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_UIToFP

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::UIToFP.

    Purpose: Map llvm::Instruction::UIToFP to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_UIToFP(const Instruction *I) {
  goto_programt gp;
  assert(false && "UIToFP is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_SIToFP

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::SIToFP.

    Purpose: Map llvm::Instruction::SIToFP to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_SIToFP(const Instruction *I) {
  goto_programt gp;
  assert(false && "SIToFP is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

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

 /*******************************************************************\

   Function: llvm2goto_translator::trans_PtrToInt

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::PtrToInt.

    Purpose: Map llvm::Instruction::PtrToInt to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_PtrToInt(const Instruction *I) {
  goto_programt gp;
  assert(false && "PtrToInt is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_BitCast

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::BitCast.

    Purpose: Map llvm::Instruction::BitCast to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_BitCast(const Instruction *I) {
  goto_programt gp;
  assert(false && "BitCast is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_AddrSpaceCast

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::AddrSpaceCast.

    Purpose: Map llvm::Instruction::AddrSpaceCast to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_AddrSpaceCast(
  const Instruction *I) {
  goto_programt gp;
  assert(false && "AddrSpaceCast is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

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
  if (dyn_cast<ConstantInt>(*ub)) {
    uint64_t val = dyn_cast<ConstantInt>(*ub)->getZExtValue();
    typet type = symbol_creator::create_type(
      dyn_cast<ConstantInt>(*ub)->getType());
    dyn_cast<ConstantInt>(*ub)->getType()->dump();
    opnd1 = from_integer(val, type);
  } else if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    opnd1 = symbol_table->lookup(I->getFunction()->getName().str() + "::" +
      li->getOperand(0)->getName().str()).symbol_expr();
  } else {
    opnd1 = symbol_table->lookup(I->getFunction()->getName().str() + "::" + ub->getName().str()).symbol_expr();
  }

  if (dyn_cast<ConstantInt>(*(ub + 1))) {
    uint64_t val = dyn_cast<ConstantInt>(*(ub+1))->getZExtValue();
    typet type = symbol_creator::create_type(
      dyn_cast<ConstantInt>(*(ub+1))->getType());
    dyn_cast<ConstantInt>(*(ub+1))->getType()->dump();
    opnd2 = from_integer(val, type);
  } else if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
    li->getOperand(0)->dump();
    opnd2 = symbol_table->lookup(I->getFunction()->getName().str() + "::" + 
      li->getOperand(0)->getName().str()).symbol_expr();
  } else {
    opnd2 = symbol_table->lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str()).symbol_expr();
  }


  switch (dyn_cast<ICmpInst>(I)->getPredicate()) {
    case CmpInst::Predicate::ICMP_EQ : {
      condition = equal_exprt(opnd1, opnd2);
      errs() << "\n ICMP_EQ\n";
      break;
    }
    case CmpInst::Predicate::ICMP_NE : {
      condition = notequal_exprt(opnd1, opnd2);
      errs() << "\n ICMP_NE\n";
      break;
    }
    case CmpInst::Predicate::ICMP_UGT :
    case CmpInst::Predicate::ICMP_SGT : {
      errs() << "\n ICMP_GT\n";
      condition = exprt(ID_gt);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_UGE : {
    case CmpInst::Predicate::ICMP_SGE :
      errs() << "\n ICMP_GE\n";
      condition = exprt(ID_ge);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_ULT :
    case CmpInst::Predicate::ICMP_SLT : {
      errs() << "\n ICMP_LT\n";
      condition = exprt(ID_lt);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_ULE :
    case CmpInst::Predicate::ICMP_SLE : {
      errs() << "\n ICMP_LE\n";
      condition = exprt(ID_le);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::BAD_ICMP_PREDICATE : {
      errs() << "\n BAD_ICMP_PREDICATE\n";
      break;
    }
    default : errs() << "\nNON ICMP\n";
  }

  // errs() << "ICmp is yet to be mapped \n";
  return condition;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_Inverse_Cmp

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::ICmp.

    Purpose: Map llvm::Instruction::ICmp to corresponding goto instruction.

\*******************************************************************/
exprt llvm2goto_translator::trans_Inverse_Cmp(const Instruction *I,
  symbol_tablet *symbol_table) {
  exprt condition;
  I->dump();
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  exprt opnd1, opnd2;
  if (dyn_cast<ConstantInt>(*ub)) {
    uint64_t val = dyn_cast<ConstantInt>(*ub)->getZExtValue();
    typet type = symbol_creator::create_type(
      dyn_cast<ConstantInt>(*ub)->getType());
    dyn_cast<ConstantInt>(*ub)->getType()->dump();
    opnd1 = from_integer(val, type);
  } else if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    opnd1 = symbol_table->lookup(I->getFunction()->getName().str() + "::" + 
      li->getOperand(0)->getName().str()).symbol_expr();
  } else {
    opnd1 = symbol_table->lookup(I->getFunction()->getName().str() + "::" + ub->getName().str()).symbol_expr();
  }

  if (dyn_cast<ConstantInt>(*(ub + 1))) {
    uint64_t val = dyn_cast<ConstantInt>(*(ub+1))->getZExtValue();
    typet type = symbol_creator::create_type(
      dyn_cast<ConstantInt>(*(ub+1))->getType());
    dyn_cast<ConstantInt>(*(ub+1))->getType()->dump();
    opnd2 = from_integer(val, type);
  } else if (const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1))) {
    li->getOperand(0)->dump();
    opnd2 = symbol_table->lookup(I->getFunction()->getName().str() + "::" + 
      li->getOperand(0)->getName().str()).symbol_expr();
  } else {
    opnd2 = symbol_table->lookup(I->getFunction()->getName().str() + "::" + (ub + 1)->getName().str()).symbol_expr();
  }
  switch (dyn_cast<ICmpInst>(I)->getInversePredicate()) {
    case CmpInst::Predicate::ICMP_EQ : {
      condition = equal_exprt(opnd1, opnd2);
      errs() << "\n ICMP_EQ\n";
      break;
    }
    case CmpInst::Predicate::ICMP_NE : {
      condition = notequal_exprt(opnd1, opnd2);
      errs() << "\n ICMP_NE\n";
      break;
    }
    case CmpInst::Predicate::ICMP_UGT :
    case CmpInst::Predicate::ICMP_SGT : {
      errs() << "\n ICMP_GT\n";
      condition = exprt(ID_gt);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_UGE : {
    case CmpInst::Predicate::ICMP_SGE :
      errs() << "\n ICMP_GE\n";
      condition = exprt(ID_ge);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_ULT :
    case CmpInst::Predicate::ICMP_SLT : {
      errs() << "\n ICMP_LT\n";
      condition = exprt(ID_lt);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_ULE :
    case CmpInst::Predicate::ICMP_SLE : {
      errs() << "\n ICMP_LE\n";
      condition = exprt(ID_le);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::BAD_ICMP_PREDICATE : {
      errs() << "\n BAD_ICMP_PREDICATE\n";
      break;
    }
    default : errs() << "\nNON ICMP\n";
  }

  errs() << "ICmp is yet to be mapped \n";
  return condition;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_ICmp

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::ICmp.

    Purpose: Map llvm::Instruction::ICmp to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_ICmp(const Instruction *I) {
  goto_programt gp;
  goto_programt::targett Icmp_inst = gp.add_instruction();
  Icmp_inst->make_skip();
  // errs() << "ICmp is yet to be mapped \n";
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_FCmp

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::FCmp.

    Purpose: Map llvm::Instruction::FCmp to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_FCmp(const Instruction *I) {
  goto_programt gp;
  goto_programt::targett Icmp_inst = gp.add_instruction();
  Icmp_inst->make_skip();
  // errs() << "FCmp is yet to be mapped \n";
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_PHI

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::PHI.

    Purpose: Map llvm::Instruction::PHI to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_PHI(const Instruction *I) {
  goto_programt gp;
  assert(false && "PHI is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

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

 /*******************************************************************\

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
  errs() << "Call is yet to be mapped \n";
  if (const DbgDeclareInst *dbgDeclareInst = dyn_cast<DbgDeclareInst>(&*I)) {
    Type *type = &(*dyn_cast<Type>(dyn_cast<PointerType>(dyn_cast<Type>(
      dbgDeclareInst->getAddress()->getType()))->getPointerElementType()));
    MDNode *mdn = dyn_cast<MDNode>(dbgDeclareInst->getVariable());
    // symbolt &lookup(const irep_idt &identifier);
    symbol_table->remove(I->getFunction()->getName().str() + "::" + dyn_cast<DIVariable>(mdn)->getName().str());
    symbolt symbol;
    switch (dyn_cast<PointerType>(dyn_cast<Type>(dbgDeclareInst->getAddress()
      ->getType()))->getPointerElementType()->getTypeID()) {
      // 16-bit floating point type
      case llvm::Type::TypeID::HalfTyID : {
        errs() << "\nHalf type";
        symbol = symbol_creator::create_HalfTy(type, mdn);
        symbol.name = I->getFunction()->getName().str() + "::" + symbol.base_name.c_str();
        symbol_table->add(symbol);
        goto_programt::targett decl_symbol = gp.add_instruction();
        decl_symbol->make_decl();
        decl_symbol->code=code_declt(symbol.symbol_expr());
        decl_symbol->source_location = symbol.location;
      }
      // 32-bit floating point type
      case llvm::Type::TypeID::FloatTyID : {
        errs() << "\nFloat type";
        symbol = symbol_creator::create_FloatTy(type, mdn);
        symbol.name = I->getFunction()->getName().str() + "::" + symbol.base_name.c_str();
        symbol_table->add(symbol);
        goto_programt::targett decl_symbol = gp.add_instruction();
        decl_symbol->make_decl();
        decl_symbol->code=code_declt(symbol.symbol_expr());
        decl_symbol->source_location = symbol.location;
        break;
      }
      // 64-bit floating point type
      case llvm::Type::TypeID::DoubleTyID : {
        symbol = symbol_creator::create_DoubleTy(type, mdn);
        symbol.name = I->getFunction()->getName().str() + "::" + symbol.base_name.c_str();
        symbol_table->add(symbol);
        goto_programt::targett decl_symbol = gp.add_instruction();
        decl_symbol->make_decl();
        decl_symbol->code=code_declt(symbol.symbol_expr());
        decl_symbol->source_location = symbol.location;
        errs() << "\nDouble type";
        break;
      }
      // 80-bit floating point type (X87)
      case llvm::Type::TypeID::X86_FP80TyID : {
        symbol = symbol_creator::create_X86_FP80Ty(type, mdn);
        symbol.name = I->getFunction()->getName().str() + "::" + symbol.base_name.c_str();
        symbol_table->add(symbol);
        goto_programt::targett decl_symbol = gp.add_instruction();
        decl_symbol->make_decl();
        decl_symbol->code=code_declt(symbol.symbol_expr());
        decl_symbol->source_location = symbol.location;
        errs() << "\nX86_FP80 type";
        break;
      }
      // 128-bit floating point type (112-bit mantissa)
      case llvm::Type::TypeID::FP128TyID : {
        symbol = symbol_creator::create_FP128Ty(type, mdn);
        symbol.name = I->getFunction()->getName().str() + "::" + symbol.base_name.c_str();
        symbol_table->add(symbol);
        goto_programt::targett decl_symbol = gp.add_instruction();
        decl_symbol->make_decl();
        decl_symbol->code=code_declt(symbol.symbol_expr());
        decl_symbol->source_location = symbol.location;
        errs() << "\nFP128 type";
        break;
      }
      // 128-bit floating point type (two 64-bits, PowerPC)
      case llvm::Type::TypeID::PPC_FP128TyID : {
        symbol = symbol_creator::create_PPC_FP128Ty(type, mdn);
        symbol.name = I->getFunction()->getName().str() + "::" + symbol.base_name.c_str();
        symbol_table->add(symbol);
        goto_programt::targett decl_symbol = gp.add_instruction();
        decl_symbol->make_decl();
        decl_symbol->code=code_declt(symbol.symbol_expr());
        decl_symbol->source_location = symbol.location;
        errs() << "\nPPC_FP128 type";
        break;
      }
      case llvm::Type::TypeID::IntegerTyID : {
        symbol = symbol_creator::create_IntegerTy(type, mdn);
        symbol.name = I->getFunction()->getName().str() + "::" + symbol.base_name.c_str();
        symbol_table->add(symbol);
        goto_programt::targett decl_symbol = gp.add_instruction();
        decl_symbol->make_decl();
        decl_symbol->code=code_declt(symbol.symbol_expr());
        decl_symbol->source_location = symbol.location;
        errs() << "\nInteger type";
        break;
      }
      case llvm::Type::TypeID::StructTyID : {
        // const MDNode *dit = dyn_cast<MDNode>(*mmd);
        symbol = symbol_creator::create_StructTy(type, mdn);
        symbol.name = I->getFunction()->getName().str() + "::" + symbol.base_name.c_str();
        symbol_table->add(symbol);
        goto_programt::targett decl_symbol = gp.add_instruction();
        decl_symbol->make_decl();
        decl_symbol->code=code_declt(symbol.symbol_expr());
        decl_symbol->source_location = symbol.location;
        errs() << "\nStruct type";
        break;
      }
      case llvm::Type::TypeID::ArrayTyID : {
        symbol = symbol_creator::create_ArrayTy(type, mdn);
        symbol.name = I->getFunction()->getName().str() + "::" + symbol.base_name.c_str();
        symbol_table->add(symbol);
        goto_programt::targett decl_symbol = gp.add_instruction();
        decl_symbol->make_decl();
        decl_symbol->code=code_declt(symbol.symbol_expr());
        decl_symbol->source_location = symbol.location;
        errs() << "\nArray type";
        break;
      }
      case llvm::Type::TypeID::PointerTyID : {
        symbol = symbol_creator::create_PointerTy(type, mdn);
        symbol.name = I->getFunction()->getName().str() + "::" + symbol.base_name.c_str();
        symbol_table->add(symbol);
        goto_programt::targett decl_symbol = gp.add_instruction();
        decl_symbol->make_decl();
        decl_symbol->code=code_declt(symbol.symbol_expr());
        decl_symbol->source_location = symbol.location;
        errs() << "\nPointer type";
        break;
      }
      case llvm::Type::TypeID::VectorTyID : {
        symbol = symbol_creator::create_VectorTy(type, mdn);
        symbol.name = I->getFunction()->getName().str() + "::" + symbol.base_name.c_str();
        symbol_table->add(symbol);
        goto_programt::targett decl_symbol = gp.add_instruction();
        decl_symbol->make_decl();
        decl_symbol->code=code_declt(symbol.symbol_expr());
        decl_symbol->source_location = symbol.location;
        errs() << "\nVector type";
        break;
      }
      case llvm::Type::TypeID::X86_MMXTyID : {
        symbol = symbol_creator::create_X86_MMXTy(type, mdn);
        symbol.name = I->getFunction()->getName().str() + "::" + symbol.base_name.c_str();
        symbol_table->add(symbol);
        goto_programt::targett decl_symbol = gp.add_instruction();
        decl_symbol->make_decl();
        decl_symbol->code=code_declt(symbol.symbol_expr());
        decl_symbol->source_location = symbol.location;
        break;
      }
      case llvm::Type::TypeID::VoidTyID :
      case llvm::Type::TypeID::FunctionTyID :
      case llvm::Type::TypeID::TokenTyID :
      case llvm::Type::TypeID::LabelTyID :
      case llvm::Type::TypeID::MetadataTyID :
        default:
        errs() << "\ninvalid type for global variable";
    }
  } else if (dyn_cast<CallInst>(I)->getCalledFunction() == NULL) {
    // dyn_cast<CallInst>(I)->dump();
    const Value *called_val = dyn_cast<CallInst>(I)->getCalledValue();
    const Function *function = dyn_cast<Function>(called_val->stripPointerCasts());
    if(function->getName().str() == "assume"){
      errs() << "assume";
      goto_programt::targett assume_inst = gp.add_instruction(ASSUME);
      Value *opnd = dyn_cast<CallInst>(I)->getArgOperand(0);
      exprt guard;
      if (Value *cmp = *dyn_cast<Instruction>(opnd)->value_op_begin()) {
        guard = trans_Cmp(dyn_cast<Instruction>(cmp), symbol_table);        
      }
      assume_inst->guard = guard;
    }
    if(function->getName().str() == "assert"){
      errs() << "assert";
      goto_programt::targett assert_inst = gp.add_instruction(ASSERT);
      Value *opnd = dyn_cast<CallInst>(I)->getArgOperand(0);
      exprt guard;
      if (Value *cmp = *dyn_cast<Instruction>(opnd)->value_op_begin()) {
        guard = trans_Cmp(dyn_cast<Instruction>(cmp), symbol_table);
      }
      assert_inst->guard = guard;
    }
  } else {
    const Function *function = dyn_cast<CallInst>(I)->getCalledFunction();
    if (function->begin() != function->end()) {
      code_function_callt call;
      // I->dump();
      std::string func_name = function->getName().str();
      symbolt symbol = namespacet(*symbol_table).lookup(dstringt(func_name));
      call.function() = symbol.symbol_expr();
      if(to_code_type(symbol.type).return_type()!=empty_typet()) {
        symbolt ret;
        ret.base_name = I->getName().str();
        ret.name = I->getFunction()->getName().str() + "::" + I->getName().str();
        ret.type = symbol_creator::create_type(function->getReturnType());
        symbol_table->add(ret);
        // goto_programt::targett ret_decl = gp.add_instruction();
        goto_programt::targett decl_ret = gp.add_instruction();
        //TODO(Rasika) : function arguments sathi kahitari kara.
        //TODO(Rasika) : lookup local and global variables.
        decl_ret->make_decl();
        decl_ret->code=code_declt(ret.symbol_expr());
        call.lhs()= ret.symbol_expr();
      }
      llvm::User::const_value_op_iterator ub = I->value_op_begin();
      for(code_typet::parameterst::const_iterator
        p_it=to_code_type(symbol.type).parameters().begin();
        p_it!=to_code_type(symbol.type).parameters().end();
        p_it++) {
        exprt expr;
        if (dyn_cast<ConstantInt>(*ub)) {
          uint64_t val = dyn_cast<ConstantInt>(*ub)->getZExtValue();
          typet type = symbol_creator::create_type(
            dyn_cast<ConstantInt>(*ub)->getType());
          dyn_cast<ConstantInt>(*ub)->getType()->dump();
          expr = from_integer(val, type);
        } else if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
          li->getOperand(0)->dump();
          expr = symbol_table->lookup(I->getFunction()->getName().str() + "::" + 
            li->getOperand(0)->getName().str()).symbol_expr();
        } else {
          expr = symbol_table->lookup(I->getFunction()->getName().str() + "::" + ub->getName().str()).symbol_expr();
        }
        call.arguments().push_back(expr);
        ub++;
      }
      goto_programt::targett call_inst = gp.add_instruction();
      call_inst->make_function_call(call);
    }
  }
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_Shl

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::Shl.

    Purpose: Map llvm::Instruction::Shl to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_Shl(const Instruction *I) {
  goto_programt gp;
  assert(false && "Shl is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_LShr

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::LShr.

    Purpose: Map llvm::Instruction::LShr to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_LShr(const Instruction *I) {
  goto_programt gp;
  assert(false && "LShr is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_AShr

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::AShr.

    Purpose: Map llvm::Instruction::AShr to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_AShr(const Instruction *I) {
  goto_programt gp;
  assert(false && "AShr is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

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

 /*******************************************************************\

   Function: llvm2goto_translator::trans_ExtractElement

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::ExtractElement.

    Purpose: Map llvm::Instruction::ExtractElement to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_ExtractElement(
  const Instruction *I) {
  goto_programt gp;
  assert(false && "ExtractElement is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_InsertElement

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::InsertElement.

    Purpose: Map llvm::Instruction::InsertElement to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_InsertElement(
  const Instruction *I) {
  goto_programt gp;
  assert(false && "InsertElement is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

   Function: llvm2goto_translator::trans_ShuffleVector

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::ShuffleVector.

    Purpose: Map llvm::Instruction::ShuffleVector to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_ShuffleVector(
  const Instruction *I) {
  goto_programt gp;
  assert(false && "ShuffleVector is yet to be mapped \n");
  return gp;
}

 /*******************************************************************\

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

 /*******************************************************************\

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

 /*******************************************************************\

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

 /*******************************************************************\

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

/*******************************************************************\

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
          symbolt global_variable;
          global_variable.clear();
          global_variable.is_static_lifetime = true;
          for (auto mmd = (*md)->op_begin(); mmd != (*md)->op_end(); ++mmd) {
            if (mmd->get()) {
              switch (GV.getValueType()->getTypeID()) {
                // 16-bit floating point type
                case llvm::Type::TypeID::HalfTyID : {
                  errs() << "\nHalf type";
                  symbolt symbol = symbol_creator::create_HalfTy(GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                }
                // 32-bit floating point type
                case llvm::Type::TypeID::FloatTyID : {
                  errs() << "\nFloat type";
                  symbolt symbol = symbol_creator::create_FloatTy(GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  break;
                }
                // 64-bit floating point type
                case llvm::Type::TypeID::DoubleTyID : {
                  symbolt symbol = symbol_creator::create_DoubleTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nDouble type";
                  break;
                }
                // 80-bit floating point type (X87)
                case llvm::Type::TypeID::X86_FP80TyID : {
                  symbolt symbol = symbol_creator::create_X86_FP80Ty(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nX86_FP80 type";
                  break;
                }
                // 128-bit floating point type (112-bit mantissa)
                case llvm::Type::TypeID::FP128TyID : {
                  symbolt symbol = symbol_creator::create_FP128Ty(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nFP128 type";
                  break;
                }
                // 128-bit floating point type (two 64-bits, PowerPC)
                case llvm::Type::TypeID::PPC_FP128TyID : {
                  symbolt symbol = symbol_creator::create_PPC_FP128Ty(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nPPC_FP128 type";
                  break;
                }
                case llvm::Type::TypeID::IntegerTyID : {
                  symbolt symbol = symbol_creator::create_IntegerTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nInteger type";
                  break;
                }
                case llvm::Type::TypeID::StructTyID : {
                  const MDNode *dit = dyn_cast<MDNode>(*mmd);
                  symbolt symbol = symbol_creator::create_StructTy(
                    GV.getValueType(),
                    dit);
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nStruct type";
                  break;
                }
                case llvm::Type::TypeID::ArrayTyID : {
                  symbolt symbol = symbol_creator::create_ArrayTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nArray type";
                  break;
                }
                case llvm::Type::TypeID::PointerTyID : {
                  symbolt symbol = symbol_creator::create_PointerTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nPointer type";
                  break;
                }
                case llvm::Type::TypeID::VectorTyID : {
                  symbolt symbol = symbol_creator::create_VectorTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nVector type";
                  break;
                }
                case llvm::Type::TypeID::X86_MMXTyID : {
                  symbolt symbol = symbol_creator::create_X86_MMXTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  break;
                }
                case llvm::Type::TypeID::VoidTyID :
                case llvm::Type::TypeID::FunctionTyID :
                case llvm::Type::TypeID::TokenTyID :
                case llvm::Type::TypeID::LabelTyID :
                case llvm::Type::TypeID::MetadataTyID :
                  errs() << "\ninvalid type for global variable";;
              }
            }
          }
        }
      }
    }
  }
  // errs() << "\nhello";
  // global_variable.is_thread_local=false;
  // goto_functionst goto_functions;
  // symbol_table.show(std::cout);
  // namespacet ns(symbol_table);
  // ns.get_symbol_table().show(std::cout);
  // errs() << "\nbye";
  return symbol_table;
}

/*******************************************************************\

   Function: llvm2goto_translator::trans_instruction

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             given llvm instruction.

    Purpose: Map llvm::Instruction to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_instruction(const Instruction &I,
  symbol_tablet *symbol_table,
  std::map <const Instruction*, goto_programt::targett>
  &instruction_target_map) {
  errs() << "\n\t\t\tin trans_instruction\n\t\t\t\t";
  const Instruction *Inst = &I;
  goto_programt gp;
  switch (I.getOpcode()) {
    // Terminators
    case Instruction::Ret : {
      goto_programt ret_gp = trans_Ret(Inst, *symbol_table);
        gp.destructive_append(ret_gp);
        break;
      }
    case Instruction::Br : {
      goto_programt br_gp = trans_Br(Inst, symbol_table,
        instruction_target_map);
        gp.destructive_append(br_gp);
        break;
      }
    case Instruction::Switch : {
        gp = trans_Switch(Inst);
        break;
      }
    case Instruction::IndirectBr : {
        gp = trans_IndirectBr(Inst);
        break;
      }
    case Instruction::Invoke : {
        gp = trans_Invoke(Inst);
        break;
      }
    case Instruction::Resume : {
        gp = trans_Resume(Inst);
        break;
      }
    case Instruction::Unreachable : {
        gp = trans_Unreachable(Inst);
        break;
      }
    case Instruction::CleanupRet : {
        gp = trans_CleanupRet(Inst);
        break;
      }
    case Instruction::CatchRet : {
        gp = trans_CatchRet(Inst);
        break;
      }
    case Instruction::CatchPad : {
        gp = trans_CatchPad(Inst);
        break;
      }
    case Instruction::CatchSwitch : {
        gp = trans_CatchSwitch(Inst);
        break;
      }

    // Standard binary operators...
    case Instruction::Add : {
        goto_programt add_ins = trans_Add(Inst, *symbol_table);
        gp.destructive_append(add_ins);
        break;
      }
    case Instruction::FAdd : {
        goto_programt fadd_inst = trans_FAdd(Inst, *symbol_table);
        gp.destructive_append(fadd_inst);
        break;
      }
    case Instruction::Sub : {
        goto_programt sub_ins = trans_Sub(Inst, *symbol_table);
        gp.destructive_append(sub_ins);
        break;
      }
    case Instruction::FSub : {
        goto_programt fsub_inst = trans_FSub(Inst, *symbol_table);
        gp.destructive_append(fsub_inst);
        break;
      }
    case Instruction::Mul : {
        goto_programt mul_ins = trans_Mul(Inst, *symbol_table);
        gp.destructive_append(mul_ins);
        break;
      }
    case Instruction::FMul : {
        goto_programt fmul_inst = trans_FMul(Inst, *symbol_table);
        gp.destructive_append(fmul_inst);
        break;
      }
    case Instruction::UDiv : {
        goto_programt udiv_ins = trans_UDiv(Inst, *symbol_table);
        gp.destructive_append(udiv_ins);
        break;
      }
    case Instruction::SDiv : {
        goto_programt sdiv_ins = trans_SDiv(Inst, *symbol_table);
        gp.destructive_append(sdiv_ins);
        break;
      }
    case Instruction::FDiv : {
        goto_programt fdiv_inst = trans_FDiv(Inst, *symbol_table);
        gp.destructive_append(fdiv_inst);
        break;
      }
    case Instruction::URem : {
        goto_programt urem_ins = trans_URem(Inst, *symbol_table);
        gp.destructive_append(urem_ins);
        break;
      }
    case Instruction::SRem : {
        goto_programt srem_ins = trans_URem(Inst, *symbol_table);
        gp.destructive_append(srem_ins);
        break;
      }
    case Instruction::FRem : {
        goto_programt frem_inst = trans_FRem(Inst, *symbol_table);
        gp.destructive_append(frem_inst);
        break;
      }

    // Logical operators...
    case Instruction::And : {
        goto_programt and_inst = trans_And(Inst, *symbol_table);
        gp.destructive_append(and_inst);
        break;
      }
    case Instruction::Or : {
        goto_programt or_inst = trans_Or(Inst, *symbol_table);
        gp.destructive_append(or_inst);
        break;
      }
    case Instruction::Xor : {
        goto_programt xor_inst = trans_Xor(Inst, *symbol_table);
        gp.destructive_append(xor_inst);
        break;
      }

    // Memory instructions...
    case Instruction::Alloca : {
        trans_Alloca(Inst, *symbol_table);
        break;
      }
    case Instruction::Load : {
        gp = trans_Load(Inst);
        break;
      }
    case Instruction::Store : {
        goto_programt load_gp = trans_Store(Inst, *symbol_table);
        gp.destructive_append(load_gp);
        break;
      }
    case Instruction::AtomicCmpXchg : {
        gp = trans_AtomicCmpXchg(Inst);
        break;
      }
    case Instruction::AtomicRMW : {
        gp = trans_AtomicRMW(Inst);
        break;
      }
    case Instruction::Fence : {
        gp = trans_Fence(Inst);
        break;
      }
    case Instruction::GetElementPtr : {
        gp = trans_GetElementPtr(Inst);
        break;
      }

    // Convert instructions...
    case Instruction::Trunc : {
        gp = trans_Trunc(Inst);
        break;
      }
    case Instruction::ZExt : {
        gp = trans_ZExt(Inst);
        break;
      }
    case Instruction::SExt : {
        gp = trans_SExt(Inst);
        break;
      }
    case Instruction::FPTrunc : {
        gp = trans_FPTrunc(Inst);
        break;
      }
    case Instruction::FPExt : {
        gp = trans_FPExt(Inst);
        break;
      }
    case Instruction::FPToUI : {
        gp = trans_FPToUI(Inst);
        break;
      }
    case Instruction::FPToSI : {
        gp = trans_FPToSI(Inst);
        break;
      }
    case Instruction::UIToFP : {
        gp = trans_UIToFP(Inst);
        break;
      }
    case Instruction::SIToFP : {
        gp = trans_SIToFP(Inst);
        break;
      }
    case Instruction::IntToPtr : {
        gp = trans_IntToPtr(Inst);
        break;
      }
    case Instruction::PtrToInt : {
        gp = trans_PtrToInt(Inst);
        break;
      }
    case Instruction::BitCast : {
        gp = trans_BitCast(Inst);
        break;
      }
    case Instruction::AddrSpaceCast : {
        gp = trans_AddrSpaceCast(Inst);
        break;
      }

    // Other instructions...
    case Instruction::ICmp : {
        goto_programt Icmp_inst = trans_ICmp(Inst);
        gp.destructive_append(Icmp_inst);
        break;
      }
    case Instruction::FCmp : {
        goto_programt Fcmp_inst = trans_FCmp(Inst);
        gp.destructive_append(Fcmp_inst);
        break;
      }
    case Instruction::PHI : {
        gp = trans_PHI(Inst);
        break;
      }
    case Instruction::Select : {
        gp = trans_Select(Inst);
        break;
      }
    case Instruction::Call : {
        goto_programt Call_Inst = trans_Call(Inst, symbol_table);
        gp.destructive_append(Call_Inst);
        break;
      }
    case Instruction::Shl : {
        gp = trans_Shl(Inst);
        break;
      }
    case Instruction::LShr : {
        gp = trans_LShr(Inst);
        break;
      }
    case Instruction::AShr : {
        gp = trans_AShr(Inst);
        break;
      }
    case Instruction::VAArg : {
        gp = trans_VAArg(Inst);
        break;
      }
    case Instruction::ExtractElement : {
        gp = trans_ExtractElement(Inst);
        break;
      }
    case Instruction::InsertElement : {
        gp = trans_InsertElement(Inst);
        break;
      }
    case Instruction::ShuffleVector : {
        gp = trans_ShuffleVector(Inst);
        break;
      }
    case Instruction::ExtractValue : {
        gp = trans_ExtractValue(Inst);
        break;
      }
    case Instruction::InsertValue : {
        gp = trans_InsertValue(Inst);
        break;
      }
    case Instruction::LandingPad : {
        gp = trans_LandingPad(Inst);
        break;
      }
    case Instruction::CleanupPad : {
        gp = trans_CleanupPad(Inst);
        break;
      }

    default:
        errs() << "Invalid instruction type...\n ";
  }
  // errs() << "\t\t\tin trans_instruction";
  gp.update();
  // namespacet ns(*symbol_table);

  // register_language(new_ansi_c_language);
  // gp.output(std::cout);
  return gp;
}

/*******************************************************************\

   Function: llvm2goto_translator::trans_Block

    Inputs:
     I - Pointer to the llvm basic block.

    Outputs: Object of goto_programt containing goto instruction corresponding
             to llvm instruction in given llvm basic block.

    Purpose: Map llvm::Instruction to corresponding goto instruction in given
             llvm basic block.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_Block(const BasicBlock &b,
  symbol_tablet *symbol_table,
  std::map <const Instruction*, goto_programt::targett>
  &instruction_target_map) {
  // TODO(Rasika): use code_blockt
  errs() << "\t\tin trans_Block\n";
  goto_programt gp;
  // register_language(new_ansi_c_language);
  for (BasicBlock::const_iterator i = b.begin(),
    ie = b.end(); i != ie; ++i) {
      // const Instruction &inst = *i;
      // i -> dump();
      goto_programt goto_instr = trans_instruction(*i, symbol_table,
        instruction_target_map);
      gp.destructive_append(goto_instr);
      gp.update();
      errs() << "";
      // namespacet ns(*symbol_table);
    }

    // gp.output(std::cout);
    // errs() << "\t\tin trans_Block\n";
    return gp;
}

/*******************************************************************\

   Function: llvm2goto_translator::trans_Function

    Inputs:
     I - Pointer to the llvm function.

    Outputs: Object of goto_programt containing goto instruction corresponding
             to llvm instruction in given llvm function.

    Purpose: Map llvm::Instruction to corresponding goto instruction in given
             llvm function.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_Function(const Function &F,
  symbol_tablet *symbol_table) {
  // TODO(Rasika): check if definition
  //  is available or not, in built functions...
  goto_programt gp;
  goto_programt::targett hi;
  std::map <const BasicBlock*, goto_programt::targett> block_target_map;
  std::map <const Instruction*, goto_programt::targett> instruction_target_map;
  errs() << "\tin trans_Function\n";
  Function::const_iterator b = F.begin(), be = F.end();
  for (; b != be; ++b) {
    const BasicBlock &B = *b;
    goto_programt goto_block = trans_Block(B, symbol_table,
      instruction_target_map);
    register_language(new_ansi_c_language);
    goto_programt::targett target = goto_block.instructions.begin();
    // goto_block.output(std::cout);
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
  // namespacet ns(*symbol_table);

  // register_language(new_ansi_c_language);
  // gp.output(std::cout);
  // std::cout << "\n...............................................\n";
  // errs() << "\tin trans_Function\n";
  return gp;
}

/*******************************************************************\

   Function: llvm2goto_translator::set_branches

    Inputs:
     I - Pointer to the llvm module.

    Outputs: Object of goto_functionst containing goto function corresponding
             to given llvm function.

    Purpose: Translate llvm module into goto functions. Call required functions
             e.g. trans_Gloabals, trans_Block, etc.

\*******************************************************************/

void llvm2goto_translator::set_branches(symbol_tablet *symbol_table,
  std::map <const BasicBlock*, goto_programt::targett> block_target_map,
  std::map <const Instruction*, goto_programt::targett>
  instruction_target_map) {
  for (auto i = instruction_target_map.begin(),
    ie = instruction_target_map.end(); i != ie; i++) {
    // (*i).first->dump();
    if (dyn_cast<BranchInst>((*i).first)->getNumSuccessors() == 2) {
      goto_programt::targett then_part;
      exprt guard;
      if (dyn_cast<BranchInst>((*i).first)->isConditional()) {
        guard = trans_Inverse_Cmp(
          dyn_cast<Instruction>(
            dyn_cast<BranchInst>((*i).first)->getCondition()), symbol_table);
      } else {
        guard = true_exprt();
      }
      std::map <const BasicBlock*, goto_programt::targett>::iterator then_pair
      = block_target_map.find(
        dyn_cast<BasicBlock>(
          dyn_cast<BranchInst>((*i).first)->getSuccessor(1)));
      then_part = (*then_pair).second;
      (*i).second->make_goto(then_part, guard);
    } else {
      goto_programt::targett then_part;
      exprt guard;
      if (dyn_cast<BranchInst>((*i).first)->isConditional()) {
        guard = trans_Cmp(
          dyn_cast<Instruction>(
            dyn_cast<BranchInst>((*i).first)->getCondition()), symbol_table);
      } else {
        guard = true_exprt();
      }
      std::map <const BasicBlock*, goto_programt::targett>::iterator then_pair
      = block_target_map.find(
        dyn_cast<BasicBlock>(
          dyn_cast<BranchInst>((*i).first)->getSuccessor(0)));
      then_part = (*then_pair).second;
      (*i).second->make_goto(then_part, guard);
    }
  }
}

/*******************************************************************\

   Function: llvm2goto_translator::trans_Program

    Inputs:
     I - Pointer to the llvm module.

    Outputs: Object of goto_functionst containing goto function corresponding
             to given llvm function.

    Purpose: Translate llvm module into goto functions. Call required functions
             e.g. trans_Gloabals, trans_Block, etc.

\*******************************************************************/
goto_functionst llvm2goto_translator::trans_Program() {
  // TODO(Rasika): check for presence of function body
  // Module &M = *M;
  // errs() << "in trans_Program\n";
  goto_functionst goto_functions;
  // goto_functionst::goto_functiont goto_function;
  symbol_tablet symbol_table = trans_Globals(M);
  // symbol_table.show(std::cout);
  goto_programt gp;
  for (Function &F : *M) {
    Type *functt = (dyn_cast<Type>(F.getFunctionType()));
    symbolt fn = symbol_creator::create_FunctionTy(functt);
    fn.name = dstringt(F.getName().str());
    fn.base_name = fn.name;
    symbol_table.add(fn);
  }
  for (Function &F : *M) {
    // SmallVector<std::pair<unsigned, MDNode *>, 4> MDs;
    // F.getAllMetadata(MDs);
    // if(F.hasMetadata()) {
    //   MDs[0].second->dump();
    //   (*dyn_cast<DISubprogram>(MDs[0].second)).getType()->dump();
    //   dyn_cast<DISubroutineType>((*dyn_cast<DISubprogram>(MDs[0].second)).getType())->getTypeArray()->dump();
    // }
    Type *functt = (dyn_cast<Type>(F.getFunctionType()));
    symbolt fn = symbol_creator::create_FunctionTy(functt);
    fn.name = dstringt(F.getName().str());
    fn.base_name = fn.name;
    symbol_table.add(fn);
    for (Function::arg_iterator arg_b = F.arg_begin (), arg_e = F.arg_end();
      arg_b != arg_e; arg_b++) {
      symbolt arg;
      arg.name = F.getName().str() + "::" + arg_b->getName().str();
      arg.base_name = F.getName().str();
      symbol_table.add(arg);
    }
    goto_functions.function_map.insert(
      std::pair<const dstringt, goto_functionst::goto_functiont >(
        dstringt(F.getName()),
        goto_functionst::goto_functiont()));
    goto_programt func_gp = trans_Function(F, &symbol_table);
    // func_gp.ns = namespacet(symbol_table);
    gp.destructive_append(func_gp);
    (*goto_functions.function_map.find(dstringt(F.getName()))).
    second.body.swap(gp);
    (*goto_functions.function_map.find(dstringt(F.getName()))).
    second.type = to_code_type(fn.type);
  }

  namespacet ns(symbol_table);

  register_language(new_ansi_c_language);
  // goto_functions.ns = ns;
  errs() << &ns << "\n" << &ns.get_symbol_table() << "\nhello";

  // forall_symbols(ns.get_symbol_table().it, ns.get_symbol_table().symbols)
    // errs() << it->second;

  // if(&ns.get_symbol_table() != NULL) {
  //   errs() << "\n" << "Symbols:" <<  "\n";
  // }
  ns.get_symbol_table().show(std::cout);
  // errs() << "\nbye";
  errs() << "\nsize :" << (goto_functions).function_map.size() << "\n";
  errs() << "\ncalling goto_functions.output\n";
  goto_functions.output(ns, std::cout);
  /*for (goto_functionst::function_mapt::const_iterator \
    it = (goto_functions).function_map.begin(); \
    it != (goto_functions).function_map.end(); it++) {
      errs() << (*it).first.c_str() << "\n";
      it->second.body.output(std::cout);
  }*/
  errs() << "in trans_Program\n";
  return goto_functions;
}
