/*
 * initialize_goto.cpp
 *
 *  Created on: 16-Aug-2019
 *      Author: Akash Banerjee
 */

#include "ll2gb.h"
#include "translator.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

void translator::add_initial_symbols() {
	symbolt initialize_function;
	initialize_function.clear();
	initialize_function.is_static_lifetime = true;
	initialize_function.is_thread_local = false;
	const irep_idt initialize_function_bname = INITIALIZE_FUNCTION;
	const irep_idt initialize_function_name = INITIALIZE_FUNCTION;
	initialize_function.mode = ID_C;
	initialize_function.name = initialize_function_name;
	initialize_function.base_name = initialize_function_bname;
	code_typet ct = code_typet(code_typet::parameterst(),
			void_type());
	initialize_function.value = exprt();
	initialize_function.type = ct;
	symbol_table.add(initialize_function);

	symbolt cprover_rounding_mode;
	cprover_rounding_mode.name = "__CPROVER_rounding_mode";
	cprover_rounding_mode.base_name = "__CPROVER_rounding_mode";
	cprover_rounding_mode.type = signed_int_type();
	cprover_rounding_mode.mode = ID_C;
	cprover_rounding_mode.value = from_integer(ieee_floatt::ROUND_TO_EVEN,
			signed_int_type());
	cprover_rounding_mode.is_thread_local = true;
	cprover_rounding_mode.is_static_lifetime = true;
	cprover_rounding_mode.is_lvalue = true;
	symbol_table.add(cprover_rounding_mode);

	symbolt cprover_deallocated;
	cprover_deallocated.name = "__CPROVER_deallocated";
	cprover_deallocated.base_name = "__CPROVER_deallocated";
	cprover_deallocated.type = pointer_typet(void_type(),
			config.ansi_c.pointer_width);
	cprover_deallocated.value =
			null_pointer_exprt(to_pointer_type(cprover_deallocated.type));
	cprover_deallocated.mode = ID_C;
	cprover_deallocated.is_lvalue = true;
	cprover_deallocated.is_static_lifetime = true;
	symbol_table.add(cprover_deallocated);

	symbolt cprover_dead_object;
	cprover_dead_object.name = "__CPROVER_dead_object";
	cprover_dead_object.base_name = "__CPROVER_dead_object";
	cprover_dead_object.type = pointer_typet(void_type(),
			config.ansi_c.pointer_width);
	cprover_dead_object.value =
			null_pointer_exprt(to_pointer_type(cprover_dead_object.type));
	cprover_dead_object.mode = ID_C;
	cprover_dead_object.is_lvalue = true;
	cprover_dead_object.is_static_lifetime = true;
	symbol_table.add(cprover_dead_object);
//
//	symbolt cprover_malloc_object;
//	cprover_malloc_object.name = "__CPROVER_malloc_object";
//	cprover_malloc_object.base_name = "__CPROVER_malloc_object";
//	cprover_malloc_object.type = pointer_typet(void_type(),
//			config.ansi_c.pointer_width);
//	cprover_malloc_object.value =
//			null_pointer_exprt(to_pointer_type(cprover_malloc_object.type));
//	cprover_malloc_object.mode = ID_C;
//	cprover_malloc_object.is_lvalue = true;
//	cprover_malloc_object.is_static_lifetime = true;
//	symbol_table.add(cprover_malloc_object);
//
//	symbolt cprover_malloc_size;
//	cprover_malloc_size.name = "__CPROVER_malloc_size";
//	cprover_malloc_size.base_name = "__CPROVER_malloc_size";
//	cprover_malloc_size.type = unsignedbv_typet(config.ansi_c.int_width);
//	cprover_malloc_size.value = from_integer(0, cprover_malloc_size.type);
//	cprover_malloc_size.mode = ID_C;
//	cprover_malloc_size.is_lvalue = true;
//	cprover_malloc_size.is_static_lifetime = true;
//	symbol_table.add(cprover_malloc_size);
}

void translator::set_config() {
	config.ansi_c.mode = configt::ansi_ct::flavourt::CLANG;
	config.ansi_c.set_64();
	config.ansi_c.set_arch_spec_x86_64();
	config.ansi_c.set_c11();
	config.ansi_c.rounding_mode = ieee_floatt::ROUND_TO_EVEN;
	config.main = string("main");
	config.ansi_c.arch = "x86_64";
	config.ansi_c.os = configt::ansi_ct::ost::OS_LINUX;
}
