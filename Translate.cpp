/* Copyright


*/
#include <string>
#include <iostream>
#include <list>
#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "goto-programs/goto_functions.h"

using namespace llvm;

  goto_programt trans_Ret(Instruction *I) {
    goto_programt gp;
    std::cout << " Ret is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Br(Instruction *I) {
    goto_programt gp;
    std::cout << " Br is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Switch(Instruction *I) {
    goto_programt gp;
    std::cout << " Switch is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_IndirectBr(Instruction *I) {
    goto_programt gp;
    std::cout << " IndirectBr is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Invoke(Instruction *I) {
    goto_programt gp;
    std::cout << " Invoke is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Resume(Instruction *I) {
    goto_programt gp;
    std::cout << " Resume is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Unreachable(Instruction *I) {
    goto_programt gp;
    std::cout << " Unreachable is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_CleanupRet(Instruction *I) {
    goto_programt gp;
    std::cout << " CleanupRet is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_CatchRet(Instruction *I) {
    goto_programt gp;
    std::cout << " CatchRet is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_CatchPad(Instruction *I) {
    goto_programt gp;
    std::cout << " CatchPad is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_CatchSwitch(Instruction *I) {
    goto_programt gp;
    std::cout << " CatchSwitch is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Add(Instruction *I) {
    goto_programt gp;
    std::cout << " Add is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_FAdd(Instruction *I) {
    goto_programt gp;
    std::cout << " FAdd is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Sub(Instruction *I) {
    goto_programt gp;
    std::cout << " Sub is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_FSub(Instruction *I) {
    goto_programt gp;
    std::cout << " FSub is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Mul(Instruction *I) {
    goto_programt gp;
    std::cout << " Mul is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_FMul(Instruction *I) {
    goto_programt gp;
    std::cout << " FMul is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_UDiv(Instruction *I) {
    goto_programt gp;
    std::cout << " UDiv is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_SDiv(Instruction *I) {
    goto_programt gp;
    std::cout << " SDiv is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_FDiv(Instruction *I) {
    goto_programt gp;
    std::cout << " FDiv is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_URem(Instruction *I) {
    goto_programt gp;
    std::cout << " URem is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_SRem(Instruction *I) {
    goto_programt gp;
    std::cout << " SRem is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_FRem(Instruction *I) {
    goto_programt gp;
    std::cout << " FRem is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_And(Instruction *I) {
    goto_programt gp;
    std::cout << " And is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Or(Instruction *I) {
    goto_programt gp;
    std::cout << " Or is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Xor(Instruction *I) {
    goto_programt gp;
    std::cout << " Xor is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Alloca(Instruction *I) {
    goto_programt gp;
    std::cout << " Alloca is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Load(Instruction *I) {
    goto_programt gp;
    std::cout << " Load is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Store(Instruction *I) {
    goto_programt gp;
    std::cout << " Store is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_AtomicCmpXchg(Instruction *I) {
    goto_programt gp;
    std::cout << " AtomicCmpXchg is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_AtomicRMW(Instruction *I) {
    goto_programt gp;
    std::cout << " AtomicRMW is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Fence(Instruction *I) {
    goto_programt gp;
    std::cout << " Fence is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_GetElementPtr(Instruction *I) {
    goto_programt gp;
    std::cout << " GetElementPtr is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Trunc(Instruction *I) {
    goto_programt gp;
    std::cout << " Trunc is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_ZExt(Instruction *I) {
    goto_programt gp;
    std::cout << " ZExt is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_SExt(Instruction *I) {
    goto_programt gp;
    std::cout << " SExt is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_FPTrunc(Instruction *I) {
    goto_programt gp;
    std::cout << " FPTrunc is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_FPExt(Instruction *I) {
    goto_programt gp;
    std::cout << " FPExt is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_FPToUI(Instruction *I) {
    goto_programt gp;
    std::cout << " FPToUI is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_FPToSI(Instruction *I) {
    goto_programt gp;
    std::cout << " FPToSI is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_UIToFP(Instruction *I) {
    goto_programt gp;
    std::cout << " UIToFP is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_SIToFP(Instruction *I) {
    goto_programt gp;
    std::cout << " SIToFP is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_IntToPtr(Instruction *I) {
    goto_programt gp;
    std::cout << " IntToPtr is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_PtrToInt(Instruction *I) {
    goto_programt gp;
    std::cout << " PtrToInt is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_BitCast(Instruction *I) {
    goto_programt gp;
    std::cout << " BitCast is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_AddrSpaceCast(Instruction *I) {
    goto_programt gp;
    std::cout << " AddrSpaceCast is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_ICmp(Instruction *I) {
    goto_programt gp;
    std::cout << " ICmp is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_FCmp(Instruction *I) {
    goto_programt gp;
    std::cout << " FCmp is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_PHI(Instruction *I) {
    goto_programt gp;
    std::cout << " PHI is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Select(Instruction *I) {
    goto_programt gp;
    std::cout << " Select is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Call(Instruction *I) {
    goto_programt gp;
    std::cout << " Call is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_Shl(Instruction *I) {
    goto_programt gp;
    std::cout << " Shl is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_LShr(Instruction *I) {
    goto_programt gp;
    std::cout << " LShr is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_AShr(Instruction *I) {
    goto_programt gp;
    std::cout << " AShr is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_VAArg(Instruction *I) {
    goto_programt gp;
    std::cout << " VAArg is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_ExtractElement(Instruction *I) {
    goto_programt gp;
    std::cout << " ExtractElement is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_InsertElement(Instruction *I) {
    goto_programt gp;
    std::cout << " InsertElement is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_ShuffleVector(Instruction *I) {
    goto_programt gp;
    std::cout << " ShuffleVector is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_ExtractValue(Instruction *I) {
    goto_programt gp;
    std::cout << " ExtractValue is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_InsertValue(Instruction *I) {
    goto_programt gp;
    std::cout << " InsertValue is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_LandingPad(Instruction *I) {
    goto_programt gp;
    std::cout << " LandingPad is yet to be mapped\n";
    return gp;
  }

  goto_programt trans_CleanupPad(Instruction *I) {
    goto_programt gp;
    std::cout << " CleanupPad is yet to be mapped\n";
    return gp;
  }


  void trans_Globals(Module *Mod) {
    // Module &M = *Mod;
    std::cout << "in trans_Globals\n";
  }

  goto_programt trans_instruction(Instruction &I) {
    std::cout << "\t\t\tin trans_instruction";
    Instruction *Inst = &I;
    goto_programt gp;
    switch (I.getOpcode()) {
      // Terminators
      case Instruction::Ret :{
          gp = trans_Ret(Inst); 
          break;
        }
      case Instruction::Br :{
          gp = trans_Br(Inst); 
          break;
        }
      case Instruction::Switch :{
          gp = trans_Switch(Inst); 
          break;
        }
      case Instruction::IndirectBr :{
          gp = trans_IndirectBr(Inst); 
          break;
        }
      case Instruction::Invoke :{
          gp = trans_Invoke(Inst); 
          break;
        }
      case Instruction::Resume :{
          gp = trans_Resume(Inst); 
          break;
        }
      case Instruction::Unreachable :{
          gp = trans_Unreachable(Inst); 
          break;
        }
      case Instruction::CleanupRet :{
          gp = trans_CleanupRet(Inst); 
          break;
        }
      case Instruction::CatchRet :{
          gp = trans_CatchRet(Inst); 
          break;
        }
      case Instruction::CatchPad :{
          gp = trans_CatchPad(Inst); 
          break;
        }
      case Instruction::CatchSwitch :{
          gp = trans_CatchSwitch(Inst); 
          break;
        }

      // Standard binary operators...
      case Instruction::Add :{
          gp = trans_Add(Inst); 
          break;
        }
      case Instruction::FAdd :{
          gp = trans_FAdd(Inst); 
          break;
        }
      case Instruction::Sub :{
          gp = trans_Sub(Inst); 
          break;
        }
      case Instruction::FSub :{
          gp = trans_FSub(Inst); 
          break;
        }
      case Instruction::Mul :{
          gp = trans_Mul(Inst); 
          break;
        }
      case Instruction::FMul :{
          gp = trans_FMul(Inst); 
          break;
        }
      case Instruction::UDiv :{
          gp = trans_UDiv(Inst); 
          break;
        }
      case Instruction::SDiv :{
          gp = trans_SDiv(Inst); 
          break;
        }
      case Instruction::FDiv :{
          gp = trans_FDiv(Inst); 
          break;
        }
      case Instruction::URem :{
          gp = trans_URem(Inst); 
          break;
        }
      case Instruction::SRem :{
          gp = trans_SRem(Inst); 
          break;
        }
      case Instruction::FRem :{
          gp = trans_FRem(Inst); 
          break;
        }

      // Logical operators...
      case Instruction::And :{
          gp = trans_And(Inst); 
          break;
        }
      case Instruction::Or :{
          gp = trans_Or(Inst); 
          break;
        }
      case Instruction::Xor :{
          gp = trans_Xor(Inst); 
          break;
        }

      // Memory instructions...
      case Instruction::Alloca :{
          gp = trans_Alloca(Inst); 
          break;
        }
      case Instruction::Load :{
          gp = trans_Load(Inst); 
          break;
        }
      case Instruction::Store :{
          gp = trans_Store(Inst); 
          break;
        }
      case Instruction::AtomicCmpXchg :{
          gp = trans_AtomicCmpXchg(Inst); 
          break;
        }
      case Instruction::AtomicRMW :{
          gp = trans_AtomicRMW(Inst); 
          break;
        }
      case Instruction::Fence :{
          gp = trans_Fence(Inst); 
          break;
        }
      case Instruction::GetElementPtr :{
          gp = trans_GetElementPtr(Inst); 
          break;
        }

      // Convert instructions...
      case Instruction::Trunc :{
          gp = trans_Trunc(Inst); 
          break;
        }
      case Instruction::ZExt :{
          gp = trans_ZExt(Inst); 
          break;
        }
      case Instruction::SExt :{
          gp = trans_SExt(Inst); 
          break;
        }
      case Instruction::FPTrunc :{
          gp = trans_FPTrunc(Inst); 
          break;
        }
      case Instruction::FPExt :{
          gp = trans_FPExt(Inst); 
          break;
        }
      case Instruction::FPToUI :{
          gp = trans_FPToUI(Inst); 
          break;
        }
      case Instruction::FPToSI :{
          gp = trans_FPToSI(Inst); 
          break;
        }
      case Instruction::UIToFP :{
          gp = trans_UIToFP(Inst); 
          break;
        }
      case Instruction::SIToFP :{
          gp = trans_SIToFP(Inst); 
          break;
        }
      case Instruction::IntToPtr :{
          gp = trans_IntToPtr(Inst); 
          break;
        }
      case Instruction::PtrToInt :{
          gp = trans_PtrToInt(Inst); 
          break;
        }
      case Instruction::BitCast :{
          gp = trans_BitCast(Inst); 
          break;
        }
      case Instruction::AddrSpaceCast :{
          gp = trans_AddrSpaceCast(Inst); 
          break;
        }

      // Other instructions...
      case Instruction::ICmp :{
          gp = trans_ICmp(Inst); 
          break;
        }
      case Instruction::FCmp :{
          gp = trans_FCmp(Inst); 
          break;
        }
      case Instruction::PHI :{
          gp = trans_PHI(Inst); 
          break;
        }
      case Instruction::Select :{
          gp = trans_Select(Inst); 
          break;
        }
      case Instruction::Call :{
          gp = trans_Call(Inst); 
          break;
        }
      case Instruction::Shl :{
          gp = trans_Shl(Inst); 
          break;
        }
      case Instruction::LShr :{
          gp = trans_LShr(Inst); 
          break;
        }
      case Instruction::AShr :{
          gp = trans_AShr(Inst); 
          break;
        }
      case Instruction::VAArg :{
          gp = trans_VAArg(Inst); 
          break;
        }
      case Instruction::ExtractElement :{
          gp = trans_ExtractElement(Inst); 
          break;
        }
      case Instruction::InsertElement :{
          gp = trans_InsertElement(Inst); 
          break;
        }
      case Instruction::ShuffleVector :{
          gp = trans_ShuffleVector(Inst); 
          break;
        }
      case Instruction::ExtractValue :{
          gp = trans_ExtractValue(Inst); 
          break;
        }
      case Instruction::InsertValue :{
          gp = trans_InsertValue(Inst); 
          break;
        }
      case Instruction::LandingPad :{
          gp = trans_LandingPad(Inst); 
          break;
        }
      case Instruction::CleanupPad :{
          gp = trans_CleanupPad(Inst); 
          break;
        }

      default:
          std::cout << "Invalid instruction type...\n ";
    }
    return gp;
  }

  goto_programt trans_Block(BasicBlock &b){
    std::cout << "\t\tin trans_Block\n";
    goto_programt gp;
    for (BasicBlock::iterator i = b.begin(), ie = b.end(); i != ie; ++i) {
        Instruction &inst = *i;
        goto_programt goto_instr = trans_instruction(inst);
        gp.destructive_append(goto_instr);
        std::cout << "";        
      }
      return gp;
  }

  goto_programt trans_Function(Function &F) {
    // TODO: check if definition is available or not, in built functions...
    goto_programt gp;
    std::cout << "\tin trans_Function\n";
    for(Function::iterator b = F.begin(), be = F.end(); b != be; ++b) {
      BasicBlock &B = *b;
      goto_programt goto_block = trans_Block(B);
      gp.destructive_append(goto_block);
    }
    return gp;
  }

  void trans_Program(Module *Mod) {
    // TODO: set the language
    // TODO: return type
    Module &M = *Mod;
    std::cout << "in trans_Program\n";
    goto_functionst goto_functions;
    goto_functionst::goto_functiont goto_function;
    trans_Globals(Mod);
    for(Function &F : M) {
      goto_functions.function_map.insert(
        std::pair<const dstringt, goto_functionst::goto_functiont >(dstringt(F.getName()),
        goto_functionst::goto_functiont()));
      goto_programt gp = trans_Function(F);
      (*goto_functions.function_map.end()).second.body.swap(gp);
    }
    std::cout << "\nsize :" << (goto_functions).function_map.size() << "\n";
    /*for(goto_functionst::function_mapt::iterator \
      it=(goto_functions).function_map.begin(); \
      it!=(goto_functions).function_map.end(); it++) {
        errs() << "hi \n";
    }*/
  }

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
  trans_Program(M);
  return 0;
}
