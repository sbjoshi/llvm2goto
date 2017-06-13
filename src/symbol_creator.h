/* Copyright


*/
#include "util/symbol_table.h"
#include <string.h>
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/DebugInfoMetadata.h"

#include "util/std_types.h"
using namespace llvm;
#ifndef SRC_SYMBOL_CREATOR_H_
#define SRC_SYMBOL_CREATOR_H_
class symbol_creator{
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
      const llvm::DICompositeType *digv);
    static symbolt create_ArrayTy(Type *type, llvm::MDNode *mdn);
    static symbolt create_PointerTy(Type *type, llvm::MDNode *mdn);
    static symbolt create_VectorTy(Type *type, llvm::MDNode *mdn);
    static symbolt create_VoidTy(Type *type, llvm::MDNode *mdn);
    static symbolt create_FunctionTy(Type *type, llvm::MDNode *mdn);
    static symbolt create_TokenTy(Type *type, llvm::MDNode *mdn);
    static symbolt create_LabelTy(Type *type, llvm::MDNode *mdn);
    static symbolt create_MetadataTy(Type *type, llvm::MDNode *mdn);
};
#endif  // SRC_SYMBOL_CREATOR_H_"
