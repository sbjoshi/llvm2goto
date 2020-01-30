/*
 * symbol_util.h
 *
 *  Created on: 20-Aug-2019
 *      Author: Akash Banerjee
 */

#ifndef SYMBOL_UTIL_H
#define SYMBOL_UTIL_H

#include "translator.h"

/// Utility class for symbols and types.
/// It provides the commonly used translations
/// for ll2gb types and symbols.
class ll2gb::translator::symbol_util {
	static std::set<std::string> typedef_tag_set; ///< Stores names of typdefs whose type symbols have already been added.
	static std::set<const llvm::Type*> current_struct_eval; ///< Used to evaluate the type of recursive structs.
	static unsigned var_counter; ///< A static var_counter used when debug names are not present.

	static std::string lookup_namespace(std::string);
public:
	static typet get_goto_type(const llvm::Type*);
	static symbolt create_symbol(const llvm::Type*);
	static symbolt create_symbol(const typet&, const std::string = "");
	static symbolt create_goto_func_symbol(const llvm::Function&);

/// Set the var_counter to input value.
	static void set_var_counter(unsigned a) {
		var_counter = a;
	}

/// Reset the var_counter.
/// Recommended to be called before
/// translating each function.
	static void reset_var_counter() {
		var_counter = 1;
	}

///Resets the symbol_util.
///This is usefull when translating
///multiple ir files at once
	static void clear() {
		typedef_tag_set.clear();
		current_struct_eval.clear();
		reset_var_counter();
	}
};

#endif /* SYMBOL_UTIL_H */
