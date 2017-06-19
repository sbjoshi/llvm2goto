/* Copyright


*/
#include <iostream>
#include <utility>
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "goto-programs/goto_functions.h"
#include "goto-programs/goto_functions_template.h"
#include "util/arith_tools.h"
#include "util/ieee_float.h"

// using llvm::Instruction;
// using llvm::Module;
// using llvm::Function;
// using llvm::BasicBlock;
using namespace llvm;
#ifndef SRC_LLVM2GOTO_TRANSLATORT_H_
#define SRC_LLVM2GOTO_TRANSLATORT_H_
class llvm2goto_translatort {
 public:
    // symbol_tablet symbol_table;
    virtual goto_programt trans_Ret(const Instruction *I) = 0;
    virtual goto_programt trans_Br(const Instruction *I) = 0;
    virtual goto_programt trans_Switch(const Instruction *I) = 0;
    virtual goto_programt trans_IndirectBr(const Instruction *I) = 0;
    virtual goto_programt trans_Invoke(const Instruction *I) = 0;
    virtual goto_programt trans_Resume(const Instruction *I) = 0;
    virtual goto_programt trans_Unreachable(const Instruction *I) = 0;
    virtual goto_programt trans_CleanupRet(const Instruction *I) = 0;
    virtual goto_programt trans_CatchRet(const Instruction *I) = 0;
    virtual goto_programt trans_CatchPad(const Instruction *I) = 0;
    virtual goto_programt trans_CatchSwitch(const Instruction *I) = 0;
    virtual goto_programt trans_Add(const Instruction *I) = 0;
    virtual goto_programt trans_FAdd(const Instruction *I) = 0;
    virtual goto_programt trans_Sub(const Instruction *I) = 0;
    virtual goto_programt trans_FSub(const Instruction *I) = 0;
    virtual goto_programt trans_Mul(const Instruction *I) = 0;
    virtual goto_programt trans_FMul(const Instruction *I) = 0;
    virtual goto_programt trans_UDiv(const Instruction *I) = 0;
    virtual goto_programt trans_SDiv(const Instruction *I) = 0;
    virtual goto_programt trans_FDiv(const Instruction *I) = 0;
    virtual goto_programt trans_URem(const Instruction *I) = 0;
    virtual goto_programt trans_SRem(const Instruction *I) = 0;
    virtual goto_programt trans_FRem(const Instruction *I) = 0;
    virtual goto_programt trans_And(const Instruction *I) = 0;
    virtual goto_programt trans_Or(const Instruction *I) = 0;
    virtual goto_programt trans_Xor(const Instruction *I) = 0;
    virtual goto_programt trans_Alloca(const Instruction *I) = 0;
    virtual goto_programt trans_Load(const Instruction *I) = 0;
    virtual goto_programt trans_Store(const Instruction *I) = 0;
    virtual goto_programt trans_AtomicCmpXchg(const Instruction *I) = 0;
    virtual goto_programt trans_AtomicRMW(const Instruction *I) = 0;
    virtual goto_programt trans_Fence(const Instruction *I) = 0;
    virtual goto_programt trans_GetElementPtr(const Instruction *I) = 0;
    virtual goto_programt trans_Trunc(const Instruction *I) = 0;
    virtual goto_programt trans_ZExt(const Instruction *I) = 0;
    virtual goto_programt trans_SExt(const Instruction *I) = 0;
    virtual goto_programt trans_FPTrunc(const Instruction *I) = 0;
    virtual goto_programt trans_FPExt(const Instruction *I) = 0;
    virtual goto_programt trans_FPToUI(const Instruction *I) = 0;
    virtual goto_programt trans_FPToSI(const Instruction *I) = 0;
    virtual goto_programt trans_UIToFP(const Instruction *I) = 0;
    virtual goto_programt trans_SIToFP(const Instruction *I) = 0;
    virtual goto_programt trans_IntToPtr(const Instruction *I) = 0;
    virtual goto_programt trans_PtrToInt(const Instruction *I) = 0;
    virtual goto_programt trans_BitCast(const Instruction *I) = 0;
    virtual goto_programt trans_AddrSpaceCast(const Instruction *I) = 0;
    virtual goto_programt trans_ICmp(const Instruction *I) = 0;
    virtual goto_programt trans_FCmp(const Instruction *I) = 0;
    virtual goto_programt trans_PHI(const Instruction *I) = 0;
    virtual goto_programt trans_Select(const Instruction *I) = 0;
    virtual goto_programt trans_Call(const Instruction *I,
        symbol_tablet *symbol_table) = 0;
    virtual goto_programt trans_Shl(const Instruction *I) = 0;
    virtual goto_programt trans_LShr(const Instruction *I) = 0;
    virtual goto_programt trans_AShr(const Instruction *I) = 0;
    virtual goto_programt trans_VAArg(const Instruction *I) = 0;
    virtual goto_programt trans_ExtractElement(const Instruction *I) = 0;
    virtual goto_programt trans_InsertElement(const Instruction *I) = 0;
    virtual goto_programt trans_ShuffleVector(const Instruction *I) = 0;
    virtual goto_programt trans_ExtractValue(const Instruction *I) = 0;
    virtual goto_programt trans_InsertValue(const Instruction *I) = 0;
    virtual goto_programt trans_LandingPad(const Instruction *I) = 0;
    virtual goto_programt trans_CleanupPad(const Instruction *I) = 0;
    virtual symbol_tablet trans_Globals(const Module *Mod) = 0;
    virtual goto_programt trans_instruction(const Instruction &I,
        symbol_tablet *symbol_table) = 0;
    virtual goto_programt trans_Block(const BasicBlock &b,
        symbol_tablet *symbol_table) = 0;
    virtual goto_programt trans_Function(const Function &F,
        symbol_tablet *symbol_table) = 0;
    virtual goto_functionst trans_Program(Module *Mod) = 0;
};
#endif  // SRC_LLVM2GOTO_TRANSLATORT_H_"
