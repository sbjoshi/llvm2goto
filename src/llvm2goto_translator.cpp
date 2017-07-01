/* Copyright


*/

#include "llvm2goto_translator.h"

#include <llvm/IR/Type.h>

#include <utility>
#include <memory>
#include <string>

#include "symbol_creator.h"

#include "llvm/IR/IntrinsicInst.h"
#include "langapi/mode.h"

#include "ansi-c/ansi_c_language.h"

using namespace llvm;

// TODO(Rasika): Take care of srem and sdiv.

/*******************************************************************\

   Function: llvm2goto_translator::trans_Ret

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: Object of goto_programt containing goto instruction corresponding to
             llvm::Instruction::Ret.

    Purpose: Map llvm::Instruction::Ret to corresponding goto instruction.

\*******************************************************************/
goto_programt llvm2goto_translator::trans_Ret(const Instruction *I) {
//     // goto_programt::targett store_inst = gp.add_instruction();
//     store_inst->make_assignment();
//     store_inst->code = code_assignt(symbol.symbol_expr()
  // , from_integer(val, symbol.type));

  goto_programt gp;
  // goto_programt::targett ret_inst = gp.add_instruction();
  // ret_inst->make_return();
  errs() << "Ret is yet to be mapped \n";
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
goto_programt llvm2goto_translator::trans_Br(const Instruction *I) {
  goto_programt gp;
  errs() << "Br is yet to be mapped \n";
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
  errs() << "Switch is yet to be mapped \n";
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
  errs() << "IndirectBr is yet to be mapped \n";
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
  errs() << "Invoke is yet to be mapped \n";
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
  errs() << "Resume is yet to be mapped \n";
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
  errs() << "Unreachable is yet to be mapped \n";
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
  errs() << "CleanupRet is yet to be mapped \n";
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
  errs() << "CatchRet is yet to be mapped \n";
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
  errs() << "CatchPad is yet to be mapped \n";
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
  errs() << "CatchSwitch is yet to be mapped \n";
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
  goto_programt gp;
  // errs() << "Add is yet to be mapped \n";
  I->dump();
  errs() << I->getName();
  try {
    symbol_table.lookup(I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    errs() << I->getName() << "not found\n adding symbol\n";
    // I->getType()->dump();
    symbolt symbol;
    symbol.name = I->getName().str();
    symbol.type = symbol_creator::create_type(I->getType());
    symbol_table.add(symbol);
  }
  symbolt result = symbol_table.lookup(I->getName().str());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(li->getOperand(0)->getName().str());
  }
  if (const LoadInst *li = dyn_cast<LoadInst>(*(ub+1))) {
    li->getOperand(0)->dump();
    op2 = symbol_table.lookup(li->getOperand(0)->getName().str());
  }

  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
  add_inst->code = code_assignt(result.symbol_expr(),
    plus_exprt(op1.symbol_expr(), op2.symbol_expr()));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  // errs() << "\n      Instruction metadata is :";
  SmallVector<std::pair<unsigned, MDNode *>, 4> MDs;
  I->getAllMetadata(MDs);
  SmallVector<std::pair<unsigned, MDNode *>, 4>::iterator md = MDs.begin();
  source_locationt location;
  // errs() << md;
  // md->second->dump();
  if (dyn_cast<DILocation>(md->second)) {
    location.set_file(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)
          ->getScope())->getFile())->getFilename().str());
    location.set_working_directory(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)
          ->getScope())->getFile())->getDirectory().str());
    location.set_line(dyn_cast<DILocation>(md->second)->getLine());
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
goto_programt llvm2goto_translator::trans_FAdd(const Instruction *I) {
  goto_programt gp;
  errs() << "FAdd is yet to be mapped \n";
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
  // errs() << "Sub is yet to be mapped \n";
  I->dump();
  errs() << I->getName();
  try {
    symbol_table.lookup(I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    errs() << I->getName() << "not found\n adding symbol\n";
    // I->getType()->dump();
    symbolt symbol;
    symbol.name = I->getName().str();
    symbol.type = symbol_creator::create_type(I->getType());
    symbol_table.add(symbol);
  }
  symbolt result = symbol_table.lookup(I->getName().str());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(li->getOperand(0)->getName().str());
  }
  if (const LoadInst *li = dyn_cast<LoadInst>(*(ub+1))) {
    li->getOperand(0)->dump();
    op2 = symbol_table.lookup(li->getOperand(0)->getName().str());
  }

  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
  add_inst->code = code_assignt(result.symbol_expr(),
    minus_exprt(op1.symbol_expr(), op2.symbol_expr()));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  // errs() << "\n      Instruction metadata is :";
  SmallVector<std::pair<unsigned, MDNode *>, 4> MDs;
  I->getAllMetadata(MDs);
  SmallVector<std::pair<unsigned, MDNode *>, 4>::iterator md = MDs.begin();
  source_locationt location;
  // errs() << md;
  // md->second->dump();
  if (dyn_cast<DILocation>(md->second)) {
    location.set_file(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)
          ->getScope())->getFile())->getFilename().str());
    location.set_working_directory(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)
          ->getScope())->getFile())->getDirectory().str());
    location.set_line(dyn_cast<DILocation>(md->second)->getLine());
  }
  add_inst->source_location = location;
  add_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_FSub(const Instruction *I) {
  goto_programt gp;
  errs() << "FSub is yet to be mapped \n";
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
  // errs() << "Mul is yet to be mapped \n";
  I->dump();
  errs() << I->getName();
  try {
    symbol_table.lookup(I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    errs() << I->getName() << "not found\n adding symbol\n";
    // I->getType()->dump();
    symbolt symbol;
    symbol.name = I->getName().str();
    symbol.type = symbol_creator::create_type(I->getType());
    symbol_table.add(symbol);
  }
  symbolt result = symbol_table.lookup(I->getName().str());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(li->getOperand(0)->getName().str());
  }
  if (const LoadInst *li = dyn_cast<LoadInst>(*(ub+1))) {
    li->getOperand(0)->dump();
    op2 = symbol_table.lookup(li->getOperand(0)->getName().str());
  }

  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
  add_inst->code = code_assignt(result.symbol_expr(),
    mult_exprt(op1.symbol_expr(), op2.symbol_expr()));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  // errs() << "\n      Instruction metadata is :";
  SmallVector<std::pair<unsigned, MDNode *>, 4> MDs;
  I->getAllMetadata(MDs);
  SmallVector<std::pair<unsigned, MDNode *>, 4>::iterator md = MDs.begin();
  source_locationt location;
  // errs() << md;
  // md->second->dump();
  if (dyn_cast<DILocation>(md->second)) {
    location.set_file(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)
          ->getScope())->getFile())->getFilename().str());
    location.set_working_directory(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)
          ->getScope())->getFile())->getDirectory().str());
    location.set_line(dyn_cast<DILocation>(md->second)->getLine());
  }
  add_inst->source_location = location;
  add_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_FMul(const Instruction *I) {
  goto_programt gp;
  errs() << "FMul is yet to be mapped \n";
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
  // errs() << "UDiv is yet to be mapped \n";
  I->dump();
  errs() << I->getName();
  try {
    symbol_table.lookup(I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    errs() << I->getName() << "not found\n adding symbol\n";
    // I->getType()->dump();
    symbolt symbol;
    symbol.name = I->getName().str();
    symbol.type = symbol_creator::create_type(I->getType());
    symbol_table.add(symbol);
  }
  symbolt result = symbol_table.lookup(I->getName().str());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(li->getOperand(0)->getName().str());
  }
  if (const LoadInst *li = dyn_cast<LoadInst>(*(ub+1))) {
    li->getOperand(0)->dump();
    op2 = symbol_table.lookup(li->getOperand(0)->getName().str());
  }

  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
  add_inst->code = code_assignt(result.symbol_expr(),
    div_exprt(op1.symbol_expr(), op2.symbol_expr()));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  // errs() << "\n      Instruction metadata is :";
  SmallVector<std::pair<unsigned, MDNode *>, 4> MDs;
  I->getAllMetadata(MDs);
  SmallVector<std::pair<unsigned, MDNode *>, 4>::iterator md = MDs.begin();
  source_locationt location;
  // errs() << md;
  // md->second->dump();
  if (dyn_cast<DILocation>(md->second)) {
    location.set_file(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)
          ->getScope())->getFile())->getFilename().str());
    location.set_working_directory(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)
          ->getScope())->getFile())->getDirectory().str());
    location.set_line(dyn_cast<DILocation>(md->second)->getLine());
  }
  add_inst->source_location = location;
  add_inst->type = goto_program_instruction_typet::ASSIGN;
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
  // errs() << "SDiv is yet to be mapped \n";
  I->dump();
  errs() << I->getName();
  try {
    symbol_table.lookup(I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    errs() << I->getName() << "not found\n adding symbol\n";
    // I->getType()->dump();
    symbolt symbol;
    symbol.name = I->getName().str();
    symbol.type = symbol_creator::create_type(I->getType());
    symbol_table.add(symbol);
  }
  symbolt result = symbol_table.lookup(I->getName().str());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(li->getOperand(0)->getName().str());
  }
  if (const LoadInst *li = dyn_cast<LoadInst>(*(ub+1))) {
    li->getOperand(0)->dump();
    op2 = symbol_table.lookup(li->getOperand(0)->getName().str());
  }

  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
  add_inst->code = code_assignt(result.symbol_expr(),
    div_exprt(op1.symbol_expr(), op2.symbol_expr()));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  // errs() << "\n      Instruction metadata is :";
  SmallVector<std::pair<unsigned, MDNode *>, 4> MDs;
  I->getAllMetadata(MDs);
  SmallVector<std::pair<unsigned, MDNode *>, 4>::iterator md = MDs.begin();
  source_locationt location;
  // errs() << md;
  // md->second->dump();
  if (dyn_cast<DILocation>(md->second)) {
    location.set_file(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)
          ->getScope())->getFile())->getFilename().str());
    location.set_working_directory(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)
          ->getScope())->getFile())->getDirectory().str());
    location.set_line(dyn_cast<DILocation>(md->second)->getLine());
  }
  add_inst->source_location = location;
  add_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_FDiv(const Instruction *I) {
  goto_programt gp;
  errs() << "FDiv is yet to be mapped \n";
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
  // errs() << "URem is yet to be mapped \n";
  I->dump();
  errs() << I->getName();
  try {
    symbol_table.lookup(I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    errs() << I->getName() << "not found\n adding symbol\n";
    // I->getType()->dump();
    symbolt symbol;
    symbol.name = I->getName().str();
    symbol.type = symbol_creator::create_type(I->getType());
    symbol_table.add(symbol);
  }
  symbolt result = symbol_table.lookup(I->getName().str());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(li->getOperand(0)->getName().str());
  }
  if (const LoadInst *li = dyn_cast<LoadInst>(*(ub+1))) {
    li->getOperand(0)->dump();
    op2 = symbol_table.lookup(li->getOperand(0)->getName().str());
  }

  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
  add_inst->code = code_assignt(result.symbol_expr(),
    mod_exprt(op1.symbol_expr(), op2.symbol_expr()));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  // errs() << "\n      Instruction metadata is :";
  SmallVector<std::pair<unsigned, MDNode *>, 4> MDs;
  I->getAllMetadata(MDs);
  SmallVector<std::pair<unsigned, MDNode *>, 4>::iterator md = MDs.begin();
  source_locationt location;
  // errs() << md;
  // md->second->dump();
  if (dyn_cast<DILocation>(md->second)) {
    location.set_file(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)
          ->getScope())->getFile())->getFilename().str());
    location.set_working_directory(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)->getScope())
        ->getFile())->getDirectory().str());
    location.set_line(dyn_cast<DILocation>(md->second)->getLine());
  }
  add_inst->source_location = location;
  add_inst->type = goto_program_instruction_typet::ASSIGN;
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
  // errs() << "SRem is yet to be mapped \n";
  I->dump();
  errs() << I->getName();
  try {
    symbol_table.lookup(I->getName().str());
  } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
    std::allocator<char> > msg) {
    errs() << I->getName() << "not found\n adding symbol\n";
    // I->getType()->dump();
    symbolt symbol;
    symbol.name = I->getName().str();
    symbol.type = symbol_creator::create_type(I->getType());
    symbol_table.add(symbol);
  }
  symbolt result = symbol_table.lookup(I->getName().str());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  if (const LoadInst *li = dyn_cast<LoadInst>(*ub)) {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(li->getOperand(0)->getName().str());
  }
  if (const LoadInst *li = dyn_cast<LoadInst>(*(ub+1))) {
    li->getOperand(0)->dump();
    op2 = symbol_table.lookup(li->getOperand(0)->getName().str());
  }

  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
  add_inst->code = code_assignt(result.symbol_expr(),
    mod_exprt(op1.symbol_expr(), op2.symbol_expr()));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  // errs() << "\n      Instruction metadata is :";
  SmallVector<std::pair<unsigned, MDNode *>, 4> MDs;
  I->getAllMetadata(MDs);
  SmallVector<std::pair<unsigned, MDNode *>, 4>::iterator md = MDs.begin();
  source_locationt location;
  // errs() << md;
  // md->second->dump();
  if (dyn_cast<DILocation>(md->second)) {
    location.set_file(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)->getScope())
        ->getFile())->getFilename().str());
    location.set_working_directory(
      dyn_cast<DIFile>(
        dyn_cast<DISubprogram>(
          dyn_cast<DILocation>(md->second)
          ->getScope())->getFile())->getDirectory().str());
    location.set_line(dyn_cast<DILocation>(md->second)->getLine());
  }
  add_inst->source_location = location;
  add_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_FRem(const Instruction *I) {
  goto_programt gp;
  errs() << "FRem is yet to be mapped \n";
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
goto_programt llvm2goto_translator::trans_And(const Instruction *I) {
  goto_programt gp;
  errs() << "And is yet to be mapped \n";
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
goto_programt llvm2goto_translator::trans_Or(const Instruction *I) {
  goto_programt gp;
  errs() << "Or is yet to be mapped \n";
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
goto_programt llvm2goto_translator::trans_Xor(const Instruction *I) {
  goto_programt gp;
  errs() << "Xor is yet to be mapped \n";
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
  symbol.name = I->getName().str();
  symbol_table.add(symbol);
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
  // errs() << "Store is yet to be mapped \n";
  goto_programt gp;
  // errs() << " getOperand0 :";
  // dyn_cast<StoreInst>(I)->getOperand(0)->dump();
  // errs() << "\n value stored in of 1st operand"
  // << *dyn_cast<ConstantInt>(dyn_cast<StoreInst>(I)->getOperand(0))
  // ->getValue().getRawData();
  uint64_t val;
  if (dyn_cast<ConstantInt>(dyn_cast<StoreInst>(I)->getOperand(0))) {
    val = dyn_cast<ConstantInt>(
      dyn_cast<StoreInst>(I)->getOperand(0))->getZExtValue();
  } else {
    val = 0;
  }
  // errs() << "\n signed value stored in of 1st operand" <<
  // dyn_cast<ConstantInt>(dyn_cast<StoreInst>(I)->getOperand(0))
  // ->getSExtValue();
  // errs() << " getOperand1 :";
  // dyn_cast<StoreInst>(I)->getOperand(1)->dump();
  // errs() << " name getOperand1 :" << dyn_cast<StoreInst>(I)
  // ->getOperand(1)->getName();
  symbolt symbol = symbol_table.lookup(
    dyn_cast<StoreInst>(I)->getOperand(1)->getName().str());
  goto_programt::targett store_inst = gp.add_instruction();
  store_inst->make_assignment();
  store_inst->code = code_assignt(symbol.symbol_expr(),
    from_integer(val, symbol.type));
  store_inst->function = irep_idt(I->getFunction()->getName().str());
  // errs() << "\n      Instruction metadata is :";
  SmallVector<std::pair<unsigned, MDNode *>, 4> MDs;
  I->getAllMetadata(MDs);
  SmallVector<std::pair<unsigned, MDNode *>, 4>::iterator md = MDs.begin();
  source_locationt location;
  // errs() << md;
  // md->second->dump();
  if (dyn_cast<DILocation>(md->second)) {
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
  }
  store_inst->source_location = location;
  store_inst->type = goto_program_instruction_typet::ASSIGN;
  namespacet ns(symbol_table);
  // std::cout << "\n new function \n";
  // gp.output(std::cout);
  // std::cout << "\n";
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
  errs() << "AtomicCmpXchg is yet to be mapped \n";
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
  errs() << "AtomicRMW is yet to be mapped \n";
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
  errs() << "Fence is yet to be mapped \n";
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
  errs() << "GetElementPtr is yet to be mapped \n";
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
  errs() << "Trunc is yet to be mapped \n";
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
  errs() << "ZExt is yet to be mapped \n";
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
  errs() << "SExt is yet to be mapped \n";
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
  errs() << "FPTrunc is yet to be mapped \n";
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
  errs() << "FPExt is yet to be mapped \n";
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
  errs() << "FPToUI is yet to be mapped \n";
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
  errs() << "FPToSI is yet to be mapped \n";
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
  errs() << "UIToFP is yet to be mapped \n";
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
  errs() << "SIToFP is yet to be mapped \n";
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
  errs() << "IntToPtr is yet to be mapped \n";
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
  errs() << "PtrToInt is yet to be mapped \n";
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
  errs() << "BitCast is yet to be mapped \n";
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
  errs() << "AddrSpaceCast is yet to be mapped \n";
  return gp;
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
  errs() << "ICmp is yet to be mapped \n";
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
  errs() << "FCmp is yet to be mapped \n";
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
  errs() << "PHI is yet to be mapped \n";
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
  errs() << "Select is yet to be mapped \n";
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
    symbol_table->remove(dyn_cast<DIVariable>(mdn)->getName().str());

    // errs() << "\033[31;1m" << "DbgDeclareInst information :\n" << "\033[0m";
    switch (dyn_cast<PointerType>(dyn_cast<Type>(dbgDeclareInst->getAddress()
      ->getType()))->getPointerElementType()->getTypeID()) {
      // 16-bit floating point type
      case llvm::Type::TypeID::HalfTyID : {
        errs() << "\nHalf type";
        symbol_table->add(symbol_creator::create_HalfTy(type, mdn));
      }
      // 32-bit floating point type
      case llvm::Type::TypeID::FloatTyID : {
        errs() << "\nFloat type";
        symbol_table->add(symbol_creator::create_FloatTy(type, mdn));
        break;
      }
      // 64-bit floating point type
      case llvm::Type::TypeID::DoubleTyID : {
        symbol_table->add(symbol_creator::create_DoubleTy(type, mdn));
        errs() << "\nDouble type";
        break;
      }
      // 80-bit floating point type (X87)
      case llvm::Type::TypeID::X86_FP80TyID : {
        symbol_table->add(symbol_creator::create_X86_FP80Ty(type, mdn));
        errs() << "\nX86_FP80 type";
        break;
      }
      // 128-bit floating point type (112-bit mantissa)
      case llvm::Type::TypeID::FP128TyID : {
        symbol_table->add(symbol_creator::create_FP128Ty(type, mdn));
        errs() << "\nFP128 type";
        break;
      }
      // 128-bit floating point type (two 64-bits, PowerPC)
      case llvm::Type::TypeID::PPC_FP128TyID : {
        symbol_table->add(symbol_creator::create_PPC_FP128Ty(type, mdn));
        errs() << "\nPPC_FP128 type";
        break;
      }
      case llvm::Type::TypeID::IntegerTyID : {
        symbol_table->add(symbol_creator::create_IntegerTy(type, mdn));
        errs() << "\nInteger type";
        break;
      }
      case llvm::Type::TypeID::StructTyID : {
        // const MDNode *dit = dyn_cast<MDNode>(*mmd);
        symbol_table->add(symbol_creator::create_StructTy(type, mdn));
        errs() << "\nStruct type";
        break;
      }
      case llvm::Type::TypeID::ArrayTyID : {
        symbol_table->add(symbol_creator::create_ArrayTy(type, mdn));
        errs() << "\nArray type";
        break;
      }
      case llvm::Type::TypeID::PointerTyID : {
        symbol_table->add(symbol_creator::create_PointerTy(type, mdn));
        errs() << "\nPointer type";
        break;
      }
      case llvm::Type::TypeID::VectorTyID : {
        symbol_table->add(symbol_creator::create_VectorTy(type, mdn));
        errs() << "\nVector type";
        break;
      }
      case llvm::Type::TypeID::X86_MMXTyID : {
        symbol_table->add(symbol_creator::create_X86_MMXTy(type, mdn));
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
  errs() << "Shl is yet to be mapped \n";
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
  errs() << "LShr is yet to be mapped \n";
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
  errs() << "AShr is yet to be mapped \n";
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
  errs() << "VAArg is yet to be mapped \n";
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
  errs() << "ExtractElement is yet to be mapped \n";
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
  errs() << "InsertElement is yet to be mapped \n";
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
  errs() << "ShuffleVector is yet to be mapped \n";
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
  errs() << "ExtractValue is yet to be mapped \n";
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
  errs() << "InsertValue is yet to be mapped \n";
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
  errs() << "LandingPad is yet to be mapped \n";
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
  errs() << "CleanupPad is yet to be mapped \n";
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
  // TODO(Rasika): struct, vector, array,...
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
                  symbol_table.add(symbol_creator::create_HalfTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd)));
                }
                // 32-bit floating point type
                case llvm::Type::TypeID::FloatTyID : {
                  errs() << "\nFloat type";
                  symbol_table.add(symbol_creator::create_FloatTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd)));
                  break;
                }
                // 64-bit floating point type
                case llvm::Type::TypeID::DoubleTyID : {
                  symbol_table.add(symbol_creator::create_DoubleTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd)));
                  errs() << "\nDouble type";
                  break;
                }
                // 80-bit floating point type (X87)
                case llvm::Type::TypeID::X86_FP80TyID : {
                  symbol_table.add(symbol_creator::create_X86_FP80Ty(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd)));
                  errs() << "\nX86_FP80 type";
                  break;
                }
                // 128-bit floating point type (112-bit mantissa)
                case llvm::Type::TypeID::FP128TyID : {
                  symbol_table.add(symbol_creator::create_FP128Ty(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd)));
                  errs() << "\nFP128 type";
                  break;
                }
                // 128-bit floating point type (two 64-bits, PowerPC)
                case llvm::Type::TypeID::PPC_FP128TyID : {
                  symbol_table.add(symbol_creator::create_PPC_FP128Ty(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd)));
                  errs() << "\nPPC_FP128 type";
                  break;
                }
                case llvm::Type::TypeID::IntegerTyID : {
                  symbol_table.add(symbol_creator::create_IntegerTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd)));
                  errs() << "\nInteger type";
                  break;
                }
                case llvm::Type::TypeID::StructTyID : {
                  const MDNode *dit = dyn_cast<MDNode>(*mmd);
                  symbol_table.add(symbol_creator::create_StructTy(
                    GV.getValueType(),
                    dit));
                  errs() << "\nStruct type";
                  break;
                }
                case llvm::Type::TypeID::ArrayTyID : {
                  symbol_table.add(symbol_creator::create_ArrayTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd)));
                  errs() << "\nArray type";
                  break;
                }
                case llvm::Type::TypeID::PointerTyID : {
                  symbol_table.add(symbol_creator::create_PointerTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd)));
                  errs() << "\nPointer type";
                  break;
                }
                case llvm::Type::TypeID::VectorTyID : {
                  symbol_table.add(symbol_creator::create_VectorTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd)));
                  errs() << "\nVector type";
                  break;
                }
                case llvm::Type::TypeID::X86_MMXTyID : {
                  symbol_table.add(symbol_creator::create_X86_MMXTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd)));
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
  symbol_tablet *symbol_table) {
  errs() << "\n\t\t\tin trans_instruction\n\t\t\t\t";
  const Instruction *Inst = &I;
  goto_programt gp;
  switch (I.getOpcode()) {
    // Terminators
    case Instruction::Ret : {
      goto_programt ret_gp = trans_Ret(Inst);
        gp.destructive_append(ret_gp);
        break;
      }
    case Instruction::Br : {
        gp = trans_Br(Inst);
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
        gp = trans_FAdd(Inst);
        break;
      }
    case Instruction::Sub : {
        goto_programt sub_ins = trans_Sub(Inst, *symbol_table);
        gp.destructive_append(sub_ins);
        break;
      }
    case Instruction::FSub : {
        gp = trans_FSub(Inst);
        break;
      }
    case Instruction::Mul : {
        goto_programt mul_ins = trans_Mul(Inst, *symbol_table);
        gp.destructive_append(mul_ins);
        break;
      }
    case Instruction::FMul : {
        gp = trans_FMul(Inst);
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
        gp = trans_FDiv(Inst);
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
        gp = trans_FRem(Inst);
        break;
      }

    // Logical operators...
    case Instruction::And : {
        gp = trans_And(Inst);
        break;
      }
    case Instruction::Or : {
        gp = trans_Or(Inst);
        break;
      }
    case Instruction::Xor : {
        gp = trans_Xor(Inst);
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
        gp = trans_ICmp(Inst);
        break;
      }
    case Instruction::FCmp : {
        gp = trans_FCmp(Inst);
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
        gp = trans_Call(Inst, symbol_table);
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
  symbol_tablet *symbol_table) {
  // TODO(Rasika): use code_blockt
  errs() << "\t\tin trans_Block\n";
  goto_programt gp;
  // register_language(new_ansi_c_language);
  for (BasicBlock::const_iterator i = b.begin(),
    ie = b.end(); i != ie; ++i) {
      // const Instruction &inst = *i;
      // i -> dump();
      goto_programt goto_instr = trans_instruction(*i, symbol_table);
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
  errs() << "\tin trans_Function\n";
  for (Function::const_iterator b = F.begin(), be = F.end(); b != be; ++b) {
    const BasicBlock &B = *b;
    goto_programt goto_block = trans_Block(B, symbol_table);
    gp.destructive_append(goto_block);
    gp.update();
  }
  gp.add_instruction(END_FUNCTION);
  gp.update();
  // namespacet ns(*symbol_table);

  // register_language(new_ansi_c_language);
  // gp.output(std::cout);
  // std::cout << "\n...............................................\n";
  // errs() << "\tin trans_Function\n";
  return gp;
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
goto_functionst llvm2goto_translator::trans_Program(Module *Mod) {
  // TODO(Rasika): check for presence of function body
  Module &M = *Mod;
  // errs() << "in trans_Program\n";
  goto_functionst goto_functions;
  // goto_functionst::goto_functiont goto_function;
  symbol_tablet symbol_table = trans_Globals(Mod);
  // symbol_table.show(std::cout);
  goto_programt gp;
  for (Function &F : M) {
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
    symbol_table.add(fn);
    goto_functions.function_map.insert(
      std::pair<const dstringt, goto_functionst::goto_functiont >(
        dstringt(F.getName()),
        goto_functionst::goto_functiont()));
    goto_programt func_gp = trans_Function(F, &symbol_table);
    // func_gp.ns = namespacet(symbol_table);
    gp.destructive_append(func_gp);
    (*goto_functions.function_map.find(dstringt(F.getName()))).
    second.body.swap(gp);
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
