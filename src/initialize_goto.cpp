/*
 * initialize_goto.cpp
 *
 *  Created on: 16-Aug-2019
 *      Author: Akash Banerjee
 */

#include "llvm2goto.h"
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
	code_typet ct = code_typet();
	ct.return_type() = unsignedbv_typet(config.ansi_c.int_width);
	initialize_function.value = exprt();
	initialize_function.type = ct;
	symbol_table.add(initialize_function);

	symbolt cprover_rounding_mode;
	cprover_rounding_mode.name = "__CPROVER_rounding_mode";
	cprover_rounding_mode.base_name = "__CPROVER_rounding_mode";
	cprover_rounding_mode.type = signed_int_type();
	cprover_rounding_mode.mode = ID_C;
	cprover_rounding_mode.value = from_integer(0, cprover_rounding_mode.type);
	cprover_rounding_mode.is_thread_local = true;
	cprover_rounding_mode.is_static_lifetime = true;
	cprover_rounding_mode.is_lvalue = true;
	var_name_map[cprover_rounding_mode.name.c_str()] =
			cprover_rounding_mode.base_name.c_str();
	symbol_table.add(cprover_rounding_mode);

	symbolt cprover_deallocated;
	cprover_deallocated.name = "__CPROVER_deallocated";
	cprover_deallocated.base_name = "__CPROVER_deallocated";
	cprover_deallocated.type = pointer_typet(void_typet(),
			config.ansi_c.pointer_width);
	cprover_deallocated.value =
			null_pointer_exprt(to_pointer_type(cprover_deallocated.type));
	cprover_deallocated.mode = ID_C;
	cprover_deallocated.is_lvalue = true;
	cprover_deallocated.is_static_lifetime = true;
	var_name_map[cprover_deallocated.name.c_str()] =
			cprover_deallocated.base_name.c_str();
	symbol_table.add(cprover_deallocated);

	symbolt cprover_dead_object;
	cprover_dead_object.name = "__CPROVER_dead_object";
	cprover_dead_object.base_name = "__CPROVER_dead_object";
	cprover_dead_object.type = pointer_typet(void_typet(),
			config.ansi_c.pointer_width);
	cprover_dead_object.value =
			null_pointer_exprt(to_pointer_type(cprover_dead_object.type));
	cprover_dead_object.mode = ID_C;
	cprover_dead_object.is_lvalue = true;
	cprover_dead_object.is_static_lifetime = true;
	var_name_map[cprover_dead_object.name.c_str()] =
			cprover_dead_object.base_name.c_str();
	symbol_table.add(cprover_dead_object);

	symbolt cprover_malloc_object;
	cprover_malloc_object.name = "__CPROVER_malloc_object";
	cprover_malloc_object.base_name = "__CPROVER_malloc_object";
	cprover_malloc_object.type = pointer_typet(void_typet(),
			config.ansi_c.pointer_width);
	cprover_malloc_object.value =
			null_pointer_exprt(to_pointer_type(cprover_malloc_object.type));
	cprover_malloc_object.mode = ID_C;
	cprover_malloc_object.is_lvalue = true;
	cprover_malloc_object.is_static_lifetime = true;
	var_name_map[cprover_malloc_object.name.c_str()] =
			cprover_malloc_object.base_name.c_str();
	symbol_table.add(cprover_malloc_object);

	symbolt cprover_malloc_size;
	cprover_malloc_size.name = "__CPROVER_malloc_size";
	cprover_malloc_size.base_name = "__CPROVER_malloc_size";
	cprover_malloc_size.type = unsignedbv_typet(config.ansi_c.int_width);
	cprover_malloc_size.value = from_integer(0, cprover_malloc_size.type);
	cprover_malloc_size.mode = ID_C;
	cprover_malloc_size.is_lvalue = true;
	cprover_malloc_size.is_static_lifetime = true;
	var_name_map[cprover_malloc_size.name.c_str()] =
			cprover_malloc_size.base_name.c_str();
	symbol_table.add(cprover_malloc_size);
}

void translator::set_config() {
	config.ansi_c.set_64();
	config.ansi_c.rounding_mode = ieee_floatt::ROUND_TO_EVEN;
	config.ansi_c.set_c11();
	config.ansi_c.single_precision_constant = true;
}
