/* Copyright


*/
#include "llvm/IR/DebugInfoMetadata.h"
// #include "llvm/IR/GlobalVariable.h"
#include "util/source_location.h"
using namespace llvm;
#ifndef SRC_LOCATIONT_H_
#define SRC_LOCATIONT_H_
class locationt{
 public:
  static source_locationt get_location_global_variable(
    const MDNode *mdn);
  // static source_locationt get_location_local_variable(
  //   const llvm::DILocalVariable *dilv);
};
#endif  // SRC_LOCATIONT_H_"
