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
	symbol_table.add(cprover_malloc_object);

	symbolt cprover_malloc_size;
	cprover_malloc_size.name = "__CPROVER_malloc_size";
	cprover_malloc_size.base_name = "__CPROVER_malloc_size";
	cprover_malloc_size.type = unsignedbv_typet(config.ansi_c.int_width);
	cprover_malloc_size.value = from_integer(0, cprover_malloc_size.type);
	cprover_malloc_size.mode = ID_C;
	cprover_malloc_size.is_lvalue = true;
	cprover_malloc_size.is_static_lifetime = true;
	symbol_table.add(cprover_malloc_size);
}

void translator::add_malloc_support(bool reset_status) {
	static bool support_added = false;
	if (reset_status) {
		support_added = false;
		return;
	}
	if (support_added)
		return;
	else
		support_added = true;
	symbolt cprover_malloc_is_new_array;
	cprover_malloc_is_new_array.name = "__CPROVER_malloc_is_new_array";
	cprover_malloc_is_new_array.base_name = "__CPROVER_malloc_is_new_array";
	cprover_malloc_is_new_array.type = bool_typet();
	cprover_malloc_is_new_array.mode = ID_C;
	cprover_malloc_is_new_array.value = notequal_exprt(from_integer(0,
			signed_int_type()),
			from_integer(0, signed_int_type()));
	cprover_malloc_is_new_array.is_static_lifetime = true;
	cprover_malloc_is_new_array.is_lvalue = true;
	symbol_table.add(cprover_malloc_is_new_array);

	symbolt cprover_memory_leak;
	cprover_memory_leak.name = "__CPROVER_memory_leak";
	cprover_memory_leak.base_name = "__CPROVER_memory_leak";
	cprover_memory_leak.type = pointer_typet(void_typet(),
			config.ansi_c.pointer_width);
	cprover_memory_leak.value =
			null_pointer_exprt(to_pointer_type(cprover_memory_leak.type));
	cprover_memory_leak.mode = ID_C;
	cprover_memory_leak.is_lvalue = true;
	cprover_memory_leak.is_static_lifetime = true;
	symbol_table.add(cprover_memory_leak);

	symbolt cprover_memory;
	cprover_memory.name = "__CPROVER_memory";
	cprover_memory.base_name = "__CPROVER_memory";
	cprover_memory.type = array_typet(unsigned_char_type(),
			infinity_exprt(unsigned_int_type()));
	cprover_memory.value = from_integer(0, signed_int_type());
	cprover_memory.mode = ID_C;
	cprover_memory.is_lvalue = true;
	cprover_memory.is_static_lifetime = true;
	symbol_table.add(cprover_memory);

	goto_programt malloc_gp;
	symbolt sym;
	goto_programt::targett tgt;

	sym.clear();
	sym.name = sym.base_name = "malloc_size";
	sym.type = signed_long_int_type();
	symbol_table.insert(sym);

	sym.clear();
	tgt = malloc_gp.add_instruction();
	sym.name = sym.base_name = "malloc_res";
	sym.type = pointer_typet(void_typet(), config.ansi_c.pointer_width);
	tgt->make_decl();
	symbol_table.insert(sym);
	tgt->code = code_declt(sym.symbol_expr());

	tgt = malloc_gp.add_instruction();
	sym.clear();
	sym.name = sym.base_name = "malloc_value";
	sym.type = pointer_typet(void_typet(), config.ansi_c.pointer_width);
	tgt->make_decl();
	symbol_table.insert(sym);
	tgt->code = code_declt(sym.symbol_expr());

	tgt = malloc_gp.add_instruction();
	tgt->make_assignment();
	source_locationt loc;
	side_effect_exprt malloc_expr(ID_allocate,
			symbol_table.lookup("malloc_value")->type,
			loc);
	malloc_expr.operands().push_back(symbol_table.lookup("malloc_size")->symbol_expr());
	malloc_expr.operands().push_back(from_integer(0, signed_int_type()));
	tgt->code = code_assignt(symbol_table.lookup("malloc_value")->symbol_expr(),
			malloc_expr);

	tgt = malloc_gp.add_instruction();
	tgt->make_assignment();
	tgt->code = code_assignt(symbol_table.lookup("malloc_res")->symbol_expr(),
			symbol_table.lookup("malloc_value")->symbol_expr());

	tgt = malloc_gp.add_instruction();
	tgt->make_assignment();
	auto cp_de_alloc_expr =
			symbol_table.lookup("__CPROVER_deallocated")->symbol_expr();
	auto eq_expr = equal_exprt(symbol_table.lookup("malloc_res")->symbol_expr(),
			cp_de_alloc_expr);
	tgt->code =
			code_assignt(cp_de_alloc_expr,
					ternary_exprt(ID_if,
							eq_expr,
							null_pointer_exprt(to_pointer_type(cp_de_alloc_expr.type())),
							cp_de_alloc_expr,
							cp_de_alloc_expr.type()));

	sym.clear();
	tgt = malloc_gp.add_instruction();
	sym.name = sym.base_name = "record_malloc";
	sym.type = bool_typet();
	tgt->make_decl();
	symbol_table.insert(sym);
	tgt->code = code_declt(sym.symbol_expr());

	tgt = malloc_gp.add_instruction();
	tgt->make_assignment();
	tgt->code =
			code_assignt(symbol_table.lookup("record_malloc")->symbol_expr(),
					side_effect_expr_nondett(bool_typet()));

	tgt = malloc_gp.add_instruction();
	tgt->make_assignment();
	auto cp_malloc_obj_expr =
			symbol_table.lookup("__CPROVER_malloc_object")->symbol_expr();
	tgt->code = code_assignt(cp_malloc_obj_expr,
			ternary_exprt(ID_if,
					symbol_table.lookup("record_malloc")->symbol_expr(),
					symbol_table.lookup("malloc_res")->symbol_expr(),
					cp_malloc_obj_expr,
					cp_malloc_obj_expr.type()));

	tgt = malloc_gp.add_instruction();
	tgt->make_assignment();
	auto cp_malloc_size_expr =
			symbol_table.lookup("__CPROVER_malloc_size")->symbol_expr();
	tgt->code =
			code_assignt(cp_malloc_size_expr,
					ternary_exprt(ID_if,
							symbol_table.lookup("record_malloc")->symbol_expr(),
							typecast_exprt(symbol_table.lookup("malloc_size")->symbol_expr(),
									cp_malloc_size_expr.type()),
							cp_malloc_size_expr,
							cp_malloc_size_expr.type()));

	tgt = malloc_gp.add_instruction();
	tgt->make_assignment();
	auto cp_malloc_is_n_ar_expr =
			symbol_table.lookup("__CPROVER_malloc_is_new_array")->symbol_expr();
	tgt->code = code_assignt(cp_malloc_is_n_ar_expr,
			notequal_exprt(ternary_exprt(ID_if,
					symbol_table.lookup("record_malloc")->symbol_expr(),
					from_integer(0, signed_int_type()),
					typecast_exprt(cp_malloc_is_n_ar_expr, signed_int_type()),
					signed_int_type()),
					from_integer(0, signed_int_type())));

	sym.clear();
	tgt = malloc_gp.add_instruction();
	sym.name = sym.base_name = "record_may_leak";
	sym.type = bool_typet();
	tgt->make_decl();
	symbol_table.insert(sym);
	tgt->code = code_declt(sym.symbol_expr());

	tgt = malloc_gp.add_instruction();
	tgt->make_assignment();
	tgt->code =
			code_assignt(symbol_table.lookup("record_may_leak")->symbol_expr(),
					side_effect_expr_nondett(bool_typet()));

	tgt = malloc_gp.add_instruction();
	tgt->make_assignment();
	auto cp_mem_leak_expr =
			symbol_table.lookup("__CPROVER_memory_leak")->symbol_expr();
	tgt->code = code_assignt(cp_mem_leak_expr,
			ternary_exprt(ID_if,
					symbol_table.lookup("record_may_leak")->symbol_expr(),
					symbol_table.lookup("malloc_res")->symbol_expr(),
					cp_mem_leak_expr,
					cp_mem_leak_expr.type()));

	tgt = malloc_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() =
			typecast_exprt(symbol_table.lookup("malloc_res")->symbol_expr(),
					pointer_typet(signedbv_typet(8),
							config.ansi_c.pointer_width));
	tgt->code = cret;

	tgt = malloc_gp.add_instruction();
	tgt->make_dead();
	tgt->code =
			code_deadt(symbol_table.lookup("record_may_leak")->symbol_expr());

	tgt = malloc_gp.add_instruction();
	tgt->make_dead();
	tgt->code = code_deadt(symbol_table.lookup("record_malloc")->symbol_expr());

	tgt = malloc_gp.add_instruction();
	tgt->make_dead();
	tgt->code = code_deadt(symbol_table.lookup("malloc_value")->symbol_expr());

	tgt = malloc_gp.add_instruction();
	tgt->make_dead();
	tgt->code = code_deadt(symbol_table.lookup("malloc_res")->symbol_expr());

	tgt = malloc_gp.add_instruction();
	tgt->make_end_function();

	malloc_gp.update();

	sym.clear();
	auto func_code_type = code_typet();
	code_typet::parameterst parameters;
	auto arg_symbol = symbol_table.lookup("malloc_size");
	code_typet::parametert para(arg_symbol->type);
	para.set_identifier(arg_symbol->name);
	para.set_base_name(arg_symbol->base_name);
	parameters.push_back(para);
	func_code_type.parameters() = parameters;
	func_code_type.return_type() = pointer_typet(signedbv_typet(8),
			config.ansi_c.pointer_width);
	sym.name = sym.base_name = sym.pretty_name = "malloc";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("malloc");
	goto_functions.function_map["malloc"].body.swap(malloc_gp);
	goto_functions.function_map["malloc"].type = to_code_type(fn->type);
}

void translator::set_config() {
	config.ansi_c.set_64();
	config.ansi_c.rounding_mode = ieee_floatt::ROUND_TO_EVEN;
	config.ansi_c.set_c11();
	config.ansi_c.single_precision_constant = true;
}
