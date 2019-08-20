/*
 * translator.h
 *
 *  Created on: 20-Aug-2019
 *      Author: Akash Banerjee
 */

#ifndef TRANSLATOR_H
#define TRANSLATOR_H

#include "llvm2goto.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

class ll2gb::translator {
private:
	unique_ptr<Module> &llvm_module;
	goto_modelt goto_model;
	goto_functionst goto_functions;
	static symbol_tablet symbol_table;

	static map<string, string> var_name_map; //map from unique names to their base_name(pretty_name)

	void add_global_symbols();
	void set_config();
	void add_initial_symbols();
	void add_function_symbols();
	void initialize_goto() {
		set_config();
		add_initial_symbols();
	}
	void write_goto(const string &op_gbfile);

	class symbol_util;

public:
	translator(unique_ptr<Module> &M) :
			llvm_module { M } {
	}
	bool generate_goto();
};

#endif /* TRANSLATOR_H */
