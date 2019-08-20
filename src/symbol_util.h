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
	static typet get_basic_type(const DIBasicType*);
	static typet get_tag_type(const DIDerivedType*);
	static typet get_composite_type(const DICompositeType*);
	static typet get_derived_type(const DIDerivedType*);

	static set<string> typedef_tag_set; ///<Stores typdefs whose type symbols have already been added.
public:
	static string lookup_namespace(string);
	static typet get_goto_type(const DIType*);
	static typet get_goto_type(const Type*);
	static symbolt create_symbol(const DIType*);
	static symbolt create_symbol(const Type*);
	static symbolt create_goto_func_symbol(const FunctionType*,
			const Function&);
};

#endif /* SYMBOL_UTIL_H */
