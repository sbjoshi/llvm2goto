/* Copyright
Author : Rasika

*/

#include "llvm2goto_translator.h"

#include <llvm/IR/Type.h>
#include "llvm/ADT/APFloat.h"

#include <utility>
#include <memory>
#include <string>
#include <map>

#include "symbol_creator.h"
#include "entry_point.h"
#include "scope.h"

#include "llvm/IR/IntrinsicInst.h"
#include "langapi/mode.h"
#include "solvers/cvc/cvc_conv.h"
#include "ansi-c/ansi_c_language.h"
#include "util/cmdline.h"
#include "goto-cc/compile.h"
#include "util/ieee_float.h"
#include "util/simplify_expr_class.h"

using namespace llvm;

// TODO(Rasika): handle signed comparison.

llvm2goto_translator::llvm2goto_translator(Module *M)
{
    this->M = M;
}

llvm2goto_translator::~llvm2goto_translator()
{
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
  const symbol_tablet &symbol_table)
{
  // assert(false);
  goto_programt gp;
  Value *ub = dyn_cast<ReturnInst>(I)->getReturnValue();
  symbolt op1;
  exprt exprt1;
  // TODO(Rasika): handle other constant type.
  if(dyn_cast<Constant>(ub))
  {
    if(const ConstantInt *cint = dyn_cast<ConstantInt>(ub))
    {
      uint64_t val;
      val = cint->getZExtValue();
      exprt1 = from_integer(val, symbol_creator::create_type(ub->getType()));
    }
    else if(dyn_cast<ConstantFP>(ub))
    {
        errs() << "ConstantFP";
        Type *floattype = dyn_cast<Type>((ub)->getType());
        if(floattype->isFloatTy())
        {
          float val = dyn_cast<ConstantFP>(ub)->getValueAPF().convertToFloat();
          ieee_floatt ieee_fl = ieee_floatt();
          ieee_fl.from_float(val);
          exprt1 = ieee_fl.to_expr();
        }
        else if(floattype->isDoubleTy())
        {
          float val = dyn_cast<ConstantFP>(ub)->getValueAPF().convertToDouble();
          ieee_floatt ieee_fl = ieee_floatt();
          ieee_fl.from_double(val);
          exprt1 = ieee_fl.to_expr();
        }
        else
        {
          ub->dump();
          assert(false
            && "This floating point type in above instruction is not handled");
        }
    }
    else
    {
      ub->dump();
      assert(false && "This constant type in above instruction is not handled");
    }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(ub))
    {
      op1 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
          op1 = symbol_table.lookup(var_name_map.find(
            ub->getName().str())->second);
          if(&(dyn_cast<Instruction>(ub)->getDebugLoc()) != NULL)
          {
            const DebugLoc loc = dyn_cast<Instruction>(ub)->getDebugLoc();
            std::string name = scope_name_map.find(loc->getScope())->second;
            op1 = symbol_table.lookup(name);
          }
    }
    exprt1 = op1.symbol_expr();
  }
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
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
  &instruction_target_map)
{
  goto_programt gp;
  I->dump();
  if(dyn_cast<BranchInst>(I)->getNumSuccessors() == 2)
  {
    goto_programt::targett br_ins = gp.add_instruction();
    instruction_target_map.insert(std::pair<const Instruction*,
      goto_programt::targett>(I, br_ins));
    gp.update();
  }
  else
  {
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
goto_programt llvm2goto_translator::trans_Switch(const Instruction *I,
  std::map <const BasicBlock*, goto_programt::targett>
    &dest_block_branch_map_switch,
  symbol_tablet &symbol_table)
{
  goto_programt gp;
  Value *ub = dyn_cast<SwitchInst>(I)->getCondition();
  symbolt var;
  exprt var_expr;
  if(const LoadInst *li = dyn_cast<LoadInst>(ub))
  {
    var = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
  }
  else
  {
    var = symbol_table.lookup(var_name_map.find(
      ub->getName().str())->second);
    if(&(dyn_cast<Instruction>(ub)->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = dyn_cast<Instruction>(ub)->getDebugLoc();
      std::string name = scope_name_map.find(loc->getScope())->second;
      var = symbol_table.lookup(name);
      assert(false);
    }
  }
  var_expr = var.symbol_expr();


  for(auto i=dyn_cast<SwitchInst>(I)->case_begin();
    i!=dyn_cast<SwitchInst>(I)->case_end(); i++)
  {
    goto_programt::targett br_ins = gp.add_instruction();
    dest_block_branch_map_switch.insert(
      std::pair<const BasicBlock*, goto_programt::targett>(
        i->getCaseSuccessor(), br_ins));
    br_ins->make_goto();
    br_ins->guard = equal_exprt(var_expr,
      from_integer(i->getCaseValue()->getZExtValue(),
        symbol_creator::create_type(ub->getType())));
  }
  goto_programt::targett default_branch = gp.add_instruction();
  dest_block_branch_map_switch.insert(
    std::pair<const BasicBlock*, goto_programt::targett>(
      dyn_cast<SwitchInst>(I)->getDefaultDest(), default_branch));
  default_branch->make_goto();
  default_branch->guard = true_exprt();
  gp.update();
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
goto_programt llvm2goto_translator::trans_IndirectBr(const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_Invoke(const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_Resume(const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_Unreachable(const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_CleanupRet(const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_CatchRet(const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_CatchPad(const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_CatchSwitch(const Instruction *I)
{
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
  symbol_tablet &symbol_table)
{
  // Operands can be constant integer or a load instruction.
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  int flag = 2;
  if(dyn_cast<ConstantInt>(*ub))
  {
    flag = 1;
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(dyn_cast<ConstantInt>(*(ub+1)))
  {
    flag = 0;
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
    std::cout << exprt2.pretty();
  }
  if(exprt2.type().id() == ID_signedbv && flag == 1)
  {
    uint64_t val = dyn_cast<ConstantInt>(*(ub))->getSExtValue();
    typet type = exprt2.type();
    exprt1 = from_integer(val, type);
  }
  if(exprt1.type().id() == ID_signedbv && flag == 0)
  {
    uint64_t val = dyn_cast<ConstantInt>(*(ub+1))->getSExtValue();
    typet type = exprt1.type();
    exprt2 = from_integer(val, type);
  }
  if(exprt2.type().id() == ID_unsignedbv && flag == 1)
  {
    uint64_t val = dyn_cast<ConstantInt>(*(ub))->getZExtValue();
    typet type = exprt2.type();
    exprt1 = from_integer(val, type);
  }
  if(exprt1.type().id() == ID_unsignedbv && flag == 0)
  {
    uint64_t val = dyn_cast<ConstantInt>(*(ub+1))->getZExtValue();
    typet type = exprt1.type();
    exprt2 = from_integer(val, type);
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    // errs() << scope_name_map.find(I->getDebugLoc()->getScope())->second;
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);

  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
  // Add instruction in llvm becomes an assignment statement in goto,
  // with a symbol on LHS and plus_exprt on RHS.
  add_inst->code = code_assignt(result.symbol_expr(),
    plus_exprt(exprt1, exprt2));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
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
  symbol_tablet &symbol_table)
{
  goto_programt gp;
  // Operands can be constant of one of the six floating point types or
  // a load instruction.
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(dyn_cast<ConstantFP>(*ub))
  {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((*ub)->getType());
      if(floattype->isFloatTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      }
      else if(floattype->isDoubleTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      }
      else
      {
        ub->dump();
        assert(false
          && "This floating point type in above instruction is not handled");
      }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(dyn_cast<ConstantFP>(*(ub+1)))
  {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub+1))->getType());
    if(floattype->isFloatTy())
    {
      float val = dyn_cast<ConstantFP>(
        *(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_float(val);
      exprt2 = ieee_fl.to_expr();
    }
    else if(floattype->isDoubleTy())
    {
      float val = dyn_cast<ConstantFP>(
        *(ub+1))->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_double(val);
      exprt2 = ieee_fl.to_expr();
    }
    else
    {
      (ub+1)->dump();
      assert(false
        && "This floating point type in above instruction is not handled");
    }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  // Symbol corresponding to the value in which result of llvm instruction
  // is stored, might have been created in goto symbol table earlier. If so,
  // it is used otherwise new symbol is created. And added to the symbol table.
  // try {
  //   symbol_table.lookup(
  // I->getFunction()->getName().str() + "::" + I->getName().str());
  // } catch(std::__cxx11::basic_string<char, std::char_traits<char>,
  //   std::allocator<char> > msg)
  // {
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(
      I->getDebugLoc()->getScope()->getNonLexicalBlockFileScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);
  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
  // Add instruction in llvm becomes an assignment statement in goto,
  // with a symbol on LHS and plus_exprt on RHS.
  add_inst->code = code_assignt(result.symbol_expr(),
    plus_exprt(exprt1, exprt2));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
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
  symbol_tablet &symbol_table)
{
  // Operands can be constant integer or a load instruction.
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  int flag = 2;
  if(dyn_cast<ConstantInt>(*ub))
  {
    flag = 1;
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(dyn_cast<ConstantInt>(*(ub+1)))
  {
    flag = 0;
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
    std::cout << exprt2.pretty();
  }
  if(exprt2.type().id() == ID_signedbv && flag == 1)
  {
    uint64_t val = dyn_cast<ConstantInt>(*(ub))->getSExtValue();
    typet type = exprt2.type();
    exprt1 = from_integer(val, type);
  }
  if(exprt1.type().id() == ID_signedbv && flag == 0)
  {
    uint64_t val = dyn_cast<ConstantInt>(*(ub+1))->getSExtValue();
    typet type = exprt1.type();
    exprt2 = from_integer(val, type);
  }
  if(exprt2.type().id() == ID_unsignedbv && flag == 1)
  {
    uint64_t val = dyn_cast<ConstantInt>(*(ub))->getZExtValue();
    typet type = exprt2.type();
    exprt1 = from_integer(val, type);
  }
  if(exprt1.type().id() == ID_unsignedbv && flag == 0)
  {
    uint64_t val = dyn_cast<ConstantInt>(*(ub+1))->getZExtValue();
    typet type = exprt1.type();
    exprt2 = from_integer(val, type);
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);

  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
  // Add instruction in llvm becomes an assignment statement in goto,
  // with a symbol on LHS and minus_exprt on RHS.
  add_inst->code = code_assignt(result.symbol_expr(),
    minus_exprt(exprt1, exprt2));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
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
goto_programt llvm2goto_translator::trans_FSub(const Instruction *I,
  symbol_tablet &symbol_table)
{
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(dyn_cast<ConstantFP>(*ub))
  {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((*ub)->getType());
      if(floattype->isFloatTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      }
      else if(floattype->isDoubleTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      }
      else
      {
        ub->dump();
        assert(false
          && "This floating point type in above instruction is not handled");
      }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(dyn_cast<ConstantFP>(*(ub+1)))
  {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub+1))->getType());
    if(floattype->isFloatTy())
    {
      float val = dyn_cast<ConstantFP>(
        *(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_float(val);
      exprt2 = ieee_fl.to_expr();
    }
    else if(floattype->isDoubleTy())
    {
      float val = dyn_cast<ConstantFP>(
        *(ub+1))->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_double(val);
      exprt2 = ieee_fl.to_expr();
    }
    else
    {
      (ub+1)->dump();
      assert(false
        && "This floating point type in above instruction is not handled");
    }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(
      dyn_cast<DIScope>(
        I->getDebugLoc()->getScope()->getNonLexicalBlockFileScope()))->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);
  goto_programt::targett fsub_inst = gp.add_instruction();
  fsub_inst->make_assignment();
  fsub_inst->code = code_assignt(result.symbol_expr(),
    minus_exprt(exprt1, exprt2));
  fsub_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
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
  symbol_tablet &symbol_table)
{
  // Operands can be constant integer or a load instruction.
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  int flag = 2;
  if(dyn_cast<ConstantInt>(*ub))
  {
    flag = 1;
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(dyn_cast<ConstantInt>(*(ub+1)))
  {
    flag = 0;
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
    std::cout << exprt2.pretty();
  }
  if(exprt2.type().id() == ID_signedbv && flag == 1)
  {
    uint64_t val = dyn_cast<ConstantInt>(*(ub))->getSExtValue();
    typet type = exprt2.type();
    exprt1 = from_integer(val, type);
  }
  if(exprt1.type().id() == ID_signedbv && flag == 0)
  {
    uint64_t val = dyn_cast<ConstantInt>(*(ub+1))->getSExtValue();
    typet type = exprt1.type();
    exprt2 = from_integer(val, type);
  }
  if(exprt2.type().id() == ID_unsignedbv && flag == 1)
  {
    uint64_t val = dyn_cast<ConstantInt>(*(ub))->getZExtValue();
    typet type = exprt2.type();
    exprt1 = from_integer(val, type);
  }
  if(exprt1.type().id() == ID_unsignedbv && flag == 0)
  {
    uint64_t val = dyn_cast<ConstantInt>(*(ub+1))->getZExtValue();
    typet type = exprt1.type();
    exprt2 = from_integer(val, type);
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);

  goto_programt::targett add_inst = gp.add_instruction();
  add_inst->make_assignment();
  // Add instruction in llvm becomes an assignment statement in goto,
  // with a symbol on LHS and mult_exprt on RHS.
  add_inst->code = code_assignt(result.symbol_expr(),
    mult_exprt(exprt1, exprt2));
  add_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
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
goto_programt llvm2goto_translator::trans_FMul(const Instruction *I,
  symbol_tablet &symbol_table)
{
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(dyn_cast<ConstantFP>(*ub))
  {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((*ub)->getType());
      if(floattype->isFloatTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      }
      else if(floattype->isDoubleTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      }
      else
      {
        ub->dump();
        assert(false
          && "This floating point type in above instruction is not handled");
      }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(dyn_cast<ConstantFP>(*(ub+1)))
  {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub+1))->getType());
    if(floattype->isFloatTy())
    {
      float val = dyn_cast<ConstantFP>(
        *(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_float(val);
      exprt2 = ieee_fl.to_expr();
    }
    else if(floattype->isDoubleTy())
    {
      float val = dyn_cast<ConstantFP>(
        *(ub+1))->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_double(val);
      exprt2 = ieee_fl.to_expr();
    }
    else
    {
      (ub+1)->dump();
      assert(false
        && "This floating point type in above instruction is not handled");
    }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(dyn_cast<DIScope>(
      I->getDebugLoc()->getScope()->getNonLexicalBlockFileScope()))->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);
  goto_programt::targett fmul_inst = gp.add_instruction();
  fmul_inst->make_assignment();
  fmul_inst->code = code_assignt(result.symbol_expr(),
    mult_exprt(exprt1, exprt2));
  fmul_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
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
  symbol_tablet &symbol_table)
{
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1)))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);

  goto_programt::targett udiv_inst = gp.add_instruction();
  udiv_inst->make_assignment();
  udiv_inst->code = code_assignt(result.symbol_expr(),
    div_exprt(exprt1, exprt2));
  udiv_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
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
  symbol_tablet &symbol_table)
{
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getSExtValue();
    exprt1 = from_integer(val, signedbv_typet(
      I->getType()->getIntegerBitWidth()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1)))
  {
    uint64_t val;
    val = cint->getSExtValue();
    exprt2 = from_integer(val, signedbv_typet(
      I->getType()->getIntegerBitWidth()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);

  goto_programt::targett sdiv_inst = gp.add_instruction();
  sdiv_inst->make_assignment();
  sdiv_inst->code = code_assignt(result.symbol_expr(),
    div_exprt(exprt1, exprt2));
  sdiv_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
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
  symbol_tablet &symbol_table)
{
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(dyn_cast<ConstantFP>(*ub))
  {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((*ub)->getType());
      if(floattype->isFloatTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      }
      else if(floattype->isDoubleTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      }
      else
      {
        ub->dump();
        assert(false
          && "This floating point type in above instruction is not handled");
      }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(dyn_cast<ConstantFP>(*(ub+1)))
  {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub+1))->getType());
    if(floattype->isFloatTy())
    {
      float val = dyn_cast<ConstantFP>(
        *(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_float(val);
      exprt2 = ieee_fl.to_expr();
    }
    else if(floattype->isDoubleTy())
    {
      float val = dyn_cast<ConstantFP>(
        *(ub+1))->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_double(val);
      exprt2 = ieee_fl.to_expr();
    }
    else
    {
      (ub+1)->dump();
      assert(false
        && "This floating point type in above instruction is not handled");
    }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);
  goto_programt::targett fdiv_inst = gp.add_instruction();
  fdiv_inst->make_assignment();
  fdiv_inst->code = code_assignt(result.symbol_expr(),
    div_exprt(exprt1, exprt2));
  fdiv_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
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
  symbol_tablet &symbol_table)
{
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1)))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);

  goto_programt::targett urem_inst = gp.add_instruction();
  urem_inst->make_assignment();
  urem_inst->code = code_assignt(result.symbol_expr(),
    mod_exprt(exprt1, exprt2));
  urem_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
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
  symbol_tablet &symbol_table)
{
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getSExtValue();
    exprt1 = from_integer(val,
      signedbv_typet(I->getType()->getIntegerBitWidth()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1)))
  {
    uint64_t val;
    val = cint->getSExtValue();
    exprt2 = from_integer(val,
      signedbv_typet(I->getType()->getIntegerBitWidth()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);

  goto_programt::targett srem_inst = gp.add_instruction();
  srem_inst->make_assignment();
  srem_inst->code = code_assignt(result.symbol_expr(),
    mod_exprt(exprt1, exprt2));
  srem_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
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
  symbol_tablet &symbol_table)
{
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(dyn_cast<ConstantFP>(*ub))
  {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((*ub)->getType());
      if(floattype->isFloatTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      }
      else if(floattype->isDoubleTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      }
      else
      {
        ub->dump();
        assert(false
          && "This floating point type in above instruction is not handled");
      }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(dyn_cast<ConstantFP>(*(ub+1)))
  {
    errs() << "ConstantFP";
    Type *floattype = dyn_cast<Type>((*(ub+1))->getType());
    if(floattype->isFloatTy())
    {
      float val = dyn_cast<ConstantFP>(
        *(ub+1))->getValueAPF().convertToFloat();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_float(val);
      exprt2 = ieee_fl.to_expr();
    }
    else if(floattype->isDoubleTy())
    {
      float val = dyn_cast<ConstantFP>(
        *(ub+1))->getValueAPF().convertToDouble();
      ieee_floatt ieee_fl = ieee_floatt();
      ieee_fl.from_double(val);
      exprt2 = ieee_fl.to_expr();
    }
    else
    {
      (ub+1)->dump();
      assert(false
        && "This floating point type in above instruction is not handled");
    }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);
  goto_programt::targett frem_inst = gp.add_instruction();
  frem_inst->make_assignment();
  frem_inst->code = code_assignt(result.symbol_expr(),
    mod_exprt(exprt1, exprt2));
  frem_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
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
  symbol_tablet &symbol_table)
{
  // Operands can be constant integer or a load instruction.
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1)))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  // Symbol corresponding to the value in which result of llvm instruction
  // is stored, might have been created in goto symbol table earlier. If so,
  // it is used otherwise new symbol is created. And added to the symbol table.
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);

  goto_programt::targett and_inst = gp.add_instruction();
  and_inst->make_assignment();
  // Add instruction in llvm becomes an assignment statement in goto,
  // with a symbol on LHS and bitand_exprt on RHS.
  and_inst->code = code_assignt(result.symbol_expr(),
    bitand_exprt(exprt1, exprt2));
  and_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  and_inst->source_location = location;
  and_inst->type = goto_program_instruction_typet::ASSIGN;
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
  symbol_tablet &symbol_table)
{
  // Operands can be constant integer or a load instruction.
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1)))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  // Symbol corresponding to the value in which result of llvm instruction
  // is stored, might have been created in goto symbol table earlier. If so,
  // it is used otherwise new symbol is created. And added to the symbol table.
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);

  goto_programt::targett or_inst = gp.add_instruction();
  or_inst->make_assignment();
  // Add instruction in llvm becomes an assignment statement in goto,
  // with a symbol on LHS and bitor_exprt on RHS.
  or_inst->code = code_assignt(result.symbol_expr(),
    bitor_exprt(exprt1, exprt2));
  or_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  or_inst->source_location = location;
  or_inst->type = goto_program_instruction_typet::ASSIGN;
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
  symbol_tablet &symbol_table)
{
  // Operands can be constant integer or a load instruction.
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1)))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  // Symbol corresponding to the value in which result of llvm instruction
  // is stored, might have been created in goto symbol table earlier. If so,
  // it is used otherwise new symbol is created. And added to the symbol table.
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);

  goto_programt::targett xor_inst = gp.add_instruction();
  xor_inst->make_assignment();
  // Add instruction in llvm becomes an assignment statement in goto,
  // with a symbol on LHS and bitxor_exprt on RHS.
  xor_inst->code = code_assignt(result.symbol_expr(),
    bitxor_exprt(exprt1, exprt2));
  xor_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  xor_inst->source_location = location;
  xor_inst->type = goto_program_instruction_typet::ASSIGN;
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
  symbol_tablet &symbol_table)
{
  goto_programt gp;
  symbolt symbol;
  symbol.type = symbol_creator::create_type(
    dyn_cast<AllocaInst>(I)->getAllocatedType());
  symbol.base_name = I->getName().str();
  symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
  symbol_table.add(symbol);
  var_name_map.insert(std::pair<std::string, std::string>(
    I->getName().str(), symbol.name.c_str()));
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
goto_programt llvm2goto_translator::trans_Load(const Instruction *I)
{
  goto_programt gp;
  errs() << "Load is yet to be mapped \n";
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
  const symbol_tablet &symbol_table)
{
  goto_programt gp;
  symbolt symbol = symbol_table.lookup(var_name_map.find(
    dyn_cast<StoreInst>(I)->getOperand(1)->getName().str())->second);
  exprt value_to_store;
  for(auto arg = I->getFunction()->arg_begin();
    arg != I->getFunction()->arg_end(); arg++)
  {
    if(dyn_cast<StoreInst>(I)->getOperand(0)->getName() == arg->getName())
    {
      // assert(false && "found parameters");
      return gp;
    }
  }
  if(dyn_cast<Constant>(dyn_cast<StoreInst>(I)->getOperand(0)))
  {
    if(dyn_cast<ConstantInt>(dyn_cast<StoreInst>(I)->getOperand(0)))
    {
      uint64_t val = dyn_cast<ConstantInt>(
      dyn_cast<StoreInst>(I)->getOperand(0))->getZExtValue();
      value_to_store = from_integer(val, symbol.type);
    }
    else if(dyn_cast<ConstantFP>(dyn_cast<StoreInst>(I)->getOperand(0)))
    {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>(
        dyn_cast<StoreInst>(I)->getOperand(0)->getType());
      if(floattype->isFloatTy())
      {
        float val = dyn_cast<ConstantFP>(
          dyn_cast<StoreInst>(I)->getOperand(0))->
        getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        value_to_store = ieee_fl.to_expr();
      }
      else if(floattype->isDoubleTy())
      {
        float val = dyn_cast<ConstantFP>(
          dyn_cast<StoreInst>(I)->getOperand(0))->getValueAPF().
        convertToDouble();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        value_to_store = ieee_fl.to_expr();
      }
      else
      {
        I->dump();
        assert(false
          && "This floating point type in above instruction is not handled");
      }
    }
    else
    {
      I->dump();
      assert(false && "This constant type is not handled");
    }
  }
  else
  {
    if(dyn_cast<StoreInst>(I)->getOperand(0)->hasName())
    {
      errs() << dyn_cast<StoreInst>(I)->getOperand(0)->getName();
      errs() << "searrching " <<
        dyn_cast<StoreInst>(I)->getOperand(0)->getName() << "\n";
      value_to_store = symbol_table.lookup(var_name_map.find(
        dyn_cast<StoreInst>(I)->getOperand(0)->getName().
        str())->second).symbol_expr();
    }
    else if(dyn_cast<LoadInst>(dyn_cast<StoreInst>(I)->getOperand(0)))
    {
      std::string name = var_name_map.find(
        dyn_cast<LoadInst>(dyn_cast<StoreInst>(I)->getOperand(0))
        ->getOperand(0)->getName().str())->second;
      value_to_store = symbol_table.lookup(name).symbol_expr();
    }
  }
  goto_programt::targett store_inst = gp.add_instruction();
  store_inst->make_assignment();
  store_inst->code = code_assignt(symbol.symbol_expr(), value_to_store);
  store_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  store_inst->source_location = location;
  store_inst->type = goto_program_instruction_typet::ASSIGN;
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
  const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_AtomicRMW(const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_Fence(const Instruction *I)
{
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
  const Instruction *I, symbol_tablet &symbol_table)
{
  goto_programt gp;
  std::string name_of_composite_var
    = dyn_cast<GetElementPtrInst>(I)->getPointerOperand()->getName();
  std::string comp_var_full_name = var_name_map.find(
    name_of_composite_var)->second;
  symbolt comp = symbol_table.lookup(comp_var_full_name);
  // errs() << var_name_map.find(dyn_cast<GetElementPtrInst>(I)
  // ->getPointerOperand()->getName())->second << "\n";
  int index = 0;
  for(auto i=dyn_cast<GetElementPtrInst>(I)->idx_begin();
    i!=dyn_cast<GetElementPtrInst>(I)->idx_end(); i++)
  {
  // errs() << "................";
  //   dyn_cast<Value>(i)->dump();
    index = dyn_cast<ConstantInt>(i)->getZExtValue();
  }
  errs() << (
    to_struct_union_type(comp.type).components())[index].get_name().c_str();
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = (to_struct_union_type(comp.type).components())[index].type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    // decl_add->source_location = location;
  }
  member_exprt member(
    symbol_table.lookup(var_name_map.find(
      dyn_cast<GetElementPtrInst>(I)->getPointerOperand()
      ->getName())->second).symbol_expr(),
    (to_struct_union_type(comp.type).components())[index].get_name());
  goto_programt::targett assgn_inst = gp.add_instruction();
  assgn_inst->make_assignment();
  std::string full_name = var_name_map.find(I->getName().str())->second;
  assgn_inst->code = code_assignt(symbol_table.lookup(full_name).symbol_expr(),
    member);
  assgn_inst->function = irep_idt(I->getFunction()->getName().str());
  assgn_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_Trunc(const Instruction *I,
  symbol_tablet &symbol_table)
{
  assert(!dyn_cast<TruncInst>(I)->isLosslessCast()
    && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type = unsignedbv_typet(
    dyn_cast<TruncInst>(I)->getDestTy()->getIntegerBitWidth());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1;
  exprt exprt1;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
          li->getOperand(0)->dump();
      op1 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
          op1 = symbol_table.lookup(var_name_map.find(
            ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);
  goto_programt::targett trunc_inst = gp.add_instruction();
  trunc_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  trunc_inst->code = code_assignt(result.symbol_expr(), tce);
  trunc_inst->function = irep_idt(I->getFunction()->getName().str());
  trunc_inst->source_location = location;
  trunc_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_ZExt(const Instruction *I,
  symbol_tablet &symbol_table)
{
  assert(!dyn_cast<ZExtInst>(I)->isLosslessCast()
    && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type = unsignedbv_typet(
    dyn_cast<ZExtInst>(I)->getDestTy()->getIntegerBitWidth());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1;
  exprt exprt1;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
          li->getOperand(0)->dump();
      op1 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
          op1 = symbol_table.lookup(var_name_map.find(
            ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = dest_type;
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);
  goto_programt::targett zext_inst = gp.add_instruction();
  zext_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  zext_inst->code = code_assignt(result.symbol_expr(), tce);
  zext_inst->function = irep_idt(I->getFunction()->getName().str());
  zext_inst->source_location = location;
  zext_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_SExt(const Instruction *I,
  symbol_tablet &symbol_table)
{
  assert(!dyn_cast<SExtInst>(I)->isLosslessCast()
    && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type = signedbv_typet(
    dyn_cast<SExtInst>(I)->getDestTy()->getIntegerBitWidth());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1;
  exprt exprt1;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
          li->getOperand(0)->dump();
      op1 = symbol_table.lookup(var_name_map.find(
        I->getOperand(0)->getName().str())->second);
    }
    else
    {
          op1 = symbol_table.lookup(var_name_map.find(
            ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);
  goto_programt::targett zext_inst = gp.add_instruction();
  zext_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  zext_inst->code = code_assignt(result.symbol_expr(), tce);
  zext_inst->function = irep_idt(I->getFunction()->getName().str());
  zext_inst->source_location = location;
  zext_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_FPTrunc(const Instruction *I,
  symbol_tablet &symbol_table)
{
  assert(!dyn_cast<FPTruncInst>(I)->isLosslessCast()
    && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type = symbol_creator::create_type(
    dyn_cast<FPTruncInst>(I)->getDestTy());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1;
  exprt exprt1;
  if(dyn_cast<ConstantFP>(*ub))
  {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((*ub)->getType());
      if(floattype->isFloatTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      }
      else if(floattype->isDoubleTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      }
      else
      {
        ub->dump();
        assert(false
          && "This floating point type in above instruction is not handled");
      }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);
  goto_programt::targett fptrunc_inst = gp.add_instruction();
  fptrunc_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  fptrunc_inst->code = code_assignt(result.symbol_expr(), tce);
  fptrunc_inst->function = irep_idt(I->getFunction()->getName().str());
  fptrunc_inst->source_location = location;
  fptrunc_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_FPExt(const Instruction *I,
  symbol_tablet &symbol_table)
{
  assert(!dyn_cast<FPExtInst>(I)->isLosslessCast()
    && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type = symbol_creator::create_type(
    dyn_cast<FPExtInst>(I)->getDestTy());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1;
  exprt exprt1;
  if(dyn_cast<ConstantFP>(*ub))
  {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((*ub)->getType());
      floattype->dump();
      if(floattype->isFloatTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      }
      else if(floattype->isDoubleTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      }
      else
      {
        ub->dump();
        assert(false
          && "This floating point type in above instruction is not handled");
      }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);
  goto_programt::targett fpext_inst = gp.add_instruction();
  fpext_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  fpext_inst->code = code_assignt(result.symbol_expr(), tce);
  fpext_inst->function = irep_idt(I->getFunction()->getName().str());
  fpext_inst->source_location = location;
  fpext_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_FPToUI(const Instruction *I,
  symbol_tablet &symbol_table)
{
  assert(!dyn_cast<FPToUIInst>(I)->isLosslessCast()
    && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type = unsignedbv_typet(
    dyn_cast<FPToUIInst>(I)->getDestTy()->getIntegerBitWidth());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1;
  exprt exprt1;
  if(dyn_cast<ConstantFP>(*ub))
  {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((*ub)->getType());
      if(floattype->isFloatTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      }
      else if(floattype->isDoubleTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      }
      else
      {
        ub->dump();
        assert(false &&
          "This floating point type in above instruction is not handled");
      }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);
  goto_programt::targett fp_to_ui = gp.add_instruction();
  fp_to_ui->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  fp_to_ui->code = code_assignt(result.symbol_expr(), tce);
  fp_to_ui->function = irep_idt(I->getFunction()->getName().str());
  fp_to_ui->source_location = location;
  fp_to_ui->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_FPToSI(const Instruction *I,
  symbol_tablet &symbol_table)
{
  assert(!dyn_cast<FPToSIInst>(I)->isLosslessCast()
    && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type = signedbv_typet(
    dyn_cast<FPToSIInst>(I)->getDestTy()->getIntegerBitWidth());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1;
  exprt exprt1;
  if(dyn_cast<ConstantFP>(*ub))
  {
      errs() << "ConstantFP";
      Type *floattype = dyn_cast<Type>((*ub)->getType());
      if(floattype->isFloatTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToFloat();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_float(val);
        exprt1 = ieee_fl.to_expr();
      }
      else if(floattype->isDoubleTy())
      {
        float val = dyn_cast<ConstantFP>(*ub)->getValueAPF().convertToDouble();
        ieee_floatt ieee_fl = ieee_floatt();
        ieee_fl.from_double(val);
        exprt1 = ieee_fl.to_expr();
      }
      else
      {
        ub->dump();
        assert(false &&
          "This floating point type in above instruction is not handled");
      }
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);
  goto_programt::targett fp_to_si = gp.add_instruction();
  fp_to_si->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  fp_to_si->code = code_assignt(result.symbol_expr(), tce);
  fp_to_si->function = irep_idt(I->getFunction()->getName().str());
  fp_to_si->source_location = location;
  fp_to_si->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_UIToFP(const Instruction *I,
  symbol_tablet &symbol_table)
{
  assert(!dyn_cast<UIToFPInst>(I)->isLosslessCast()
    && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type = symbol_creator::create_type(
    dyn_cast<UIToFPInst>(I)->getDestTy());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1;
  exprt exprt1;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
          li->getOperand(0)->dump();
      op1 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
          op1 = symbol_table.lookup(var_name_map.find(
            ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);
  goto_programt::targett uitofp_inst = gp.add_instruction();
  uitofp_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  uitofp_inst->code = code_assignt(result.symbol_expr(), tce);
  uitofp_inst->function = irep_idt(I->getFunction()->getName().str());
  uitofp_inst->source_location = location;
  uitofp_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_SIToFP(const Instruction *I,
  symbol_tablet &symbol_table)
{
  assert(!dyn_cast<SIToFPInst>(I)->isLosslessCast()
    && "This type conversion is lossy.");
  goto_programt gp;
  typet dest_type = symbol_creator::create_type(
    dyn_cast<SIToFPInst>(I)->getDestTy());
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1;
  exprt exprt1;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getSExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
          li->getOperand(0)->dump();
      op1 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
          op1 = symbol_table.lookup(var_name_map.find(
            ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
    decl_add->function = irep_idt(I->getFunction()->getName().str());
    decl_add->source_location = location;
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);
  goto_programt::targett sitofp_inst = gp.add_instruction();
  sitofp_inst->make_assignment();
  typecast_exprt tce(exprt1, dest_type);
  sitofp_inst->code = code_assignt(result.symbol_expr(), tce);
  sitofp_inst->function = irep_idt(I->getFunction()->getName().str());
  sitofp_inst->source_location = location;
  sitofp_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_IntToPtr(const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_PtrToInt(const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_BitCast(const Instruction *I)
{
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
  const Instruction *I)
{
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
  symbol_tablet *symbol_table)
{
  exprt condition;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  exprt opnd1, opnd2;
  int flag = 2, f1=0, f2=0;
  if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
  {
    li->getOperand(0)->dump();
    opnd1 = symbol_table->lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second).symbol_expr();
    f1=1;
  }
  if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
  {
    li->getOperand(0)->dump();
    opnd2 = symbol_table->lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second).symbol_expr();
    f2=1;
  }
  if(f1==1 && f2==1)
  {
    errs() << "done!";
  }
  else if(I->getOperand(0)->getType()->isIntegerTy())
  {
    if(f1==0)
    {
      if(dyn_cast<ConstantInt>(*ub))
      {
        flag = 1;
      }
      else
      {
        opnd1 = symbol_table->lookup(var_name_map.find(
          ub->getName().str())->second).symbol_expr();
      }
    }

    if(f2 == 0)
    {
      if(dyn_cast<ConstantInt>(*(ub + 1)))
      {
        flag = 0;
      }
      else
      {
        opnd2 = symbol_table->lookup(var_name_map.find(
          (ub + 1)->getName().str())->second).symbol_expr();
      }
    }

    if(opnd2.type().id() == ID_signedbv && flag == 1)
    {
      uint64_t val = dyn_cast<ConstantInt>(*(ub))->getSExtValue();
      typet type = opnd2.type();
      opnd1 = from_integer(val, type);
    }
    if(opnd1.type().id() == ID_signedbv && flag == 0)
    {
      uint64_t val = dyn_cast<ConstantInt>(*(ub+1))->getSExtValue();
      typet type = opnd1.type();
      opnd2 = from_integer(val, type);
    }
    if(opnd2.type().id() == ID_unsignedbv && flag == 1)
    {
      uint64_t val = dyn_cast<ConstantInt>(*(ub))->getZExtValue();
      typet type = opnd2.type();
      opnd1 = from_integer(val, type);
    }
    if(opnd1.type().id() == ID_unsignedbv && flag == 0)
    {
      uint64_t val = dyn_cast<ConstantInt>(*(ub+1))->getZExtValue();
      typet type = opnd1.type();
      opnd2 = from_integer(val, type);
    }
  }
  else
  {
    if(I->getOperand(0)->getType()->isFloatTy())
    {
      if(f1==0)
      {
        if(dyn_cast<ConstantFP>(*ub))
        {
          float val = dyn_cast<ConstantFP>(*ub)
            ->getValueAPF().convertToFloat();
          ieee_floatt ieee_fl = ieee_floatt();
          ieee_fl.from_float(val);
          opnd1 = to_constant_expr(ieee_fl.to_expr());
        }
      }
      if(f2==0)
      {
        if(dyn_cast<ConstantFP>(*(ub+1)))
        {
          float val = dyn_cast<ConstantFP>(*(ub+1))
            ->getValueAPF().convertToFloat();
          ieee_floatt ieee_fl = ieee_floatt();
          ieee_fl.from_float(val);
          opnd2 = to_constant_expr(ieee_fl.to_expr());
        }
      }
    }
    else if(I->getOperand(0)->getType()->isDoubleTy())
    {
      if(f1==0)
      {
        if(dyn_cast<ConstantFP>(*ub))
        {
          double val = dyn_cast<ConstantFP>(*ub)
            ->getValueAPF().convertToDouble();
          ieee_floatt ieee_fl = ieee_floatt();
          ieee_fl.from_double(val);
          opnd1 = ieee_fl.to_expr();
        }
      }
      if(f2==0)
      {
        if(dyn_cast<ConstantFP>(*(ub+1)))
        {
          double val = dyn_cast<ConstantFP>(*(ub+1))
            ->getValueAPF().convertToDouble();
          ieee_floatt ieee_fl = ieee_floatt();
          ieee_fl.from_double(val);
          opnd2 = ieee_fl.to_expr();
        }
      }
    }
    else
    {
      assert(false && "This datatype has not been handled");
    }
  }
  switch(dyn_cast<CmpInst>(I)->getPredicate())
  {
    case CmpInst::Predicate::ICMP_EQ :
    case CmpInst::Predicate::FCMP_OEQ :
    case CmpInst::Predicate::FCMP_UEQ :
    {
      condition = equal_exprt(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_NE :
    case CmpInst::Predicate::FCMP_ONE :
    case CmpInst::Predicate::FCMP_UNE :
    {
      condition = notequal_exprt(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_UGT :
    case CmpInst::Predicate::ICMP_SGT :
    case CmpInst::Predicate::FCMP_OGT :
    case CmpInst::Predicate::FCMP_UGT :
    {
      condition = binary_relation_exprt(opnd1, ID_gt, opnd2);
      // condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_UGE :
    case CmpInst::Predicate::ICMP_SGE :
    case CmpInst::Predicate::FCMP_OGE :
    case CmpInst::Predicate::FCMP_UGE :
    {
      condition = binary_relation_exprt(opnd1, ID_ge, opnd2);
      // condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_ULT :
    case CmpInst::Predicate::ICMP_SLT :
    case CmpInst::Predicate::FCMP_OLT :
    case CmpInst::Predicate::FCMP_ULT :
    {
      condition = binary_relation_exprt(opnd1, ID_lt, opnd2);
      // condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_ULE :
    case CmpInst::Predicate::ICMP_SLE :
    {
      condition = binary_relation_exprt(opnd1, ID_le, opnd2);
      // condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::FCMP_OLE :
    case CmpInst::Predicate::FCMP_ULE :
    {
      condition = binary_relation_exprt(opnd1, ID_le, opnd2);
      // condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::BAD_ICMP_PREDICATE :
    {
      break;
    }
    default : errs() << "\nNON ICMP\n";
  }
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
  symbol_tablet *symbol_table)
{
  exprt condition;
  // I->dump();
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  exprt opnd1, opnd2;
  int flag = 2;
  if(dyn_cast<ConstantInt>(*ub))
  {
    flag = 1;
  }
  else if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
  {
    li->getOperand(0)->dump();
    opnd1 = symbol_table->lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second).symbol_expr();
  }
  else
  {
    opnd1 = symbol_table->lookup(var_name_map.find(
      ub->getName().str())->second).symbol_expr();
  }

  if(dyn_cast<ConstantInt>(*(ub + 1)))
  {
    flag = 0;
  }
  else if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
  {
    li->getOperand(0)->dump();
    opnd2 = symbol_table->lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second).symbol_expr();
  }
  else
  {
    opnd2 = symbol_table->lookup(var_name_map.find(
      (ub + 1)->getName().str())->second).symbol_expr();
  }

  if(opnd2.type().id() == ID_signedbv && flag == 1)
  {
    uint64_t val = dyn_cast<ConstantInt>(*(ub+1))->getZExtValue();
    typet type = opnd2.type();
    dyn_cast<ConstantInt>(*(ub+1))->getType()->dump();
    opnd1 = from_integer(val, type);
  }
  if(opnd1.type().id() == ID_signedbv && flag == 0)
  {
    uint64_t val = dyn_cast<ConstantInt>(*(ub+1))->getZExtValue();
    typet type = opnd1.type();
    dyn_cast<ConstantInt>(*(ub+1))->getType()->dump();
    opnd2 = from_integer(val, type);
  }
  switch(dyn_cast<ICmpInst>(I)->getInversePredicate())
  {
    case CmpInst::Predicate::ICMP_EQ :
    {
      condition = equal_exprt(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_NE :
    {
      condition = notequal_exprt(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_UGT :
    case CmpInst::Predicate::ICMP_SGT :
    {
      condition = exprt(ID_gt);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_UGE :
    {
    case CmpInst::Predicate::ICMP_SGE :
      condition = exprt(ID_ge);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_ULT :
    case CmpInst::Predicate::ICMP_SLT :
    {
      condition = exprt(ID_lt);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::ICMP_ULE :
    case CmpInst::Predicate::ICMP_SLE :
    {
      condition = exprt(ID_le);
      condition.copy_to_operands(opnd1, opnd2);
      break;
    }
    case CmpInst::Predicate::BAD_ICMP_PREDICATE :
    {
      break;
    }
    default : errs() << "\nNON ICMP\n";
  }
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
goto_programt llvm2goto_translator::trans_ICmp(const Instruction *I,
  symbol_tablet *symbol_table)
{
  goto_programt gp;
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();

    errs() << (scope_name_map.find(I->getDebugLoc()->getScope())
      == scope_name_map.end()) << "\n";
    symbol.name = scope_name_map.find(
      I->getDebugLoc()->getScope()->getNonLexicalBlockFileScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = bool_typet();
    symbol_table->add(symbol);
    goto_programt::targett decl_cmp = gp.add_instruction();
    decl_cmp->make_decl();
    decl_cmp->code=code_declt(symbol.symbol_expr());
    decl_cmp->function = irep_idt(I->getFunction()->getName().str());
    // decl_cmp->source_location = location;
  }
  goto_programt::targett Icmp_inst = gp.add_instruction();

  typet dest_type = unsignedbv_typet(1);
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  Icmp_inst->source_location = location;
  Icmp_inst->make_assignment();
  Icmp_inst->code = code_assignt(
    symbol_table->lookup(var_name_map.find(
      I->getName().str())->second).symbol_expr(),
    trans_Cmp(I, symbol_table));
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
goto_programt llvm2goto_translator::trans_FCmp(const Instruction *I,
  symbol_tablet *symbol_table)
{
  goto_programt gp;
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = bool_typet();
    symbol_table->add(symbol);
    goto_programt::targett decl_cmp = gp.add_instruction();
    decl_cmp->make_decl();
    decl_cmp->code=code_declt(symbol.symbol_expr());
    decl_cmp->function = irep_idt(I->getFunction()->getName().str());
    // TODO(Rasika) : set the location
  }
  goto_programt::targett Fcmp_inst = gp.add_instruction();

  typet dest_type = unsignedbv_typet(1);
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  Fcmp_inst->source_location = location;
  Fcmp_inst->make_assignment();
  Fcmp_inst->code = code_assignt(
    symbol_table->lookup(var_name_map.find(
      I->getName().str())->second).symbol_expr(),
    trans_Cmp(I, symbol_table));
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
goto_programt llvm2goto_translator::trans_PHI(const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_Select(const Instruction *I)
{
  goto_programt gp;
  assert(false && "Select is yet to be mapped \n");
  return gp;
}

/*******************************************************************\

   Function: llvm2goto_translator::get_arg_name

    Inputs:
     I - Pointer to the llvm instruction.

    Outputs: name of first argument of instruction.

    Purpose: .

\*******************************************************************/
std::string llvm2goto_translator::get_arg_name(const Instruction *I)
{
  std::string temp_str;
  raw_string_ostream rso(temp_str);
  dyn_cast<CallInst>(I)->arg_begin()->get()->print(rso);
  std::string arg = rso.str();
  int i=arg.size();
  for(; i>=0; i--)
  {
    if(arg[i] == '%')
    {
      break;
    }
  }
  return std::string(arg, ++i, arg.size()-1);
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
  symbol_tablet *symbol_table)
{
  goto_programt gp;
  if(const DbgDeclareInst *dbgDeclareInst = dyn_cast<DbgDeclareInst>(&*I))
  {
    Type *type = &(*dyn_cast<Type>(dyn_cast<PointerType>(dyn_cast<Type>(
      dbgDeclareInst->getAddress()->getType()))->getPointerElementType()));
    MDNode *mdn = dyn_cast<MDNode>(dbgDeclareInst->getVariable());
    std::string name_to_remove = get_arg_name(I);
    auto m = var_name_map.find(name_to_remove);
    for(auto arg = I->getFunction()->arg_begin();
      arg != I->getFunction()->arg_end(); arg++)
    {
      if(dyn_cast<DIVariable>(mdn)->getName() == arg->getName())
      {
        return gp;
      }
    }
    errs() << "removing " << m->second << "\n";
    std::string full_name_to_remove = m->second;
    var_name_map.erase(m);
    symbol_table->remove(full_name_to_remove);
    errs() << "\n adding " << (scope_name_map.find(
      I->getDebugLoc()->getScope()->
          getNonLexicalBlockFileScope())->second
      + "::" + dyn_cast<DIVariable>(mdn)->getName().str() + "\n");
    symbolt symbol;
    switch(dyn_cast<PointerType>(dyn_cast<Type>(dbgDeclareInst->getAddress()
      ->getType()))->getPointerElementType()->getTypeID())
    {
      // 16-bit floating point type
      case llvm::Type::TypeID::HalfTyID :
      {
        errs() << "\nHalf type";
        symbol = symbol_creator::create_HalfTy(type, mdn);
        break;
      }
      // 32-bit floating point type
      case llvm::Type::TypeID::FloatTyID :
      {
        errs() << "\nFloat type";
        symbol = symbol_creator::create_FloatTy(type, mdn);
        break;
      }
      // 64-bit floating point type
      case llvm::Type::TypeID::DoubleTyID :
      {
        symbol = symbol_creator::create_DoubleTy(type, mdn);
        errs() << "\nDouble type";
        break;
      }
      // 80-bit floating point type (X87)
      case llvm::Type::TypeID::X86_FP80TyID :
      {
        symbol = symbol_creator::create_X86_FP80Ty(type, mdn);
        errs() << "\nX86_FP80 type";
        break;
      }
      // 128-bit floating point type (112-bit mantissa)
      case llvm::Type::TypeID::FP128TyID :
      {
        symbol = symbol_creator::create_FP128Ty(type, mdn);
        errs() << "\nFP128 type";
        break;
      }
      // 128-bit floating point type (two 64-bits, PowerPC)
      case llvm::Type::TypeID::PPC_FP128TyID :
      {
        symbol = symbol_creator::create_PPC_FP128Ty(type, mdn);
        errs() << "\nPPC_FP128 type";
        break;
      }
      case llvm::Type::TypeID::IntegerTyID :
      {
        symbol = symbol_creator::create_IntegerTy(type, mdn);
        errs() << "\nInteger type";
        break;
      }
      case llvm::Type::TypeID::StructTyID :
      {
        symbol = symbol_creator::create_StructTy(type, mdn);
        errs() << "\nStruct type";
        break;
      }
      case llvm::Type::TypeID::ArrayTyID :
      {
        symbol = symbol_creator::create_ArrayTy(type, mdn);
        errs() << "\nArray type";
        break;
      }
      case llvm::Type::TypeID::PointerTyID :
      {
        symbol = symbol_creator::create_PointerTy(type, mdn);
        errs() << "\nPointer type";
        break;
      }
      case llvm::Type::TypeID::VectorTyID :
      {
        symbol = symbol_creator::create_VectorTy(type, mdn);
        errs() << "\nVector type";
        break;
      }
      case llvm::Type::TypeID::X86_MMXTyID :
      {
        symbol = symbol_creator::create_X86_MMXTy(type, mdn);
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
    symbol.name = scope_name_map.find(dyn_cast<DILocalScope>(
      I->getDebugLoc()->getScope())->getNonLexicalBlockFileScope())->second
    + "::" + dyn_cast<DIVariable>(mdn)->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      name_to_remove, symbol.name.c_str()));
    symbol_table->add(symbol);
    goto_programt::targett decl_symbol = gp.add_instruction();
    decl_symbol->make_decl();
    decl_symbol->code=code_declt(symbol.symbol_expr());
    source_locationt location = symbol.location;
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
    decl_symbol->source_location = location;
  }
  else if(dyn_cast<CallInst>(I)->getCalledFunction() == NULL)
  {
    // dyn_cast<CallInst>(I)->dump();
    const Value *called_val = dyn_cast<CallInst>(I)->getCalledValue();
    const Function *function = dyn_cast<Function>(
      called_val->stripPointerCasts());
    if(function->getName().str() == "assume"
      || function->getName().str() == "assert")
    {
      goto_programt::targett ass_inst;
      if(function->getName().str() == "assume")
      {
        ass_inst = gp.add_instruction(ASSUME);
      }
      else
      {
        ass_inst = gp.add_instruction(ASSERT);
      }
      exprt guard = typecast_exprt(symbol_table->lookup(var_name_map.find(
        dyn_cast<Instruction>(*I->value_op_begin())->value_op_begin()->
        getName().str())->second).symbol_expr(),
        bool_typet());
      ass_inst->guard = guard;
      source_locationt location;
      if(I->hasMetadata())
      {
        if(&(I->getDebugLoc()) != NULL)
        {
          const DebugLoc loc = I->getDebugLoc();
          location.set_file(loc
                ->getScope()->getFile()->getFilename().str());
          location.set_working_directory(loc
                ->getScope()->getFile()->getDirectory().str());
          location.set_line(loc->getLine());
          location.set_column(loc->getColumn());
          exprt e = trans_Cmp(dyn_cast<Instruction>(
            dyn_cast<Instruction>(I->op_begin())->op_begin()), symbol_table);
          location.set_comment(
            from_expr(namespacet(*symbol_table),
              (symbol_table->symbols.begin()->second.name), e));
        }
      }
      ass_inst->source_location = location;
    }
  }
  else
  {
    const Function *function = dyn_cast<CallInst>(I)->getCalledFunction();
    if(function->begin() != function->end())
    {
      code_function_callt call;
      std::string func_name = function->getName().str();
      symbolt symbol = namespacet(*symbol_table).lookup(dstringt(func_name));
      call.function() = symbol.symbol_expr();
      if(to_code_type(symbol.type).return_type()!=empty_typet())
      {
        symbolt ret;
        ret.base_name = I->getName().str();
        ret.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
          + "::" + I->getName().str();
        var_name_map.insert(std::pair<std::string, std::string>(
          ret.base_name.c_str(), ret.name.c_str()));
        ret.type = symbol_creator::create_type(function->getReturnType());
        symbol_table->add(ret);
        goto_programt::targett decl_ret = gp.add_instruction();
        decl_ret->make_decl();
        decl_ret->code=code_declt(ret.symbol_expr());
        call.lhs()= ret.symbol_expr();
      }
      llvm::User::const_value_op_iterator ub = I->value_op_begin();
      for(code_typet::parameterst::const_iterator
        p_it=to_code_type(symbol.type).parameters().begin();
        p_it!=to_code_type(symbol.type).parameters().end();
        p_it++)
      {
        exprt expr;
        if(dyn_cast<ConstantInt>(*ub))
        {
          uint64_t val = dyn_cast<ConstantInt>(*ub)->getZExtValue();
          typet type = symbol_creator::create_type(
            dyn_cast<ConstantInt>(*ub)->getType());
          dyn_cast<ConstantInt>(*ub)->getType()->dump();
          expr = from_integer(val, type);
        }
        else if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
        {
          li->getOperand(0)->dump();
          expr = symbol_table->lookup(var_name_map.find(
                   li->getOperand(0)->getName().str())->second).symbol_expr();
        }
        else
        {
          expr = symbol_table->lookup(var_name_map.find(
            ub->getName().str())->second).symbol_expr();
        }
        call.arguments().push_back(expr);
        assert(p_it->get_identifier() != irep_idt());
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
goto_programt llvm2goto_translator::trans_Shl(const Instruction *I,
  symbol_tablet &symbol_table)
{
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1)))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);

  goto_programt::targett shl_inst = gp.add_instruction();
  shl_inst->make_assignment();
  shl_inst->code = code_assignt(result.symbol_expr(),
    shl_exprt(exprt1, exprt2));
  shl_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  shl_inst->source_location = location;
  shl_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_LShr(const Instruction *I,
  symbol_tablet &symbol_table)
{
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1)))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = I->getFunction()->getName().str() + "::" + I->getName().str();
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);

  goto_programt::targett lshr_inst = gp.add_instruction();
  lshr_inst->make_assignment();
  lshr_inst->code = code_assignt(result.symbol_expr(),
    lshr_exprt(exprt1, exprt2));
  lshr_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  lshr_inst->source_location = location;
  lshr_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_AShr(const Instruction *I,
  symbol_tablet &symbol_table)
{
  goto_programt gp;
  llvm::User::const_value_op_iterator ub = I->value_op_begin();
  symbolt op1, op2;
  exprt exprt1, exprt2;
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*ub))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt1 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*ub))
    {
    li->getOperand(0)->dump();
    op1 = symbol_table.lookup(var_name_map.find(
      li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op1 = symbol_table.lookup(var_name_map.find(
        ub->getName().str())->second);
    }
    exprt1 = op1.symbol_expr();
  }
  if(const ConstantInt *cint = dyn_cast<ConstantInt>(*(ub+1)))
  {
    uint64_t val;
    val = cint->getZExtValue();
    exprt2 = from_integer(val, symbol_creator::create_type(I->getType()));
  }
  else
  {
    if(const LoadInst *li = dyn_cast<LoadInst>(*(ub + 1)))
    {
      li->getOperand(0)->dump();
      op2 = symbol_table.lookup(var_name_map.find(
        li->getOperand(0)->getName().str())->second);
    }
    else
    {
      op2 = symbol_table.lookup(var_name_map.find(
        (ub + 1)->getName().str())->second);
    }
    exprt2 = op2.symbol_expr();
  }
  if(var_name_map.find(I->getName().str()) == var_name_map.end())
  {
    symbolt symbol;
    symbol.base_name = I->getName().str();
    symbol.name = scope_name_map.find(I->getDebugLoc()->getScope())->second
      + "::" + I->getName().str();
    var_name_map.insert(std::pair<std::string, std::string>(
      symbol.base_name.c_str(), symbol.name.c_str()));
    symbol.type = exprt1.type();
    symbol_table.add(symbol);
    goto_programt::targett decl_add = gp.add_instruction();
    decl_add->make_decl();
    decl_add->code=code_declt(symbol.symbol_expr());
  }
  symbolt result = symbol_table.lookup(var_name_map.find(
    I->getName().str())->second);

  goto_programt::targett ashr_inst = gp.add_instruction();
  ashr_inst->make_assignment();
  ashr_inst->code = code_assignt(result.symbol_expr(),
    ashr_exprt(exprt1, exprt2));
  ashr_inst->function = irep_idt(I->getFunction()->getName().str());
  source_locationt location;
  if(I->hasMetadata())
  {
    if(&(I->getDebugLoc()) != NULL)
    {
      const DebugLoc loc = I->getDebugLoc();
      location.set_file(loc
            ->getScope()->getFile()->getFilename().str());
      location.set_working_directory(loc
            ->getScope()->getFile()->getDirectory().str());
      location.set_line(loc->getLine());
      location.set_column(loc->getColumn());
    }
  }
  ashr_inst->source_location = location;
  ashr_inst->type = goto_program_instruction_typet::ASSIGN;
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
goto_programt llvm2goto_translator::trans_VAArg(const Instruction *I)
{
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
  const Instruction *I)
{
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
  const Instruction *I)
{
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
  const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_ExtractValue(const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_InsertValue(const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_LandingPad(const Instruction *I)
{
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
goto_programt llvm2goto_translator::trans_CleanupPad(const Instruction *I)
{
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
symbol_tablet llvm2goto_translator::trans_Globals(const Module *Mod)
{
  // TODO(Rasika): signed type.
  // TODO(Rasika): various name fields(cbmc).
  errs() << "in trans_Globals\n";
  symbol_tablet symbol_table;
  for(auto &GV : Mod->globals())
  {
    SmallVector<MDNode *, 1> MDs;
    if(!GV.isDeclaration())
    {
      GV.getMetadata(LLVMContext::MD_dbg, MDs);
      if(!MDs.empty())
      {
        for(auto md = MDs.begin(), mde = MDs.end(); md != mde; md++)
        {
          symbolt global_variable;
          global_variable.clear();
          global_variable.is_static_lifetime = true;
          for(auto mmd = (*md)->op_begin(); mmd != (*md)->op_end(); ++mmd)
          {
            if(mmd->get())
            {
              switch(GV.getValueType()->getTypeID())
              {
                // 16-bit floating point type
                case llvm::Type::TypeID::HalfTyID :
                {
                  errs() << "\nHalf type";
                  symbolt symbol = symbol_creator::create_HalfTy(
                    GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  break;
                }
                // 32-bit floating point type
                case llvm::Type::TypeID::FloatTyID :
                {
                  errs() << "\nFloat type";
                  symbolt symbol = symbol_creator::create_FloatTy(
                    GV.getValueType(), dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  break;
                }
                // 64-bit floating point type
                case llvm::Type::TypeID::DoubleTyID :
                {
                  symbolt symbol = symbol_creator::create_DoubleTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nDouble type";
                  break;
                }
                // 80-bit floating point type (X87)
                case llvm::Type::TypeID::X86_FP80TyID :
                {
                  symbolt symbol = symbol_creator::create_X86_FP80Ty(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nX86_FP80 type";
                  break;
                }
                // 128-bit floating point type (112-bit mantissa)
                case llvm::Type::TypeID::FP128TyID :
                {
                  symbolt symbol = symbol_creator::create_FP128Ty(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nFP128 type";
                  break;
                }
                // 128-bit floating point type (two 64-bits, PowerPC)
                case llvm::Type::TypeID::PPC_FP128TyID :
                {
                  symbolt symbol = symbol_creator::create_PPC_FP128Ty(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nPPC_FP128 type";
                  break;
                }
                case llvm::Type::TypeID::IntegerTyID :
                {
                  symbolt symbol = symbol_creator::create_IntegerTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nInteger type";
                  break;
                }
                case llvm::Type::TypeID::StructTyID :
                {
                  const MDNode *dit = dyn_cast<MDNode>(*mmd);
                  symbolt symbol = symbol_creator::create_StructTy(
                    GV.getValueType(),
                    dit);
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nStruct type";
                  break;
                }
                case llvm::Type::TypeID::ArrayTyID :
                {
                  symbolt symbol = symbol_creator::create_ArrayTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nArray type";
                  break;
                }
                case llvm::Type::TypeID::PointerTyID :
                {
                  symbolt symbol = symbol_creator::create_PointerTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nPointer type";
                  break;
                }
                case llvm::Type::TypeID::VectorTyID :
                {
                  symbolt symbol = symbol_creator::create_VectorTy(
                    GV.getValueType(),
                    dyn_cast<MDNode>(*mmd));
                  symbol.name = symbol.base_name;
                  symbol_table.add(symbol);
                  errs() << "\nVector type";
                  break;
                }
                case llvm::Type::TypeID::X86_MMXTyID :
                {
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
    &instruction_target_map,
  std::map <const BasicBlock*, goto_programt::targett>
    &dest_block_branch_map_switch)
{
  errs() << "\n\t\t\tin trans_instruction\n\t\t\t\t";
  I.dump();
  const Instruction *Inst = &I;
  goto_programt gp;
  switch(I.getOpcode())
  {
    // Terminators
    case Instruction::Ret :
    {
      goto_programt ret_gp = trans_Ret(Inst, *symbol_table);
        gp.destructive_append(ret_gp);
        break;
      }
    case Instruction::Br :
    {
      goto_programt br_gp = trans_Br(Inst, symbol_table,
        instruction_target_map);
        gp.destructive_append(br_gp);
        break;
      }
    case Instruction::Switch :
    {
        goto_programt sw_gp = trans_Switch(Inst, dest_block_branch_map_switch,
          *symbol_table);
        gp.destructive_append(sw_gp);
        break;
      }
    case Instruction::IndirectBr :
    {
        gp = trans_IndirectBr(Inst);
        break;
      }
    case Instruction::Invoke :
    {
        gp = trans_Invoke(Inst);
        break;
      }
    case Instruction::Resume :
    {
        gp = trans_Resume(Inst);
        break;
      }
    case Instruction::Unreachable :
    {
        gp = trans_Unreachable(Inst);
        break;
      }
    case Instruction::CleanupRet :
    {
        gp = trans_CleanupRet(Inst);
        break;
      }
    case Instruction::CatchRet :
    {
        gp = trans_CatchRet(Inst);
        break;
      }
    case Instruction::CatchPad :
    {
        gp = trans_CatchPad(Inst);
        break;
      }
    case Instruction::CatchSwitch :
    {
        gp = trans_CatchSwitch(Inst);
        break;
      }

    // Standard binary operators...
    case Instruction::Add :
    {
        goto_programt add_ins = trans_Add(Inst, *symbol_table);
        gp.destructive_append(add_ins);
        break;
      }
    case Instruction::FAdd :
    {
        goto_programt fadd_inst = trans_FAdd(Inst, *symbol_table);
        gp.destructive_append(fadd_inst);
        break;
      }
    case Instruction::Sub :
    {
        goto_programt sub_ins = trans_Sub(Inst, *symbol_table);
        gp.destructive_append(sub_ins);
        break;
      }
    case Instruction::FSub :
    {
        goto_programt fsub_inst = trans_FSub(Inst, *symbol_table);
        gp.destructive_append(fsub_inst);
        break;
      }
    case Instruction::Mul :
    {
        goto_programt mul_ins = trans_Mul(Inst, *symbol_table);
        gp.destructive_append(mul_ins);
        break;
      }
    case Instruction::FMul :
    {
        goto_programt fmul_inst = trans_FMul(Inst, *symbol_table);
        gp.destructive_append(fmul_inst);
        break;
      }
    case Instruction::UDiv :
    {
        goto_programt udiv_ins = trans_UDiv(Inst, *symbol_table);
        gp.destructive_append(udiv_ins);
        break;
      }
    case Instruction::SDiv :
    {
        goto_programt sdiv_ins = trans_SDiv(Inst, *symbol_table);
        gp.destructive_append(sdiv_ins);
        break;
      }
    case Instruction::FDiv :
    {
        goto_programt fdiv_inst = trans_FDiv(Inst, *symbol_table);
        gp.destructive_append(fdiv_inst);
        break;
      }
    case Instruction::URem :
    {
        goto_programt urem_ins = trans_URem(Inst, *symbol_table);
        gp.destructive_append(urem_ins);
        break;
      }
    case Instruction::SRem :
    {
        goto_programt srem_ins = trans_URem(Inst, *symbol_table);
        gp.destructive_append(srem_ins);
        break;
      }
    case Instruction::FRem :
    {
        goto_programt frem_inst = trans_FRem(Inst, *symbol_table);
        gp.destructive_append(frem_inst);
        break;
      }

    // Logical operators...
    case Instruction::And :
    {
        goto_programt and_inst = trans_And(Inst, *symbol_table);
        gp.destructive_append(and_inst);
        break;
      }
    case Instruction::Or :
    {
        goto_programt or_inst = trans_Or(Inst, *symbol_table);
        gp.destructive_append(or_inst);
        break;
      }
    case Instruction::Xor :
    {
        goto_programt xor_inst = trans_Xor(Inst, *symbol_table);
        gp.destructive_append(xor_inst);
        break;
      }

    // Memory instructions...
    case Instruction::Alloca :
    {
        trans_Alloca(Inst, *symbol_table);
        break;
      }
    case Instruction::Load :
    {
        gp = trans_Load(Inst);
        break;
      }
    case Instruction::Store :
    {
        goto_programt load_gp = trans_Store(Inst, *symbol_table);
        gp.destructive_append(load_gp);
        break;
      }
    case Instruction::AtomicCmpXchg :
    {
        gp = trans_AtomicCmpXchg(Inst);
        break;
      }
    case Instruction::AtomicRMW :
    {
        gp = trans_AtomicRMW(Inst);
        break;
      }
    case Instruction::Fence :
    {
        gp = trans_Fence(Inst);
        break;
      }
    case Instruction::GetElementPtr :
    {
        // goto_programt load_gp = trans_Store(Inst, *symbol_table);
        // break;
        goto_programt getElementPtr_gp = trans_GetElementPtr(Inst,
          *symbol_table);
        gp.destructive_append(getElementPtr_gp);
        break;
      }

    // Convert instructions...
    case Instruction::Trunc :
    {
        goto_programt trunc_gp = trans_Trunc(Inst, *symbol_table);
        gp.destructive_append(trunc_gp);
        break;
      }
    case Instruction::ZExt :
    {
        goto_programt zext_gp = trans_ZExt(Inst, *symbol_table);
        gp.destructive_append(zext_gp);
        break;
      }
    case Instruction::SExt :
    {
        goto_programt sext_gp = trans_SExt(Inst, *symbol_table);
        gp.destructive_append(sext_gp);
        break;
      }
    case Instruction::FPTrunc :
    {
        goto_programt fptrunc_gp = trans_FPTrunc(Inst, *symbol_table);
        gp.destructive_append(fptrunc_gp);
        break;
      }
    case Instruction::FPExt :
    {
        goto_programt fpext_gp = trans_FPExt(Inst, *symbol_table);
        gp.destructive_append(fpext_gp);
        break;
      }
    case Instruction::FPToUI :
    {
        goto_programt fptoui_gp = trans_FPToUI(Inst, *symbol_table);
        gp.destructive_append(fptoui_gp);
        break;
      }
    case Instruction::FPToSI :
    {
        goto_programt fptosi_gp = trans_FPToSI(Inst, *symbol_table);
        gp.destructive_append(fptosi_gp);
        break;
      }
    case Instruction::UIToFP :
    {
        goto_programt uitofp_gp = trans_UIToFP(Inst, *symbol_table);
        gp.destructive_append(uitofp_gp);
        break;
      }
    case Instruction::SIToFP :
    {
        goto_programt sitofp_gp = trans_SIToFP(Inst, *symbol_table);
        gp.destructive_append(sitofp_gp);
        break;
      }
    case Instruction::IntToPtr :
    {
        gp = trans_IntToPtr(Inst);
        break;
      }
    case Instruction::PtrToInt :
    {
        gp = trans_PtrToInt(Inst);
        break;
      }
    case Instruction::BitCast :
    {
        gp = trans_BitCast(Inst);
        break;
      }
    case Instruction::AddrSpaceCast :
    {
        gp = trans_AddrSpaceCast(Inst);
        break;
      }

    // Other instructions...
    case Instruction::ICmp :
    {
        goto_programt Icmp_inst = trans_ICmp(Inst, symbol_table);
        gp.destructive_append(Icmp_inst);
        break;
      }
    case Instruction::FCmp :
    {
        goto_programt Fcmp_inst = trans_FCmp(Inst, symbol_table);
        gp.destructive_append(Fcmp_inst);
        break;
      }
    case Instruction::PHI :
    {
        gp = trans_PHI(Inst);
        break;
      }
    case Instruction::Select :
    {
        gp = trans_Select(Inst);
        break;
      }
    case Instruction::Call :
    {
        goto_programt Call_Inst = trans_Call(Inst, symbol_table);
        gp.destructive_append(Call_Inst);
        break;
      }
    case Instruction::Shl :
    {
        goto_programt shl_Inst = trans_Shl(Inst, *symbol_table);
        gp.destructive_append(shl_Inst);
        break;
      }
    case Instruction::LShr :
    {
        goto_programt lshr_Inst = trans_LShr(Inst, *symbol_table);
        gp.destructive_append(lshr_Inst);
        break;
      }
    case Instruction::AShr :
    {
        goto_programt ashr_Inst = trans_AShr(Inst, *symbol_table);
        gp.destructive_append(ashr_Inst);
        break;
      }
    case Instruction::VAArg :
    {
        gp = trans_VAArg(Inst);
        break;
      }
    case Instruction::ExtractElement :
    {
        gp = trans_ExtractElement(Inst);
        break;
      }
    case Instruction::InsertElement :
    {
        gp = trans_InsertElement(Inst);
        break;
      }
    case Instruction::ShuffleVector :
    {
        gp = trans_ShuffleVector(Inst);
        break;
      }
    case Instruction::ExtractValue :
    {
        gp = trans_ExtractValue(Inst);
        break;
      }
    case Instruction::InsertValue :
    {
        gp = trans_InsertValue(Inst);
        break;
      }
    case Instruction::LandingPad :
    {
        gp = trans_LandingPad(Inst);
        break;
      }
    case Instruction::CleanupPad :
    {
        gp = trans_CleanupPad(Inst);
        break;
      }

    default:
        errs() << "Invalid instruction type...\n ";
  }
  errs() << "\t\t\tin trans_instruction";
  gp.update();
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
    &instruction_target_map,
  std::map <const BasicBlock*, goto_programt::targett>
    &dest_block_branch_map_switch)
{
  errs() << "\t\tin trans_Block\n";
  goto_programt gp;
  for(BasicBlock::const_iterator i = b.begin(),
    ie = b.end(); i != ie; ++i)
  {
      goto_programt goto_instr = trans_instruction(*i, symbol_table,
        instruction_target_map, dest_block_branch_map_switch);
      gp.destructive_append(goto_instr);
      gp.update();
      errs() << "";
    }
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
  symbol_tablet *symbol_table)
{
  // TODO(Rasika): check if definition
  //  is available or not, in built functions...
  goto_programt gp;
  scope_tree st;
  scope_name_map.clear();
  st.get_scope_name_map(F, &scope_name_map);
  std::map <const BasicBlock*, goto_programt::targett> block_target_map;
  std::map <const BasicBlock*, goto_programt::targett>
    dest_block_branch_map_switch;
  std::map <const Instruction*, goto_programt::targett> instruction_target_map;
  errs() << "\tin trans_Function\n";
  symbolt symbol = namespacet(*symbol_table).lookup(
    dstringt(F.getName().str()));
  Function::const_iterator b = F.begin(), be = F.end();
  for(; b != be; ++b)
  {
    const BasicBlock &B = *b;
    goto_programt goto_block = trans_Block(B, symbol_table,
      instruction_target_map, dest_block_branch_map_switch);
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
  for(auto i = dest_block_branch_map_switch.begin();
    i!=dest_block_branch_map_switch.end(); i++)
  {
    std::map <const BasicBlock*, goto_programt::targett>::iterator then_pair
      = block_target_map.find(
        dyn_cast<BasicBlock>(i->first));
      auto guard = i->second->guard;
      i->second->make_goto(then_pair->second, guard);
  }
  gp.update();
  errs() << "\tout of trans_Function " + F.getName().str() + "\n";
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
  instruction_target_map)
{
  for(auto i = instruction_target_map.begin(),
    ie = instruction_target_map.end(); i != ie; i++)
  {
    if(dyn_cast<BranchInst>((*i).first)->getNumSuccessors() == 2)
    {
      goto_programt::targett then_part;
      exprt guard;
      if(dyn_cast<BranchInst>((*i).first)->isConditional())
      {
        guard = trans_Inverse_Cmp(
          dyn_cast<Instruction>(
            dyn_cast<BranchInst>((*i).first)->getCondition()), symbol_table);
      }
      else
      {
        guard = true_exprt();
      }
      std::map <const BasicBlock*, goto_programt::targett>::iterator then_pair
      = block_target_map.find(
        dyn_cast<BasicBlock>(
          dyn_cast<BranchInst>((*i).first)->getSuccessor(1)));
      then_part = (*then_pair).second;
      (*i).second->make_goto(then_part, guard);
    }
    else
    {
      goto_programt::targett then_part;
      exprt guard;
      if(dyn_cast<BranchInst>((*i).first)->isConditional())
      {
        guard = trans_Cmp(
          dyn_cast<Instruction>(
            dyn_cast<BranchInst>((*i).first)->getCondition()), symbol_table);
      }
      else
      {
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
goto_functionst llvm2goto_translator::trans_Program(std::string filename)
{
  register_language(new_ansi_c_language);


  // TODO(Rasika): check for presence of function body
  errs() << "in trans_Program\n";
  goto_functionst goto_functions;
  symbol_tablet symbol_table = trans_Globals(M);
  {
    symbolt initialize_function;
    initialize_function.clear();
    initialize_function.is_static_lifetime=true;
    initialize_function.is_thread_local=false;
    const irep_idt initialize_function_bname = INITIALIZE_FUNCTION;
    const irep_idt initialize_function_name = INITIALIZE_FUNCTION;
    initialize_function.mode = ID_C;
    initialize_function.name = initialize_function_name;
    initialize_function.base_name = initialize_function_bname;
    code_typet ct = code_typet();
    ct.return_type() = unsignedbv_typet(32);
    initialize_function.value = exprt();
    initialize_function.type = ct;
    symbol_table.add(initialize_function);

    symbolt cprover_rounding_mode;
    cprover_rounding_mode.name = "__CPROVER_rounding_mode";
    cprover_rounding_mode.base_name = "__CPROVER_rounding_mode";
    cprover_rounding_mode.type = signedbv_typet(32);
    cprover_rounding_mode.mode = ID_C;
    cprover_rounding_mode.value = from_integer(0, cprover_rounding_mode.type);
    symbol_table.add(cprover_rounding_mode);
  }

  goto_programt gp;
  for(Function &F : *M)
  {
    for(Function::arg_iterator arg_b = F.arg_begin (), arg_e = F.arg_end();
      arg_b != arg_e; arg_b++)
    {
      symbolt arg;
      arg.type = symbol_creator::create_type(arg_b->getType());
      arg.name = F.getName().str() + "::" + arg_b->getName().str();
      arg.base_name = arg_b->getName().str();
      arg.is_lvalue = true;
      symbol_table.add(arg);
      var_name_map.insert(
        std::pair<std::string, std::string>(arg.base_name.c_str(),
          arg.name.c_str()));
    }
    Type *functt = (dyn_cast<Type>(F.getFunctionType()));
    symbolt fn = symbol_creator::create_FunctionTy(functt, F);
    fn.name = dstringt(F.getName().str());
    fn.base_name = fn.name;
    fn.is_lvalue = true;
    symbol_table.add(fn);
    goto_functions.function_map.insert(
      std::pair<const dstringt, goto_functionst::goto_functiont >(
        dstringt(F.getName()),
        goto_functionst::goto_functiont()));
    goto_programt func_gp = trans_Function(F, &symbol_table);
    gp.destructive_append(func_gp);
    (*goto_functions.function_map.find(dstringt(F.getName()))).
    second.body.swap(gp);
    (*goto_functions.function_map.find(dstringt(F.getName()))).
    second.type = to_code_type(fn.type);
  }
  set_entry_point(goto_functions, symbol_table);
  cmdlinet cmdline;
  ui_message_handlert umht;

  compilet compile(cmdline, umht, false);
  if(filename == "")
  {
    compile.write_object_file(M->getSourceFileName()
      + ".goto", symbol_table, goto_functions);
  }
  else
  {
    compile.write_object_file(filename, symbol_table, goto_functions);
  }

  namespacet ns(symbol_table);
  // ns.get_symbol_table().show(std::cout);
  errs() << "\n";
  goto_functions.output(ns, std::cout);
  errs() << "\n";
  errs() << "in trans_Program\n";
  return goto_functions;
}
