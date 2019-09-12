/*
 * llvm2goto.h
 *
 *  Created on: 21-Feb-2019
 *      Author: Akash Banerjee
 */

#ifndef LLVM2GOTO_H
#define LLVM2GOTO_H

#include <llvm-c/Core.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/IntrinsicInst.h>
#include <llvm/IR/DebugInfoMetadata.h>
#include <llvm/IR/LLVMContext.h>

#include <goto-programs/goto_model.h>
#include <util/config.h>
#include <util/c_types.h>
#include <util/arith_tools.h>
#include <util/namespace.h>
#include <langapi/mode.h>
#include <ansi-c/ansi_c_language.h>
#include <linking/static_lifetime_init.h>

using namespace std;
using namespace llvm;

namespace ll2gb {

class translator;

unique_ptr<Module> get_llvm_ir(string in_irfile);

void print_help();
void parse_input(int argc, char **argv, string &in_irfile, string &out_gbfile);
}

#endif /* LLVM2GOTO_H */
