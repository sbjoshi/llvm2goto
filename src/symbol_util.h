/*
 * symbol_util.h
 *
 *  Created on: 20-Aug-2019
 *      Author: Akash Banerjee
 */

#ifndef SYMBOL_UTIL_H
#define SYMBOL_UTIL_H

#include "translator.h"

class ll2gb::translator::symbol_util {
	static std::set<std::string> typedef_tag_set; ///<Stores typdefs whose type symbols have already been added.
	static unsigned var_counter;
public:
	static std::string lookup_namespace(std::string);
	static typet get_goto_type(const llvm::Type*);
	static symbolt create_symbol(const llvm::Type*);
	static symbolt create_goto_func_symbol(const llvm::Function&);

	static void set_var_counter(unsigned a) {
		var_counter = a;
	}
};

#endif /* SYMBOL_UTIL_H */
