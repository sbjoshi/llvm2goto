/*
 * symbol_util.h
 *
 *  Created on: 20-Aug-2019
 *      Author: Akash Banerjee
 */

#ifndef SYMBOL_UTIL_H
#define SYMBOL_UTIL_H

#include "translator.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

class translator::symbol_util {
public:
	static typet get_goto_type(const DIType*);
	static typet get_goto_type(const Type*);
	static symbolt create_symbol(const DIType*);
	static symbolt create_symbol(const Type*);
	static symbolt create_goto_func_symbol(const FunctionType*,
			const Function&);
};

#endif /* SYMBOL_UTIL_H */
