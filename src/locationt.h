/* Copyright


*/
#include "llvm/IR/GlobalVariable.h"
#include "util/source_location.h"
#ifndef SRC_LOCATIONT_H_
#define SRC_LOCATIONT_H_
class locationt{
 public:
  static source_locationt get_location_global_variable(
    const llvm::DIGlobalVariable *digv);
};
#endif  // SRC_LOCATIONT_H_"
