/* Copyright
 Author : Rasika

 */

#include "util/symbol_table.h"
#include <string.h>
#include "llvm/IR/Function.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/DebugInfoMetadata.h"

#include "util/std_types.h"

#include "pointer-analysis/dereference_callback.h"

using namespace llvm;
#ifndef SRC_SYMBOL_CREATOR_H_
#define SRC_SYMBOL_CREATOR_H_
class symbol_creator {
 public:
  static symbolt create_HalfTy(Type *type, llvm::MDNode *mdn);
  static symbolt create_FloatTy(Type *type, llvm::MDNode *mdn);
  static symbolt create_DoubleTy(Type *type, llvm::MDNode *mdn);
  static symbolt create_X86_FP80Ty(Type *type, llvm::MDNode *mdn);
  static symbolt create_FP128Ty(Type *type, llvm::MDNode *mdn);
  static symbolt create_PPC_FP128Ty(Type *type, llvm::MDNode *mdn);
  static symbolt create_X86_MMXTy(Type *type, llvm::MDNode *mdn);
  static symbolt create_IntegerTy(Type *type, llvm::MDNode *mdn);
  static symbolt create_StructTy(Type *type, const llvm::MDNode *mdn);
  static struct_union_typet create_struct_union_type(Type *type,
                                                     const llvm::DIType *digv);
  static symbolt create_ArrayTy(Type *type, llvm::MDNode *mdn);
  static typet create_array_type(Type *type, llvm::DIType *md);
  static symbolt create_PointerTy(Type *type, llvm::MDNode *mdn);
  static typet create_pointer_type(Type *type, llvm::DIType *md);
  static typet create_type(Type *type, llvm::DIType *mdn);
  static typet create_type(Type *type, bool is_void_type = false);
  static symbolt create_VectorTy(Type *type, llvm::MDNode *mdn);
  static symbolt create_VoidTy(Type *type, llvm::MDNode *mdn);
  static symbolt create_FunctionTy(Type *type, const Function &F);
  static symbolt create_TokenTy(Type *type, llvm::MDNode *mdn);
  static symbolt create_LabelTy(Type *type, llvm::MDNode *mdn);
  static symbolt create_MetadataTy(Type *type, llvm::MDNode *mdn);
  static typet create_Function_Ptr(FunctionType *type, const llvm::DIType *mdn);
};
#endif  // SRC_SYMBOL_CREATOR_H_"
