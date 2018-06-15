/* Copyright
Author : Rasika

*/
#include "locationt.h"



source_locationt locationt::get_location_global_variable(
    const MDNode *mdn)
{
  source_locationt location;
  if(const DIVariable *digv = dyn_cast<DIVariable>(mdn))
  {
    location.set_file(digv->getFile()->getFilename().str());
    location.set_working_directory(digv->getFile()->getDirectory().str());
    location.set_line(digv->getLine());
  }
  return location;
}

// source_locationt locationt::get_location_local_variable(
//     const llvm::DILocalVariable *dilv)
// {
//     source_locationt location;
//   location.set_file(dilv->getFile()->getFilename().str());
//   location.set_working_directory(dilv->getFile()->getDirectory().str());
//   location.set_line(dilv->getLine());
//   return location;
// }
