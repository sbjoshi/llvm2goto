/* Copyright


*/
#include "llvm2goto_translatort.h"

using namespace llvm;
#ifndef SRC_LLVM2GOTO_TRANSLATOR_H_
#define SRC_LLVM2GOTO_TRANSLATOR_H_
class llvm2goto_translator :public llvm2goto_translatort{
 public:
  goto_programt trans_Ret(const Instruction *I);
  goto_programt trans_Br(const Instruction *I);
  goto_programt trans_Switch(const Instruction *I);
  goto_programt trans_IndirectBr(const Instruction *I);
  goto_programt trans_Invoke(const Instruction *I);
  goto_programt trans_Resume(const Instruction *I);
  goto_programt trans_Unreachable(const Instruction *I);
  goto_programt trans_CleanupRet(const Instruction *I);
  goto_programt trans_CatchRet(const Instruction *I);
  goto_programt trans_CatchPad(const Instruction *I);
  goto_programt trans_CatchSwitch(const Instruction *I);
  goto_programt trans_Add(const Instruction *I);
  goto_programt trans_FAdd(const Instruction *I);
  goto_programt trans_Sub(const Instruction *I);
  goto_programt trans_FSub(const Instruction *I);
  goto_programt trans_Mul(const Instruction *I);
  goto_programt trans_FMul(const Instruction *I);
  goto_programt trans_UDiv(const Instruction *I);
  goto_programt trans_SDiv(const Instruction *I);
  goto_programt trans_FDiv(const Instruction *I);
  goto_programt trans_URem(const Instruction *I);
  goto_programt trans_SRem(const Instruction *I);
  goto_programt trans_FRem(const Instruction *I);
  goto_programt trans_And(const Instruction *I);
  goto_programt trans_Or(const Instruction *I);
  goto_programt trans_Xor(const Instruction *I);
  goto_programt trans_Alloca(const Instruction *I);
  goto_programt trans_Load(const Instruction *I);
  goto_programt trans_Store(const Instruction *I);
  goto_programt trans_AtomicCmpXchg(const Instruction *I);
  goto_programt trans_AtomicRMW(const Instruction *I);
  goto_programt trans_Fence(const Instruction *I);
  goto_programt trans_GetElementPtr(const Instruction *I);
  goto_programt trans_Trunc(const Instruction *I);
  goto_programt trans_ZExt(const Instruction *I);
  goto_programt trans_SExt(const Instruction *I);
  goto_programt trans_FPTrunc(const Instruction *I);
  goto_programt trans_FPExt(const Instruction *I);
  goto_programt trans_FPToUI(const Instruction *I);
  goto_programt trans_FPToSI(const Instruction *I);
  goto_programt trans_UIToFP(const Instruction *I);
  goto_programt trans_SIToFP(const Instruction *I);
  goto_programt trans_IntToPtr(const Instruction *I);
  goto_programt trans_PtrToInt(const Instruction *I);
  goto_programt trans_BitCast(const Instruction *I);
  goto_programt trans_AddrSpaceCast(const Instruction *I);
  goto_programt trans_ICmp(const Instruction *I);
  goto_programt trans_FCmp(const Instruction *I);
  goto_programt trans_PHI(const Instruction *I);
  goto_programt trans_Select(const Instruction *I);
  goto_programt trans_Call(const Instruction *I);
  goto_programt trans_Shl(const Instruction *I);
  goto_programt trans_LShr(const Instruction *I);
  goto_programt trans_AShr(const Instruction *I);
  goto_programt trans_VAArg(const Instruction *I);
  goto_programt trans_ExtractElement(const Instruction *I);
  goto_programt trans_InsertElement(const Instruction *I);
  goto_programt trans_ShuffleVector(const Instruction *I);
  goto_programt trans_ExtractValue(const Instruction *I);
  goto_programt trans_InsertValue(const Instruction *I);
  goto_programt trans_LandingPad(const Instruction *I);
  goto_programt trans_CleanupPad(const Instruction *I);

  namespacet trans_Globals(const Module *Mod);

  goto_programt trans_instruction(const Instruction &I);

  goto_programt trans_Block(const BasicBlock &b);

  goto_programt trans_Function(const Function &F);

  goto_functionst trans_Program(Module *Mod);
};
#endif  // SRC_LLVM2GOTO_TRANSLATOR_H_"
