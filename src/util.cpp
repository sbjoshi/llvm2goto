/*
 * util.cpp
 *
 *  Created on: 16-Aug-2019
 *      Author: Akash Banerjee
 */

#include "ll2gb.h"
#include "translator.h"
#include "symbol_util.h"
#include <signal.h>

using namespace std;
using namespace llvm;
using namespace ll2gb;

cl::OptionCategory ll2gb_cat("ll2gb Options");

cl::opt<string> ll2gb::InputFilename(cl::Positional,
		cl::desc("<input file>"),
		cl::Required);

cl::opt<string> ll2gb::outputFilename("o",
		cl::desc("Specify output filename"),
		cl::value_desc("filename"),
		cl::init(""),
		cl::cat(ll2gb_cat));

cl::opt<unsigned> ll2gb::verbose("v",
		cl::desc("Specify Verbosity [0, 1, ≥10]"),
		cl::value_desc("unum"),
		cl::init(0),
		cl::cat(ll2gb_cat));

cl::opt<bool> ll2gb::optimizeEnabled("opt",
		cl::desc("Enable Optimization of IR"),
		cl::init(false),
		cl::cat(ll2gb_cat));

cl::opt<bool> ll2gb::optimizeForced("f",
		cl::desc("Force Optimizations"),
		cl::init(false),
		cl::cat(ll2gb_cat));

void ll2gb::print_version(raw_ostream &ostream) {
	ostream << "ll2gb Version: 2.0\n";
}

void ll2gb::parse_input(int argc, char **argv) {
	cl::AddExtraVersionPrinter(print_version);
	cl::HideUnrelatedOptions(ll2gb_cat);
	cl::ParseCommandLineOptions(argc, argv);

	///If output file name is not specified then inputfile.gb is the
	/// default name.
	if (outputFilename.empty()) {
		auto index = InputFilename.find(".ll");
		if (index != InputFilename.npos)
			outputFilename = InputFilename.substr(0, index) + ".gb";
		else
			outputFilename = InputFilename + ".gb";
	}
}

bool ll2gb::is_assert_function(const string &func_name) {
	if (!func_name.compare("assert")) return true;
	if (!func_name.compare("assert_")) return true;
	if (!func_name.compare("__CPROVER_assert")) return true;
	if (!func_name.compare("__VERIFIER_assert")) return true;
	return false;
}

bool ll2gb::is_assert_fail_function(const string &func_name) {
	if (!func_name.compare("__ll2gb_assert_fail_")) return true;
	if (!func_name.compare("__VERIFIER_error")) return true;
	return false;
}

bool ll2gb::is_assume_function(const string &func_name) {
	if (!func_name.compare("assume")) return true;
	if (!func_name.compare("__CPROVER_assume")) return true;
	if (!func_name.compare("__VERIFIER_assume")) return true;
	return false;
}

void ll2gb::print_error() {
	errs().changeColor(errs().RED, true);
	errs() << "error: ";
	errs().resetColor();
	errs().changeColor(errs().SAVEDCOLOR, true);
	errs() << translator::error_state << "\n\n";
	errs().resetColor();
}

void ll2gb::panic(int sig) {
	errs().changeColor(errs().MAGENTA, true);
	errs() << "\nI Panicked :(\n\n";
	if (translator::check_state()) {
		errs().resetColor();
		errs().changeColor(errs().SAVEDCOLOR, true);
		errs() << translator::error_state << "\n\n";
	}
	errs().resetColor();
	exit(3);
}

void ll2gb::secret() {
	static struct sigaction act;
	act.sa_handler = panic;
	sigemptyset(&act.sa_mask);
	act.sa_flags = 0;
	sigaction(SIGSEGV, &act, 0);
}

void translator::add_malloc_support() {
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
	cprover_memory_leak.type = pointer_typet(void_type(),
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

	goto_programt temp_gp;
	symbolt sym;
	goto_programt::targett tgt;

	sym.clear();
	sym.name = sym.base_name = "malloc_size";
	sym.type = signed_long_int_type();
	sym.is_parameter = true;
	symbol_table.insert(sym);

	sym.clear();
	tgt = temp_gp.add_instruction();
	sym.name = sym.base_name = "malloc_res";
	sym.type = pointer_typet(void_type(), config.ansi_c.pointer_width);
	tgt->make_decl();
	symbol_table.insert(sym);
	tgt->code = code_declt(sym.symbol_expr());

	tgt = temp_gp.add_instruction();
	sym.clear();
	sym.name = sym.base_name = "malloc_value";
	sym.type = pointer_typet(void_type(), config.ansi_c.pointer_width);
	tgt->make_decl();
	symbol_table.insert(sym);
	tgt->code = code_declt(sym.symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	source_locationt loc;
	side_effect_exprt malloc_expr(ID_allocate,
			symbol_table.lookup("malloc_value")->type,
			loc);
	malloc_expr.operands().push_back(symbol_table.lookup("malloc_size")->symbol_expr());
	malloc_expr.operands().push_back(from_integer(0, signed_int_type()));
	tgt->code = code_assignt(symbol_table.lookup("malloc_value")->symbol_expr(),
			malloc_expr);

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	tgt->code = code_assignt(symbol_table.lookup("malloc_res")->symbol_expr(),
			symbol_table.lookup("malloc_value")->symbol_expr());

	tgt = temp_gp.add_instruction();
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
	tgt = temp_gp.add_instruction();
	sym.name = sym.base_name = "record_malloc";
	sym.type = bool_typet();
	tgt->make_decl();
	symbol_table.insert(sym);
	tgt->code = code_declt(sym.symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	tgt->code =
			code_assignt(symbol_table.lookup("record_malloc")->symbol_expr(),
					side_effect_expr_nondett(bool_typet(),
							tgt->source_location));

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	auto cp_malloc_obj_expr =
			symbol_table.lookup("__CPROVER_malloc_object")->symbol_expr();
	tgt->code = code_assignt(cp_malloc_obj_expr,
			ternary_exprt(ID_if,
					symbol_table.lookup("record_malloc")->symbol_expr(),
					symbol_table.lookup("malloc_res")->symbol_expr(),
					cp_malloc_obj_expr,
					cp_malloc_obj_expr.type()));

	tgt = temp_gp.add_instruction();
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

	tgt = temp_gp.add_instruction();
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
	tgt = temp_gp.add_instruction();
	sym.name = sym.base_name = "record_may_leak";
	sym.type = bool_typet();
	tgt->make_decl();
	symbol_table.insert(sym);
	tgt->code = code_declt(sym.symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	tgt->code =
			code_assignt(symbol_table.lookup("record_may_leak")->symbol_expr(),
					side_effect_expr_nondett(bool_typet(),
							tgt->source_location));

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	auto cp_mem_leak_expr =
			symbol_table.lookup("__CPROVER_memory_leak")->symbol_expr();
	tgt->code = code_assignt(cp_mem_leak_expr,
			ternary_exprt(ID_if,
					symbol_table.lookup("record_may_leak")->symbol_expr(),
					symbol_table.lookup("malloc_res")->symbol_expr(),
					cp_mem_leak_expr,
					cp_mem_leak_expr.type()));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() =
			typecast_exprt(symbol_table.lookup("malloc_res")->symbol_expr(),
					pointer_typet(signedbv_typet(8),
							config.ansi_c.pointer_width));
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_dead();
	tgt->code =
			code_deadt(symbol_table.lookup("record_may_leak")->symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_dead();
	tgt->code = code_deadt(symbol_table.lookup("record_malloc")->symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_dead();
	tgt->code = code_deadt(symbol_table.lookup("malloc_value")->symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_dead();
	tgt->code = code_deadt(symbol_table.lookup("malloc_res")->symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	sym.clear();
	code_typet::parameterst parameters;
	auto arg_symbol = symbol_table.lookup("malloc_size");
	code_typet::parametert para(arg_symbol->type);
	para.set_identifier(arg_symbol->name);
	para.set_base_name(arg_symbol->base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters,
			pointer_typet(signedbv_typet(8), config.ansi_c.pointer_width));
	sym.name = sym.base_name = sym.pretty_name = "malloc";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("malloc");
	goto_functions.function_map["malloc"].body.swap(temp_gp);
	goto_functions.function_map["malloc"].type = to_code_type(fn->type);
}

void translator::add_calloc_support() {
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
	cprover_memory_leak.type = pointer_typet(void_type(),
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

	goto_programt temp_gp;
	symbolt sym;
	goto_programt::targett tgt;

	sym.clear();
	sym.name = sym.base_name = "calloc_size";
	sym.type = signed_long_int_type();
	sym.is_parameter = true;
	symbol_table.insert(sym);

	sym.clear();
	sym.name = sym.base_name = "calloc_nmemb";
	sym.type = signed_long_int_type();
	sym.is_parameter = true;
	symbol_table.insert(sym);

	sym.clear();
	tgt = temp_gp.add_instruction();
	sym.name = sym.base_name = "calloc_res";
	sym.type = pointer_typet(void_type(), config.ansi_c.pointer_width);
	tgt->make_decl();
	symbol_table.insert(sym);
	tgt->code = code_declt(sym.symbol_expr());

	tgt = temp_gp.add_instruction();
	sym.clear();
	sym.name = sym.base_name = "calloc_value";
	sym.type = pointer_typet(void_type(), config.ansi_c.pointer_width);
	tgt->make_decl();
	symbol_table.insert(sym);
	tgt->code = code_declt(sym.symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	source_locationt loc;
	side_effect_exprt calloc_expr(ID_allocate,
			symbol_table.lookup("calloc_value")->type,
			loc);
	calloc_expr.operands().push_back(mult_exprt(symbol_table.lookup("calloc_nmemb")->symbol_expr(),
			symbol_table.lookup("calloc_size")->symbol_expr()));
	calloc_expr.operands().push_back(from_integer(1, signed_int_type()));
	tgt->code = code_assignt(symbol_table.lookup("calloc_value")->symbol_expr(),
			calloc_expr);

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	tgt->code = code_assignt(symbol_table.lookup("calloc_res")->symbol_expr(),
			symbol_table.lookup("calloc_value")->symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	auto cp_de_alloc_expr =
			symbol_table.lookup("__CPROVER_deallocated")->symbol_expr();
	auto eq_expr = equal_exprt(symbol_table.lookup("calloc_res")->symbol_expr(),
			cp_de_alloc_expr);
	tgt->code =
			code_assignt(cp_de_alloc_expr,
					ternary_exprt(ID_if,
							eq_expr,
							null_pointer_exprt(to_pointer_type(cp_de_alloc_expr.type())),
							cp_de_alloc_expr,
							cp_de_alloc_expr.type()));

	sym.clear();
	tgt = temp_gp.add_instruction();
	sym.name = sym.base_name = "record_calloc";
	sym.type = bool_typet();
	tgt->make_decl();
	symbol_table.insert(sym);
	tgt->code = code_declt(sym.symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	tgt->code =
			code_assignt(symbol_table.lookup("record_calloc")->symbol_expr(),
					side_effect_expr_nondett(bool_typet(),
							tgt->source_location));

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	auto cp_malloc_obj_expr =
			symbol_table.lookup("__CPROVER_malloc_object")->symbol_expr();
	tgt->code = code_assignt(cp_malloc_obj_expr,
			ternary_exprt(ID_if,
					symbol_table.lookup("record_calloc")->symbol_expr(),
					symbol_table.lookup("calloc_res")->symbol_expr(),
					cp_malloc_obj_expr,
					cp_malloc_obj_expr.type()));

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	auto cp_malloc_size_expr =
			symbol_table.lookup("__CPROVER_malloc_size")->symbol_expr();
	tgt->code =
			code_assignt(cp_malloc_size_expr,
					ternary_exprt(ID_if,
							symbol_table.lookup("record_calloc")->symbol_expr(),
							typecast_exprt(symbol_table.lookup("calloc_size")->symbol_expr(),
									cp_malloc_size_expr.type()),
							cp_malloc_size_expr,
							cp_malloc_size_expr.type()));

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	auto cp_malloc_is_n_ar_expr =
			symbol_table.lookup("__CPROVER_malloc_is_new_array")->symbol_expr();
	tgt->code = code_assignt(cp_malloc_is_n_ar_expr,
			notequal_exprt(ternary_exprt(ID_if,
					symbol_table.lookup("record_calloc")->symbol_expr(),
					from_integer(0, signed_int_type()),
					typecast_exprt(cp_malloc_is_n_ar_expr, signed_int_type()),
					signed_int_type()),
					from_integer(0, signed_int_type())));

	sym.clear();
	tgt = temp_gp.add_instruction();
	sym.name = sym.base_name = "record_may_leak";
	sym.type = bool_typet();
	tgt->make_decl();
	symbol_table.insert(sym);
	tgt->code = code_declt(sym.symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	tgt->code =
			code_assignt(symbol_table.lookup("record_may_leak")->symbol_expr(),
					side_effect_expr_nondett(bool_typet(),
							tgt->source_location));

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	auto cp_mem_leak_expr =
			symbol_table.lookup("__CPROVER_memory_leak")->symbol_expr();
	tgt->code = code_assignt(cp_mem_leak_expr,
			ternary_exprt(ID_if,
					symbol_table.lookup("record_may_leak")->symbol_expr(),
					symbol_table.lookup("calloc_res")->symbol_expr(),
					cp_mem_leak_expr,
					cp_mem_leak_expr.type()));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() =
			typecast_exprt(symbol_table.lookup("calloc_res")->symbol_expr(),
					pointer_typet(signedbv_typet(8),
							config.ansi_c.pointer_width));
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_dead();
	tgt->code =
			code_deadt(symbol_table.lookup("record_may_leak")->symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_dead();
	tgt->code = code_deadt(symbol_table.lookup("record_calloc")->symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_dead();
	tgt->code = code_deadt(symbol_table.lookup("calloc_value")->symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_dead();
	tgt->code = code_deadt(symbol_table.lookup("calloc_res")->symbol_expr());

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	sym.clear();
	code_typet::parameterst parameters;
	auto arg_symbol = symbol_table.lookup("calloc_size");
	code_typet::parametert para(arg_symbol->type);
	para.set_identifier(arg_symbol->name);
	para.set_base_name(arg_symbol->base_name);
	parameters.push_back(para);
	auto arg_symbol2 = symbol_table.lookup("calloc_nmemb");
	code_typet::parametert para2(arg_symbol2->type);
	para2.set_identifier(arg_symbol2->name);
	para2.set_base_name(arg_symbol2->base_name);
	parameters.push_back(para2);
	auto func_code_type = code_typet(parameters,
			pointer_typet(signedbv_typet(8), config.ansi_c.pointer_width));
	sym.name = sym.base_name = sym.pretty_name = "calloc";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("calloc");
	goto_functions.function_map["calloc"].body.swap(temp_gp);
	goto_functions.function_map["calloc"].type = to_code_type(fn->type);
}

void translator::add_free_support() {
	add_intrinsic_support("malloc");
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(pointer_type(signedbv_typet(8)),
			"free::ptr");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto ptr = sym1.symbol_expr();

	auto br_inst = temp_gp.add_instruction();

	auto br_inst2 = temp_gp.add_instruction();

	tgt = temp_gp.add_instruction();
	auto cp_de_alloc_expr =
			symbol_table.lookup("__CPROVER_deallocated")->symbol_expr();
	tgt->make_assignment(code_assignt(cp_de_alloc_expr,
			typecast_exprt(ptr, cp_de_alloc_expr.type())));

	auto br_inst3 = temp_gp.add_instruction();
	br_inst2->make_goto(br_inst3,
			not_exprt(side_effect_expr_nondett(bool_typet(),
					br_inst2->source_location)));

	tgt = temp_gp.add_instruction();
	auto cp_mem_leak_expr =
			symbol_table.lookup("__CPROVER_memory_leak")->symbol_expr();
	tgt->make_assignment(code_assignt(cp_mem_leak_expr,
			null_pointer_exprt(to_pointer_type(cp_mem_leak_expr.type()))));

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	br_inst->make_goto(tgt,
			not_exprt(notequal_exprt(ptr,
					null_pointer_exprt(to_pointer_type(ptr.type())))));
	br_inst3->make_goto(tgt,
			not_exprt(notequal_exprt(cp_mem_leak_expr,
					null_pointer_exprt(to_pointer_type(cp_mem_leak_expr.type())))));

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, void_type());
	sym.name = sym.base_name = sym.pretty_name = "free";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("free");
	goto_functions.function_map["free"].body.swap(temp_gp);
	goto_functions.function_map["free"].type = to_code_type(fn->type);

}

void translator::add_fegetround_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	auto expr =
			ternary_exprt(ID_if,
					equal_exprt(rounding_mode,
							from_integer(ieee_floatt::ROUND_TO_MINUS_INF,
									rounding_mode.type())),
					from_integer(0x400, rounding_mode.type()),
					ternary_exprt(ID_if,
							equal_exprt(rounding_mode,
									from_integer(ieee_floatt::ROUND_TO_EVEN,
											rounding_mode.type())),
							from_integer(0, rounding_mode.type()),
							ternary_exprt(ID_if,
									equal_exprt(rounding_mode,
											from_integer(ieee_floatt::ROUND_TO_ZERO,
													rounding_mode.type())),
									from_integer(0xc00, rounding_mode.type()),
									ternary_exprt(ID_if,
											equal_exprt(rounding_mode,
													from_integer(ieee_floatt::ROUND_TO_PLUS_INF,
															rounding_mode.type())),
											from_integer(0x800,
													rounding_mode.type()),
											from_integer(-1,
													rounding_mode.type()),
											rounding_mode.type()),
									rounding_mode.type()),
							rounding_mode.type()),
					rounding_mode.type());

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "fegetround";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("fegetround");
	goto_functions.function_map["fegetround"].body.swap(temp_gp);
	goto_functions.function_map["fegetround"].type = to_code_type(fn->type);
}

void translator::add_fesetround_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(signedbv_typet(32), "fesetround::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e = sym1.symbol_expr();

	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	auto expr = ternary_exprt(ID_if,
			equal_exprt(e, from_integer(0x400, e.type())),
			from_integer(1, e.type()),
			ternary_exprt(ID_if,
					equal_exprt(e, from_integer(0, e.type())),
					from_integer(0, e.type()),
					ternary_exprt(ID_if,
							equal_exprt(e, from_integer(0xc00, e.type())),
							from_integer(3, e.type()),
							ternary_exprt(ID_if,
									equal_exprt(e,
											from_integer(0x800, e.type())),
									from_integer(2, e.type()),
									from_integer(0, e.type()),
									e.type()),
							e.type()),
					e.type()),
			e.type());
	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	tgt->code = code_assignt(rounding_mode, expr);

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = from_integer(0, signedbv_typet(32));
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "fesetround";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("fesetround");
	goto_functions.function_map["fesetround"].body.swap(temp_gp);
	goto_functions.function_map["fesetround"].type = to_code_type(fn->type);
}

void translator::add_fpclassify_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "__fpclassify::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e = sym1.symbol_expr();

	auto expr = ternary_exprt(ID_if,
			isnan_exprt(e),
			from_integer(0, signedbv_typet(32)),
			ternary_exprt(ID_if,
					isinf_exprt(e),
					from_integer(1, signedbv_typet(32)),
					ternary_exprt(ID_if,
							isnormal_exprt(e),
							from_integer(4, signedbv_typet(32)),
							ternary_exprt(ID_if,
									ieee_float_equal_exprt(e,
											from_integer(0, e.type())),
									from_integer(2, signedbv_typet(32)),
									from_integer(3, signedbv_typet(32)),
									signedbv_typet(32)),
							signedbv_typet(32)),
					signedbv_typet(32)),
			signedbv_typet(32));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "__fpclassify";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("__fpclassify");
	goto_functions.function_map["__fpclassify"].body.swap(temp_gp);
	goto_functions.function_map["__fpclassify"].type = to_code_type(fn->type);
}

void translator::add_fpclassifyl_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(ieee_float_spect::x86_80().to_type(),
			"__fpclassifyl::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e = sym1.symbol_expr();

	auto expr = ternary_exprt(ID_if,
			isnan_exprt(e),
			from_integer(0, signedbv_typet(32)),
			ternary_exprt(ID_if,
					isinf_exprt(e),
					from_integer(1, signedbv_typet(32)),
					ternary_exprt(ID_if,
							isnormal_exprt(e),
							from_integer(4, signedbv_typet(32)),
							ternary_exprt(ID_if,
									ieee_float_equal_exprt(e,
											from_integer(0, e.type())),
									from_integer(2, signedbv_typet(32)),
									from_integer(3, signedbv_typet(32)),
									signedbv_typet(32)),
							signedbv_typet(32)),
					signedbv_typet(32)),
			signedbv_typet(32));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "__fpclassifyl";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("__fpclassifyl");
	goto_functions.function_map["__fpclassifyl"].body.swap(temp_gp);
	goto_functions.function_map["__fpclassifyl"].type = to_code_type(fn->type);
}

void translator::add_fpclassifyf_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(float_type(), "__fpclassifyf::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e = sym1.symbol_expr();

	auto expr = ternary_exprt(ID_if,
			isnan_exprt(e),
			from_integer(0, signedbv_typet(32)),
			ternary_exprt(ID_if,
					isinf_exprt(e),
					from_integer(1, signedbv_typet(32)),
					ternary_exprt(ID_if,
							isnormal_exprt(e),
							from_integer(4, signedbv_typet(32)),
							ternary_exprt(ID_if,
									ieee_float_equal_exprt(e,
											from_integer(0, e.type())),
									from_integer(2, signedbv_typet(32)),
									from_integer(3, signedbv_typet(32)),
									signedbv_typet(32)),
							signedbv_typet(32)),
					signedbv_typet(32)),
			signedbv_typet(32));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "__fpclassifyf";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("__fpclassifyf");
	goto_functions.function_map["__fpclassifyf"].body.swap(temp_gp);
	goto_functions.function_map["__fpclassifyf"].type = to_code_type(fn->type);
}

void translator::add_fdim_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "fdim::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(), "fdim::y");
	sym2.is_parameter = true;
	symbol_table.insert(sym2);
	auto e2 = sym2.symbol_expr();

	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	auto expr = ternary_exprt(ID_if,
			binary_relation_exprt(e1, ID_gt, e2),
			ieee_float_op_exprt(e1, ID_floatbv_minus, e2, rounding_mode),
			from_integer(0, e1.type()),
			e1.type());

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	code_typet::parametert para2(sym2.type);
	para2.set_identifier(sym2.name);
	para2.set_base_name(sym2.base_name);
	parameters.push_back(para);
	parameters.push_back(para2);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "fdim";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("fdim");
	goto_functions.function_map["fdim"].body.swap(temp_gp);
	goto_functions.function_map["fdim"].type = to_code_type(fn->type);
}

void translator::add_round_to_integralf_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(signed_int_type(),
			"CPROVER__round_to_integralf::rnd_mode");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto rnd_mode = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(float_type(),
			"CPROVER__round_to_integralf::f");
	sym2.is_parameter = true;
	symbol_table.insert(sym2);
	auto f = sym2.symbol_expr();

	exprt rounding = rnd_mode;
	ieee_floatt magic_const(ieee_float_spect::single_precision().to_type());
	int mgc_const_bit = 0b01001011000000000000000000000000;
	magic_const.from_float(*(float*) &mgc_const_bit);
	auto mgc_cnst_expr = magic_const.to_expr();
	auto expr = ternary_exprt(ID_if,
			binary_relation_exprt(abs_exprt(f), ID_ge, mgc_cnst_expr),
			f,
			ternary_exprt(ID_if,
					ieee_float_equal_exprt(f, from_integer(0, f.type())),
					f,
					ternary_exprt(ID_if,
							extractbit_exprt(f,
									to_bitvector_type(f.type()).get_width()
											- 1),
							ieee_float_op_exprt(ieee_float_op_exprt(f,
									ID_floatbv_minus,
									mgc_cnst_expr,
									rounding),
									ID_floatbv_plus,
									mgc_cnst_expr,
									rounding),
							ieee_float_op_exprt(ieee_float_op_exprt(f,
									ID_floatbv_plus,
									mgc_cnst_expr,
									rounding),
									ID_floatbv_minus,
									mgc_cnst_expr,
									rounding),
							f.type()),
					f.type()),
			f.type());
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	code_typet::parametert para2(sym2.type);
	para2.set_identifier(sym2.name);
	para2.set_base_name(sym2.base_name);
	parameters.push_back(para);
	parameters.push_back(para2);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "CPROVER__round_to_integralf";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("CPROVER__round_to_integralf");
	goto_functions.function_map["CPROVER__round_to_integralf"].body.swap(temp_gp);
	goto_functions.function_map["CPROVER__round_to_integralf"].type =
			to_code_type(fn->type);
}

void translator::add_round_to_integral_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(signed_int_type(),
			"CPROVER__round_to_integral::rnd_mode");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto rnd_mode = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(),
			"CPROVER__round_to_integral::d");
	sym2.is_parameter = true;
	symbol_table.insert(sym2);
	auto d = sym2.symbol_expr();

	exprt rounding = rnd_mode;
	ieee_floatt magic_const(ieee_float_spect::double_precision().to_type());
	long mgc_const_bit = 0x4330000000000000;
	magic_const.from_double(*(double*) &mgc_const_bit);
	auto mgc_cnst_expr = magic_const.to_expr();
	auto expr = ternary_exprt(ID_if,
			binary_relation_exprt(abs_exprt(d), ID_ge, mgc_cnst_expr),
			d,
			ternary_exprt(ID_if,
					ieee_float_equal_exprt(d, from_integer(0, d.type())),
					d,
					ternary_exprt(ID_if,
							extractbit_exprt(d,
									to_bitvector_type(d.type()).get_width()
											- 1),
							ieee_float_op_exprt(ieee_float_op_exprt(d,
									ID_floatbv_minus,
									mgc_cnst_expr,
									rounding),
									ID_floatbv_plus,
									mgc_cnst_expr,
									rounding),
							ieee_float_op_exprt(ieee_float_op_exprt(d,
									ID_floatbv_plus,
									mgc_cnst_expr,
									rounding),
									ID_floatbv_minus,
									mgc_cnst_expr,
									rounding),
							d.type()),
					d.type()),
			d.type());
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	code_typet::parametert para2(sym2.type);
	para2.set_identifier(sym2.name);
	para2.set_base_name(sym2.base_name);
	parameters.push_back(para);
	parameters.push_back(para2);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "CPROVER__round_to_integral";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("CPROVER__round_to_integral");
	goto_functions.function_map["CPROVER__round_to_integral"].body.swap(temp_gp);
	goto_functions.function_map["CPROVER__round_to_integral"].type =
			to_code_type(fn->type);
}

void translator::add_cprover_remainder_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(signed_int_type(),
			"CPROVER__remainder::rnd_mode");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto rnd_mode = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(),
			"CPROVER__remainder::x");
	sym2.is_parameter = true;
	symbol_table.insert(sym2);
	auto x = sym2.symbol_expr();

	auto sym3 = symbol_util::create_symbol(double_type(),
			"CPROVER__remainder::y");
	sym3.is_parameter = true;
	symbol_table.insert(sym3);
	auto y = sym3.symbol_expr();

	auto sym4 = symbol_util::create_symbol(double_type(),
			"CPROVER__remainder::ret");
	symbol_table.insert(sym4);
	auto ret = sym4.symbol_expr();

	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();

	auto br_inst = temp_gp.add_instruction();

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	tgt->code = code_returnt(x);

	auto goto_inst = temp_gp.add_instruction();

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_intrinsic_support("CPROVER__round_to_integral");
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(rnd_mode);
	call_expr.arguments().push_back(floatbv_typecast_exprt(floatbv_typecast_exprt(ieee_float_op_exprt(x,
			ID_floatbv_div,
			y,
			rounding_mode),
			rounding_mode,
			long_double_type()),
			rounding_mode,
			double_type()));
	call_expr.lhs() = ret;
	tgt = temp_gp.add_instruction();
	tgt->make_function_call(call_expr);

	br_inst->make_goto(tgt,
			not_exprt(or_exprt(ieee_float_equal_exprt(x,
					from_integer(0, x.type())),
					isinf_exprt(y))));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() =
			floatbv_typecast_exprt(ieee_float_op_exprt(ieee_float_op_exprt(floatbv_typecast_exprt(unary_minus_exprt(y),
					rounding_mode,
					long_double_type()),
					ID_floatbv_mult,
					floatbv_typecast_exprt(ret,
							rounding_mode,
							long_double_type()),
					rounding_mode),
					ID_floatbv_plus,
					floatbv_typecast_exprt(x,
							rounding_mode,
							long_double_type()),
					rounding_mode),
					rounding_mode,
					double_type());
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	goto_inst->make_goto(tgt, true_exprt());

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	code_typet::parametert para2(sym2.type);
	para2.set_identifier(sym2.name);
	para2.set_base_name(sym2.base_name);
	parameters.push_back(para2);
	code_typet::parametert para3(sym3.type);
	para3.set_identifier(sym3.name);
	para3.set_base_name(sym3.base_name);
	parameters.push_back(para3);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "CPROVER__remainder";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("CPROVER__remainder");
	goto_functions.function_map["CPROVER__remainder"].body.swap(temp_gp);
	goto_functions.function_map["CPROVER__remainder"].type =
			to_code_type(fn->type);
}

void translator::add_cprover_remainderf_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(signed_int_type(),
			"CPROVER__remainderf::rnd_mode");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto rnd_mode = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(float_type(),
			"CPROVER__remainderf::x");
	sym2.is_parameter = true;
	symbol_table.insert(sym2);
	auto x = sym2.symbol_expr();

	auto sym3 = symbol_util::create_symbol(float_type(),
			"CPROVER__remainderf::y");
	sym3.is_parameter = true;
	symbol_table.insert(sym3);
	auto y = sym3.symbol_expr();

	auto sym4 = symbol_util::create_symbol(double_type(),
			"CPROVER__remainderf::ret");
	symbol_table.insert(sym4);
	auto ret = sym4.symbol_expr();

	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();

	auto br_inst = temp_gp.add_instruction();

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	tgt->code = code_returnt(x);

	auto goto_inst = temp_gp.add_instruction();

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_intrinsic_support("CPROVER__round_to_integral");
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(rnd_mode);
	call_expr.arguments().push_back(floatbv_typecast_exprt(floatbv_typecast_exprt(ieee_float_op_exprt(x,
			ID_floatbv_div,
			y,
			rounding_mode),
			rounding_mode,
			long_double_type()),
			rounding_mode,
			double_type()));
	call_expr.lhs() = ret;
	tgt = temp_gp.add_instruction();
	tgt->make_function_call(call_expr);

	br_inst->make_goto(tgt,
			not_exprt(or_exprt(ieee_float_equal_exprt(x,
					from_integer(0, x.type())),
					isinf_exprt(y))));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() =
			floatbv_typecast_exprt(ieee_float_op_exprt(ieee_float_op_exprt(floatbv_typecast_exprt(unary_minus_exprt(y),
					rounding_mode,
					long_double_type()),
					ID_floatbv_mult,
					floatbv_typecast_exprt(ret,
							rounding_mode,
							long_double_type()),
					rounding_mode),
					ID_floatbv_plus,
					floatbv_typecast_exprt(x,
							rounding_mode,
							long_double_type()),
					rounding_mode),
					rounding_mode,
					float_type());
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	goto_inst->make_goto(tgt, true_exprt());

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	code_typet::parametert para2(sym2.type);
	para2.set_identifier(sym2.name);
	para2.set_base_name(sym2.base_name);
	parameters.push_back(para2);
	code_typet::parametert para3(sym3.type);
	para3.set_identifier(sym3.name);
	para3.set_base_name(sym3.base_name);
	parameters.push_back(para3);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "CPROVER__remainderf";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("CPROVER__remainderf");
	goto_functions.function_map["CPROVER__remainderf"].body.swap(temp_gp);
	goto_functions.function_map["CPROVER__remainderf"].type =
			to_code_type(fn->type);
}

void translator::add_remainder_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "remainder::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto x = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(), "remainder::y");
	sym2.is_parameter = true;
	symbol_table.insert(sym2);
	auto y = sym2.symbol_expr();

	auto sym3 = symbol_util::create_symbol(double_type(), "remainder::ret");
	symbol_table.insert(sym3);
	auto ret = sym3.symbol_expr();

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_intrinsic_support("CPROVER__remainder");
	auto rounding_mode = from_integer(ieee_floatt::ROUND_TO_EVEN,
			signed_int_type());
	call_expr.function() =
			symbol_table.lookup("CPROVER__remainder")->symbol_expr();
	call_expr.arguments().push_back(rounding_mode);
	call_expr.arguments().push_back(x);
	call_expr.arguments().push_back(y);
	call_expr.lhs() = ret;
	tgt = temp_gp.add_instruction();
	tgt->make_function_call(call_expr);

	auto expr = ret;
	code_returnt cret;
	tgt = temp_gp.add_instruction();
	cret.return_value() = expr;
	tgt->make_return();
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	code_typet::parametert para2(sym2.type);
	para2.set_identifier(sym2.name);
	para2.set_base_name(sym2.base_name);
	parameters.push_back(para2);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "remainder";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("remainder");
	goto_functions.function_map["remainder"].body.swap(temp_gp);
	goto_functions.function_map["remainder"].type = to_code_type(fn->type);
}

void translator::add_llvm_memcpy_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(pointer_type(signedbv_typet(8)),
			"llvm.memcpy.p0i8.p0i8.i64::dest");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto dest = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(pointer_type(signedbv_typet(8)),
			"llvm.memcpy.p0i8.p0i8.i64::src");
	sym2.is_parameter = true;
	symbol_table.insert(sym2);
	auto src = sym2.symbol_expr();

	auto sym3 = symbol_util::create_symbol(signedbv_typet(64),
			"llvm.memcpy.p0i8.p0i8.i64::len");
	sym3.is_parameter = true;
	symbol_table.insert(sym3);
	auto len = sym3.symbol_expr();

	auto sym4 = symbol_util::create_symbol(bool_typet(),
			"llvm.memcpy.p0i8.p0i8.i64::is_volatile");
	sym4.is_parameter = true;
	symbol_table.insert(sym4);
	auto is_volatile = sym4.symbol_expr();

	auto br_inst = temp_gp.add_instruction();

	auto sym5 = symbol_util::create_symbol(array_typet(signedbv_typet(8), len),
			"llvm.memcpy.p0i8.p0i8.i64::new_arr");
	symbol_table.insert(sym5);
	auto new_arr = sym5.symbol_expr();

	tgt = temp_gp.add_instruction();
	tgt->make_decl(code_declt(new_arr));

	tgt = temp_gp.add_instruction();
	tgt->make_other(codet(ID_array_copy));
	tgt->code.operands().push_back(typecast_exprt(address_of_exprt(new_arr),
			pointer_type(signedbv_typet(8))));
	tgt->code.operands().push_back(src);

	tgt = temp_gp.add_instruction();
	tgt->make_other(codet(ID_array_replace));
	tgt->code.operands().push_back(dest);
	tgt->code.operands().push_back(typecast_exprt(address_of_exprt(new_arr),
			pointer_type(signedbv_typet(8))));

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	br_inst->make_goto(tgt,
			not_exprt(binary_relation_exprt(len,
					ID_gt,
					from_integer(0, len.type()))));

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	code_typet::parametert para2(sym2.type);
	para2.set_identifier(sym2.name);
	para2.set_base_name(sym2.base_name);
	parameters.push_back(para2);
	code_typet::parametert para3(sym3.type);
	para3.set_identifier(sym3.name);
	para3.set_base_name(sym3.base_name);
	parameters.push_back(para3);
	code_typet::parametert para4(sym4.type);
	para4.set_identifier(sym4.name);
	para4.set_base_name(sym4.base_name);
	parameters.push_back(para4);
	auto func_code_type = code_typet(parameters, void_type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.memcpy.p0i8.p0i8.i64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.memcpy.p0i8.p0i8.i64");
	goto_functions.function_map["llvm.memcpy.p0i8.p0i8.i64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.memcpy.p0i8.p0i8.i64"].type =
			to_code_type(fn->type);
}

void translator::add_llvm_memset_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(pointer_type(signedbv_typet(8)),
			"llvm.memset.p0i8.i64::dest");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto dest = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(signedbv_typet(8),
			"llvm.memset.p0i8.i64::val");
	sym2.is_parameter = true;
	symbol_table.insert(sym2);
	auto val = sym2.symbol_expr();

	auto sym3 = symbol_util::create_symbol(signedbv_typet(64),
			"llvm.memset.p0i8.i64::len");
	sym3.is_parameter = true;
	symbol_table.insert(sym3);
	auto len = sym3.symbol_expr();

	auto sym4 = symbol_util::create_symbol(bool_typet(),
			"llvm.memset.p0i8.i64::is_volatile");
	sym4.is_parameter = true;
	symbol_table.insert(sym4);
	auto is_volatile = sym4.symbol_expr();

	auto br_inst = temp_gp.add_instruction();

	auto new_arr_sym = symbol_util::create_symbol(array_typet(signedbv_typet(8),
			len),
			"llvm.memset.p0i8.i64::new_arr");
	symbol_table.insert(new_arr_sym);
	auto new_arr = typecast_exprt(address_of_exprt(new_arr_sym.symbol_expr()),
			pointer_type(signedbv_typet(8)));

	tgt = temp_gp.add_instruction();
	tgt->make_decl(code_declt(new_arr_sym.symbol_expr()));

	tgt = temp_gp.add_instruction();
	tgt->make_other(codet(ID_array_set));
	tgt->code.operands().push_back(new_arr);
	tgt->code.operands().push_back(val);

	tgt = temp_gp.add_instruction();
	tgt->make_other(codet(ID_array_replace));
	tgt->code.operands().push_back(dest);
	tgt->code.operands().push_back(new_arr);

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	br_inst->make_goto(tgt,
			not_exprt(binary_relation_exprt(len,
					ID_gt,
					from_integer(0, len.type()))));

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	code_typet::parametert para2(sym2.type);
	para2.set_identifier(sym2.name);
	para2.set_base_name(sym2.base_name);
	parameters.push_back(para2);
	code_typet::parametert para3(sym3.type);
	para3.set_identifier(sym3.name);
	para3.set_base_name(sym3.base_name);
	parameters.push_back(para3);
	code_typet::parametert para4(sym4.type);
	para4.set_identifier(sym4.name);
	para4.set_base_name(sym4.base_name);
	parameters.push_back(para4);
	auto func_code_type = code_typet(parameters, void_type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.memset.p0i8.i64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.memset.p0i8.i64");
	goto_functions.function_map["llvm.memset.p0i8.i64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.memset.p0i8.i64"].type =
			to_code_type(fn->type);
}

void translator::add_trunc_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "llvm.trunc.f64::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto x = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(),
			"llvm.trunc.f64::ret");
	symbol_table.insert(sym2);
	auto ret = sym2.symbol_expr();

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_intrinsic_support("CPROVER__round_to_integral");
	auto rounding_mode = from_integer(ieee_floatt::ROUND_TO_ZERO,
			signed_int_type());
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(rounding_mode);
	call_expr.arguments().push_back(x);
	call_expr.lhs() = ret;
	tgt = temp_gp.add_instruction();
	tgt->make_function_call(call_expr);

	auto expr = ret;
	code_returnt cret;
	tgt = temp_gp.add_instruction();
	cret.return_value() = expr;
	tgt->make_return();
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.trunc.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.trunc.f64");
	goto_functions.function_map["llvm.trunc.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.trunc.f64"].type = to_code_type(fn->type);
}

void translator::add_modff_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(float_type(), "modff::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(pointer_type(float_type()),
			"modff::iptr");
	sym2.is_parameter = true;
	symbol_table.insert(sym2);
	auto e2 = sym2.symbol_expr();

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_intrinsic_support("CPROVER__round_to_integralf");
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integralf")->symbol_expr();
	call_expr.arguments().push_back(from_integer(ieee_floatt::ROUND_TO_ZERO,
			signed_int_type()));
	call_expr.arguments().push_back(e1);
	call_expr.lhs() = dereference_exprt(e2);
	tgt = temp_gp.add_instruction();
	tgt->make_function_call(call_expr);

	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	auto expr = ieee_float_op_exprt(e1,
			ID_floatbv_minus,
			dereference_exprt(e2),
			rounding_mode);
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	code_typet::parametert para2(sym2.type);
	para2.set_identifier(sym2.name);
	para2.set_base_name(sym2.base_name);
	parameters.push_back(para);
	parameters.push_back(para2);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "modff";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("modff");
	goto_functions.function_map["modff"].body.swap(temp_gp);
	goto_functions.function_map["modff"].type = to_code_type(fn->type);
}

void translator::add_lround_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "lround::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(), "lround::ret");
	symbol_table.insert(sym2);
	auto ret = sym2.symbol_expr();

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_intrinsic_support("llvm.round.f64");
	call_expr.function() = symbol_table.lookup("llvm.round.f64")->symbol_expr();
	call_expr.arguments().push_back(e1);
	call_expr.lhs() = ret;
	tgt = temp_gp.add_instruction();
	tgt->make_function_call(call_expr);

	auto expr = floatbv_typecast_exprt(ret,
			from_integer(ieee_floatt::ROUND_TO_ZERO, signed_int_type()),
			signedbv_typet(64));
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "lround";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("lround");
	goto_functions.function_map["lround"].body.swap(temp_gp);
	goto_functions.function_map["lround"].type = to_code_type(fn->type);
}

void translator::add_lrint_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "lrint::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(), "lrint::rti");
	symbol_table.insert(sym2);
	auto rti = sym2.symbol_expr();
	tgt = temp_gp.add_instruction();
	tgt->make_decl();
	tgt->code = code_declt(rti);

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_intrinsic_support("CPROVER__round_to_integral");
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(rounding_mode);
	call_expr.arguments().push_back(e1);
	call_expr.lhs() = rti;
	tgt = temp_gp.add_instruction();
	tgt->make_function_call(call_expr);

	auto expr = floatbv_typecast_exprt(rti,
			from_integer(ieee_floatt::ROUND_TO_ZERO, signed_int_type()),
			signed_long_int_type());
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "lrint";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("lrint");
	goto_functions.function_map["lrint"].body.swap(temp_gp);
	goto_functions.function_map["lrint"].type = to_code_type(fn->type);
}

void translator::add_llvm_rint_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "llvm.rint.f64::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(), "llvm.rint.f64::rti");
	symbol_table.insert(sym2);
	auto rti = sym2.symbol_expr();
	tgt = temp_gp.add_instruction();
	tgt->make_decl();
	tgt->code = code_declt(rti);

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_intrinsic_support("CPROVER__round_to_integral");
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(rounding_mode);
	call_expr.arguments().push_back(e1);
	call_expr.lhs() = rti;
	tgt = temp_gp.add_instruction();
	tgt->make_function_call(call_expr);

	auto expr = rti;
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.rint.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.rint.f64");
	goto_functions.function_map["llvm.rint.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.rint.f64"].type = to_code_type(fn->type);
}

void translator::add_llvm_nearbyint_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(),
			"llvm.nearbyint.f64::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(),
			"llvm.nearbyint.f64::rti");
	symbol_table.insert(sym2);
	auto rti = sym2.symbol_expr();
	tgt = temp_gp.add_instruction();
	tgt->make_decl();
	tgt->code = code_declt(rti);

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_intrinsic_support("CPROVER__round_to_integral");
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(rounding_mode);
	call_expr.arguments().push_back(e1);
	call_expr.lhs() = rti;
	tgt = temp_gp.add_instruction();
	tgt->make_function_call(call_expr);

	auto expr = rti;
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.nearbyint.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.nearbyint.f64");
	goto_functions.function_map["llvm.nearbyint.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.nearbyint.f64"].type =
			to_code_type(fn->type);
}

void translator::add_fabs_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "llvm.fabs.f64::d");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto expr = abs_exprt(e1);
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.fabs.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.fabs.f64");
	goto_functions.function_map["llvm.fabs.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.fabs.f64"].type = to_code_type(fn->type);
}

void translator::add_fabs80_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(ieee_float_spect::x86_80().to_type(),
			"llvm.fabs.f80::d");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto expr = abs_exprt(e1);
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.fabs.f80";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.fabs.f80");
	goto_functions.function_map["llvm.fabs.f80"].body.swap(temp_gp);
	goto_functions.function_map["llvm.fabs.f80"].type = to_code_type(fn->type);
}

void translator::add_fabs32_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(float_type(), "llvm.fabs.f32::d");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto expr = abs_exprt(e1);
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.fabs.f32";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.fabs.f32");
	goto_functions.function_map["llvm.fabs.f32"].body.swap(temp_gp);
	goto_functions.function_map["llvm.fabs.f32"].type = to_code_type(fn->type);
}

void translator::add_copysign_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(),
			"llvm.copysign.f64::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto x = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(),
			"llvm.copysign.f64::y");
	sym2.is_parameter = true;
	symbol_table.insert(sym2);
	auto y = sym2.symbol_expr();

	auto expr = ternary_exprt(ID_if,
			extractbit_exprt(y, to_bitvector_type(y.type()).get_width() - 1),
			unary_minus_exprt(abs_exprt(x)),
			abs_exprt(x),
			x.type());
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	code_typet::parametert para2(sym2.type);
	para2.set_identifier(sym2.name);
	para2.set_base_name(sym2.base_name);
	parameters.push_back(para2);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.copysign.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.copysign.f64");
	goto_functions.function_map["llvm.copysign.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.copysign.f64"].type =
			to_code_type(fn->type);
}

void translator::add_maxnum_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "llvm.maxnum.f64::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto x = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(), "llvm.maxnum.f64::y");
	sym2.is_parameter = true;
	symbol_table.insert(sym2);
	auto y = sym2.symbol_expr();

//	auto expr = ternary_exprt(ID_if,
//			isnan_exprt(x),
//			x,
//			ternary_exprt(ID_if,
//					isnan_exprt(y),
//					y,
//					ternary_exprt(ID_if,
//							binary_relation_exprt(x, ID_gt, y),
//							x,
//							y,
//							double_type()),
//					double_type()),
//			double_type());
	auto expr = ternary_exprt(ID_if,
			binary_relation_exprt(x, ID_gt, y),
			x,
			y,
			double_type());
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	code_typet::parametert para2(sym2.type);
	para2.set_identifier(sym2.name);
	para2.set_base_name(sym2.base_name);
	parameters.push_back(para2);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.maxnum.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.maxnum.f64");
	goto_functions.function_map["llvm.maxnum.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.maxnum.f64"].type =
			to_code_type(fn->type);
}

void translator::add_minnum_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "llvm.minnum.f64::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto x = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(), "llvm.minnum.f64::y");
	sym2.is_parameter = true;
	symbol_table.insert(sym2);
	auto y = sym2.symbol_expr();

//	auto expr = ternary_exprt(ID_if,
//			isnan_exprt(x),
//			x,
//			ternary_exprt(ID_if,
//					isnan_exprt(y),
//					y,
//					ternary_exprt(ID_if,
//							binary_relation_exprt(x, ID_gt, y),
//							x,
//							y,
//							double_type()),
//					double_type()),
//			double_type());
	auto expr = ternary_exprt(ID_if,
			binary_relation_exprt(x, ID_lt, y),
			x,
			y,
			double_type());
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	code_typet::parametert para2(sym2.type);
	para2.set_identifier(sym2.name);
	para2.set_base_name(sym2.base_name);
	parameters.push_back(para2);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.minnum.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.minnum.f64");
	goto_functions.function_map["llvm.minnum.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.minnum.f64"].type =
			to_code_type(fn->type);
}

void translator::add_floor_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "llvm.floor.f64::d");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(),
			"llvm.floor.f64::ret");
	symbol_table.insert(sym2);
	auto rti = sym2.symbol_expr();
	tgt = temp_gp.add_instruction();
	tgt->make_decl();
	tgt->code = code_declt(rti);

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_intrinsic_support("CPROVER__round_to_integral");
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(from_integer(ieee_floatt::ROUND_TO_MINUS_INF,
			signed_int_type()));
	call_expr.arguments().push_back(e1);
	call_expr.lhs() = rti;
	tgt = temp_gp.add_instruction();
	tgt->make_function_call(call_expr);

	auto expr = rti;
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.floor.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.floor.f64");
	goto_functions.function_map["llvm.floor.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.floor.f64"].type = to_code_type(fn->type);
}

void translator::add_ceil_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "llvm.ceil.f64::d");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(), "llvm.ceil.f64::ret");
	symbol_table.insert(sym2);
	auto ret = sym2.symbol_expr();
	tgt = temp_gp.add_instruction();
	tgt->make_decl();
	tgt->code = code_declt(ret);

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_intrinsic_support("CPROVER__round_to_integral");
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(from_integer(ieee_floatt::ROUND_TO_PLUS_INF,
			signed_int_type()));
	call_expr.arguments().push_back(e1);
	call_expr.lhs() = ret;
	tgt = temp_gp.add_instruction();
	tgt->make_function_call(call_expr);

	auto expr = ret;
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.ceil.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.ceil.f64");
	goto_functions.function_map["llvm.ceil.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.ceil.f64"].type = to_code_type(fn->type);
}

void translator::add_round_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "llvm.round.f64::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(), "llvm.round.f64::xp");
	symbol_table.insert(sym2);
	auto xp = sym2.symbol_expr();
	tgt = temp_gp.add_instruction();
	tgt->make_decl();
	tgt->code = code_declt(xp);

	auto br_inst = temp_gp.add_instruction();
	ieee_floatt half_double;
	half_double.from_double(0.5);
	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	tgt->code = code_assignt(xp,
			ieee_float_op_exprt(e1,
					ID_floatbv_plus,
					half_double.to_expr(),
					from_integer(ieee_floatt::ROUND_TO_ZERO,
							signed_int_type())));

	auto goto_inst = temp_gp.add_instruction();

	auto br_inst2 = temp_gp.add_instruction();
	br_inst->make_goto(br_inst2,
			not_exprt(binary_relation_exprt(e1,
					ID_gt,
					from_integer(0, e1.type()))));

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	tgt->code = code_assignt(xp,
			ieee_float_op_exprt(e1,
					ID_floatbv_minus,
					half_double.to_expr(),
					from_integer(ieee_floatt::ROUND_TO_ZERO,
							signed_int_type())));
	auto goto_inst2 = temp_gp.add_instruction();

	tgt = temp_gp.add_instruction();
	tgt->make_assignment();
	tgt->code = code_assignt(xp, e1);

	br_inst2->make_goto(tgt,
			not_exprt(binary_relation_exprt(e1,
					ID_lt,
					from_integer(0, e1.type()))));

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_intrinsic_support("CPROVER__round_to_integral");
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(from_integer(ieee_floatt::ROUND_TO_ZERO,
			signed_int_type()));
	call_expr.arguments().push_back(xp);
	call_expr.lhs() = xp;
	tgt = temp_gp.add_instruction();
	tgt->make_function_call(call_expr);

	goto_inst->make_goto(tgt, true_exprt());
	goto_inst2->make_goto(tgt, true_exprt());

	auto expr = xp;
	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.round.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.round.f64");
	goto_functions.function_map["llvm.round.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.round.f64"].type = to_code_type(fn->type);
}

void translator::add_sin_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "sin::d");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(), "sin::ret");
	symbol_table.insert(sym2);
	auto ret = sym2.symbol_expr();

	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();

	tgt = temp_gp.add_instruction();
	tgt->make_decl();
	tgt->code = code_declt(ret);

	tgt = temp_gp.add_instruction();
	tgt->make_assignment(code_assignt(ret,
			side_effect_expr_nondett(ret.type(), tgt->source_location)));

	auto brnch_instr = temp_gp.add_instruction();

	tgt = temp_gp.add_instruction();
	tgt->make_assumption(isnan_exprt(ret));

	auto goto_instr = temp_gp.add_instruction();

	tgt = temp_gp.add_instruction();
	tgt->make_assumption(binary_relation_exprt(ret,
			ID_le,
			floatbv_typecast_exprt(from_integer(1, signed_int_type()),
					rounding_mode,
					double_type())));

	brnch_instr->make_goto(tgt,
			not_exprt(or_exprt(isinf_exprt(e1), isnan_exprt(e1))));

	tgt = temp_gp.add_instruction();
	tgt->make_assumption(binary_relation_exprt(ret,
			ID_ge,
			floatbv_typecast_exprt(from_integer(-1, signed_int_type()),
					rounding_mode,
					double_type())));
	tgt = temp_gp.add_instruction();
	tgt->make_assumption(or_exprt(ieee_float_notequal_exprt(e1,
			floatbv_typecast_exprt(from_integer(0, signed_int_type()),
					rounding_mode,
					double_type())),
			ieee_float_equal_exprt(ret,
					floatbv_typecast_exprt(from_integer(0, signed_int_type()),
							rounding_mode,
							double_type()))));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	auto cret = code_returnt(ret);
	tgt->code = cret;
	goto_instr->make_goto(tgt, true_exprt());

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "sin";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("sin");
	goto_functions.function_map["sin"].body.swap(temp_gp);
	goto_functions.function_map["sin"].type = to_code_type(fn->type);
}

void translator::add_cos_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "cos::d");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(), "cos::ret");
	symbol_table.insert(sym2);
	auto ret = sym2.symbol_expr();

	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();

	tgt = temp_gp.add_instruction();
	tgt->make_decl();
	tgt->code = code_declt(ret);

	tgt = temp_gp.add_instruction();
	tgt->make_assignment(code_assignt(ret,
			side_effect_expr_nondett(ret.type(), tgt->source_location)));

	auto brnch_instr = temp_gp.add_instruction();

	tgt = temp_gp.add_instruction();
	tgt->make_assumption(isnan_exprt(ret));

	auto goto_instr = temp_gp.add_instruction();

	tgt = temp_gp.add_instruction();
	tgt->make_assumption(binary_relation_exprt(ret,
			ID_le,
			floatbv_typecast_exprt(from_integer(1, signed_int_type()),
					rounding_mode,
					double_type())));

	brnch_instr->make_goto(tgt,
			not_exprt(or_exprt(isinf_exprt(e1), isnan_exprt(e1))));

	tgt = temp_gp.add_instruction();
	tgt->make_assumption(binary_relation_exprt(ret,
			ID_ge,
			floatbv_typecast_exprt(from_integer(-1, signed_int_type()),
					rounding_mode,
					double_type())));
	tgt = temp_gp.add_instruction();
	tgt->make_assumption(or_exprt(ieee_float_notequal_exprt(e1,
			floatbv_typecast_exprt(from_integer(0, signed_int_type()),
					rounding_mode,
					double_type())),
			ieee_float_equal_exprt(ret,
					floatbv_typecast_exprt(from_integer(1, signed_int_type()),
							rounding_mode,
							double_type()))));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	auto cret = code_returnt(ret);
	tgt->code = cret;
	goto_instr->make_goto(tgt, true_exprt());

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "cos";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("cos");
	goto_functions.function_map["cos"].body.swap(temp_gp);
	goto_functions.function_map["cos"].type = to_code_type(fn->type);
}

void translator::add_fmod_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "fmod::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto x = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(), "fmod::y");
	sym2.is_parameter = true;
	symbol_table.insert(sym2);
	auto y = sym2.symbol_expr();

	auto sym3 = symbol_util::create_symbol(double_type(), "fmod::ret");
	symbol_table.insert(sym3);
	auto ret = sym3.symbol_expr();

	auto rounding_mode = from_integer(ieee_floatt::ROUND_TO_ZERO,
			signed_int_type());

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_intrinsic_support("CPROVER__remainder");
	call_expr.function() =
			symbol_table.lookup("CPROVER__remainder")->symbol_expr();
	call_expr.arguments().push_back(rounding_mode);
	call_expr.arguments().push_back(x);
	call_expr.arguments().push_back(y);
	call_expr.lhs() = ret;
	tgt = temp_gp.add_instruction();
	tgt->make_function_call(call_expr);

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = ret;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	code_typet::parametert para2(sym2.type);
	para2.set_identifier(sym2.name);
	para2.set_base_name(sym2.base_name);
	parameters.push_back(para);
	parameters.push_back(para2);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "fmod";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("fmod");
	goto_functions.function_map["fmod"].body.swap(temp_gp);
	goto_functions.function_map["fmod"].type = to_code_type(fn->type);
}

void translator::add_fmodf_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(float_type(), "fmodf::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto x = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(float_type(), "fmodf::y");
	sym2.is_parameter = true;
	symbol_table.insert(sym2);
	auto y = sym2.symbol_expr();

	auto sym3 = symbol_util::create_symbol(float_type(), "fmodf::ret");
	symbol_table.insert(sym3);
	auto ret = sym3.symbol_expr();

	auto rounding_mode = from_integer(ieee_floatt::ROUND_TO_ZERO,
			signed_int_type());

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_intrinsic_support("CPROVER__remainderf");
	call_expr.function() =
			symbol_table.lookup("CPROVER__remainderf")->symbol_expr();
	call_expr.arguments().push_back(rounding_mode);
	call_expr.arguments().push_back(x);
	call_expr.arguments().push_back(y);
	call_expr.lhs() = ret;
	tgt = temp_gp.add_instruction();
	tgt->make_function_call(call_expr);

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = ret;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	code_typet::parametert para2(sym2.type);
	para2.set_identifier(sym2.name);
	para2.set_base_name(sym2.base_name);
	parameters.push_back(para);
	parameters.push_back(para2);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "fmodf";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("fmodf");
	goto_functions.function_map["fmodf"].body.swap(temp_gp);
	goto_functions.function_map["fmodf"].type = to_code_type(fn->type);
}

void translator::add_isnan_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "__isnan::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto expr = typecast_exprt(isnan_exprt(e1), signedbv_typet(32));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "__isnan";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("__isnan");
	goto_functions.function_map["__isnan"].body.swap(temp_gp);
	goto_functions.function_map["__isnan"].type = to_code_type(fn->type);
}

void translator::add_isnanf_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(float_type(), "__isnanf::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto expr = typecast_exprt(isnan_exprt(e1), signedbv_typet(32));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "__isnanf";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("__isnanf");
	goto_functions.function_map["__isnanf"].body.swap(temp_gp);
	goto_functions.function_map["__isnanf"].type = to_code_type(fn->type);
}

void translator::add_isnanl_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(ieee_float_spect::x86_80().to_type(),
			"__isnanl::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto expr = typecast_exprt(isnan_exprt(e1), signedbv_typet(32));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "__isnanl";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("__isnanl");
	goto_functions.function_map["__isnanl"].body.swap(temp_gp);
	goto_functions.function_map["__isnanl"].type = to_code_type(fn->type);
}
void translator::add_nan_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(pointer_type(signedbv_typet(8)),
			"nan::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	auto expr = ieee_float_op_exprt(from_integer(0, double_type()),
			ID_floatbv_div,
			from_integer(0, double_type()),
			rounding_mode);

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "nan";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("nan");
	goto_functions.function_map["nan"].body.swap(temp_gp);
	goto_functions.function_map["nan"].type = to_code_type(fn->type);
}

void translator::add_isinf_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "__isinf::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto expr = typecast_exprt(isinf_exprt(e1), signedbv_typet(32));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "__isinf";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("__isinf");
	goto_functions.function_map["__isinf"].body.swap(temp_gp);
	goto_functions.function_map["__isinf"].type = to_code_type(fn->type);
}

void translator::add_isinff_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(float_type(), "__isinff::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto expr = typecast_exprt(isinf_exprt(e1), signedbv_typet(32));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "__isinff";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("__isinff");
	goto_functions.function_map["__isinff"].body.swap(temp_gp);
	goto_functions.function_map["__isinff"].type = to_code_type(fn->type);
}

void translator::add_isinfl_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(ieee_float_spect::x86_80().to_type(),
			"__isinfl::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto expr = typecast_exprt(isinf_exprt(e1), signedbv_typet(32));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "__isinfl";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("__isinfl");
	goto_functions.function_map["__isinfl"].body.swap(temp_gp);
	goto_functions.function_map["__isinfl"].type = to_code_type(fn->type);
}

void translator::add_signbit_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "__signbit::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto expr = typecast_exprt(extractbit_exprt(e1,
			to_bitvector_type(e1.type()).get_width() - 1),
			signedbv_typet(32));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "__signbit";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("__signbit");
	goto_functions.function_map["__signbit"].body.swap(temp_gp);
	goto_functions.function_map["__signbit"].type = to_code_type(fn->type);
}

void translator::add_signbitf_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(float_type(), "__signbitf::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto expr = typecast_exprt(extractbit_exprt(e1,
			to_bitvector_type(e1.type()).get_width() - 1),
			signedbv_typet(32));

	tgt = temp_gp.add_instruction();
	tgt->make_return();
	code_returnt cret;
	cret.return_value() = expr;
	tgt->code = cret;

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, cret.return_value().type());
	sym.name = sym.base_name = sym.pretty_name = "__signbitf";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("__signbitf");
	goto_functions.function_map["__signbitf"].body.swap(temp_gp);
	goto_functions.function_map["__signbitf"].type = to_code_type(fn->type);
}

void translator::add_abort_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	tgt = temp_gp.add_instruction();
	tgt->make_assumption(false_exprt());

	tgt = temp_gp.add_instruction();
	tgt->make_end_function();

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	auto func_code_type = code_typet(parameters, void_type());
	sym.name = sym.base_name = sym.pretty_name = "abort";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("abort");
	goto_functions.function_map["abort"].body.swap(temp_gp);
	goto_functions.function_map["abort"].type = to_code_type(fn->type);
}

translator::intrinsics translator::get_intrinsic_id(const string &intrinsic_name) {
	if (!intrinsic_name.compare("__fpclassify"))
		return intrinsics::__fpclassify;
	if (!intrinsic_name.compare("__fpclassifyf"))
		return intrinsics::__fpclassifyf;
	if (!intrinsic_name.compare("__fpclassifyl"))
		return intrinsics::__fpclassifyl;
	if (!intrinsic_name.compare("fesetround")) return intrinsics::fesetround;
	if (!intrinsic_name.compare("fegetround")) return intrinsics::fegetround;
	if (!intrinsic_name.compare("fdim")) return intrinsics::fdim;
	if (!intrinsic_name.compare("fmod")) return intrinsics::fmod;
	if (!intrinsic_name.compare("fmodf")) return intrinsics::fmodf;
	if (!intrinsic_name.compare("remainder")) return intrinsics::remainder;
	if (!intrinsic_name.compare("lround")) return intrinsics::lround;
	if (!intrinsic_name.compare("llvm.memcpy.p0i8.p0i8.i64"))
		return intrinsics::llvm_memcpy_p0i8_p0i8_i64;
	if (!intrinsic_name.compare("llvm.memset.p0i8.i64"))
		return intrinsics::llvm_memset_p0i8_i64;
	if (!intrinsic_name.compare("llvm.trunc.f64"))
		return intrinsics::llvm_trunc_f64;
	if (!intrinsic_name.compare("llvm.fabs.f80"))
		return intrinsics::llvm_fabs_f80;
	if (!intrinsic_name.compare("llvm.fabs.f64"))
		return intrinsics::llvm_fabs_f64;
	if (!intrinsic_name.compare("llvm.fabs.f32"))
		return intrinsics::llvm_fabs_f32;
	if (!intrinsic_name.compare("llvm.floor.f64"))
		return intrinsics::llvm_floor_f64;
	if (!intrinsic_name.compare("llvm.ceil.f64"))
		return intrinsics::llvm_ceil_f64;
	if (!intrinsic_name.compare("llvm.rint.f64"))
		return intrinsics::llvm_rint_f64;
	if (!intrinsic_name.compare("llvm.nearbyint.f64"))
		return intrinsics::llvm_nearbyint_f64;
	if (!intrinsic_name.compare("llvm.round.f64"))
		return intrinsics::llvm_round_f64;
	if (!intrinsic_name.compare("llvm.copysign.f64"))
		return intrinsics::llvm_copysign_f64;
	if (!intrinsic_name.compare("llvm.maxnum.f64"))
		return intrinsics::llvm_maxnum_f64;
	if (!intrinsic_name.compare("llvm.minnum.f64"))
		return intrinsics::llvm_minnum_f64;
	if (!intrinsic_name.compare("sin")) return intrinsics::sin;
	if (!intrinsic_name.compare("cos")) return intrinsics::cos;
	if (!intrinsic_name.compare("modff")) return intrinsics::modff;
	if (!intrinsic_name.compare("lrint")) return intrinsics::lrint;
	if (!intrinsic_name.compare("nan")) return intrinsics::nan;
	if (!intrinsic_name.compare("__isinf")) return intrinsics::__isinf;
	if (!intrinsic_name.compare("__isinff")) return intrinsics::__isinff;
	if (!intrinsic_name.compare("__isinfl")) return intrinsics::__isinfl;
	if (!intrinsic_name.compare("__isnan")) return intrinsics::__isnan;
	if (!intrinsic_name.compare("__isnanf")) return intrinsics::__isnanf;
	if (!intrinsic_name.compare("__signbit")) return intrinsics::__signbit;
	if (!intrinsic_name.compare("__signbitf")) return intrinsics::__signbitf;
	if (!intrinsic_name.compare("abort")) return intrinsics::abort;
	if (!intrinsic_name.compare("malloc")) return intrinsics::malloc;
	if (!intrinsic_name.compare("calloc")) return intrinsics::calloc;
	if (!intrinsic_name.compare("free")) return intrinsics::free;
	if (!intrinsic_name.compare("CPROVER__round_to_integral"))
		return intrinsics::cprover_round_to_integral;
	if (!intrinsic_name.compare("CPROVER__round_to_integralf"))
		return intrinsics::cprover_round_to_integralf;
	if (!intrinsic_name.compare("CPROVER__remainder"))
		return intrinsics::cprover_remainder;
	if (!intrinsic_name.compare("CPROVER__remainderf"))
		return intrinsics::cprover_remainderf;
	return intrinsics::ll2gb_default;
}

bool translator::is_intrinsic_function(const string &intrinsic_name) {
	if (get_intrinsic_id(intrinsic_name) != intrinsics::ll2gb_default)
		return true;
	return false;
}

typet translator::get_intrinsic_return_type(const string &intrinsic_name) {
	if (is_intrinsic_function(intrinsic_name))
		return symbol_table.lookup(intrinsic_name)->type;
	error_state = "Return type requested for non intrinsic function";
	return void_type();
}

void translator::add_intrinsic_support(const string &func_name,
		bool reset_status) {
	static map<intrinsics, bool> support_added;
	if (reset_status) {
		support_added.clear();
		return;
	}
	if (support_added[get_intrinsic_id(func_name)]) return;

	support_added[get_intrinsic_id(func_name)] = true;

	switch (get_intrinsic_id(func_name)) {
	case intrinsics::__fpclassify:
		add_fpclassify_support();
		break;
	case intrinsics::__fpclassifyf:
		add_fpclassifyf_support();
		break;
	case intrinsics::__fpclassifyl:
		add_fpclassifyl_support();
		break;
	case intrinsics::__isinf:
		add_isinf_support();
		break;
	case intrinsics::__isinff:
		add_isinff_support();
		break;
	case intrinsics::__isinfl:
		add_isinfl_support();
		break;
	case intrinsics::__isnan:
		add_isnan_support();
		break;
	case intrinsics::__isnanf:
		add_isnanf_support();
		break;
	case intrinsics::__isnanl:
		add_isnanl_support();
		break;
	case intrinsics::__signbit:
		add_signbit_support();
		break;
	case intrinsics::__signbitf:
		add_signbitf_support();
		break;
	case intrinsics::abort:
		add_abort_support();
		break;
	case intrinsics::fdim:
		add_fdim_support();
		break;
	case intrinsics::fegetround:
		add_fegetround_support();
		break;
	case intrinsics::fesetround:
		add_fesetround_support();
		break;
	case intrinsics::fmod:
		add_fmod_support();
		break;
	case intrinsics::fmodf:
		add_fmodf_support();
		break;
	case intrinsics::lrint:
		add_lrint_support();
		break;
	case intrinsics::malloc:
		add_malloc_support();
		break;
	case intrinsics::calloc:
		add_calloc_support();
		break;
	case intrinsics::free:
		add_free_support();
		break;
	case intrinsics::modff:
		add_modff_support();
		break;
	case intrinsics::nan:
		add_nan_support();
		break;
	case intrinsics::remainder:
		add_remainder_support();
		break;
	case intrinsics::llvm_memset_p0i8_i64:
		add_llvm_memset_support();
		break;
	case intrinsics::llvm_memcpy_p0i8_p0i8_i64:
		add_llvm_memcpy_support();
		break;
	case intrinsics::llvm_trunc_f64:
		add_trunc_support();
		break;
	case intrinsics::lround:
		add_lround_support();
		break;
	case intrinsics::llvm_fabs_f80:
		add_fabs80_support();
		break;
	case intrinsics::llvm_fabs_f64:
		add_fabs_support();
		break;
	case intrinsics::llvm_fabs_f32:
		add_fabs32_support();
		break;
	case intrinsics::llvm_floor_f64:
		add_floor_support();
		break;
	case intrinsics::llvm_ceil_f64:
		add_ceil_support();
		break;
	case intrinsics::llvm_round_f64:
		add_round_support();
		break;
	case intrinsics::llvm_rint_f64:
		add_llvm_rint_support();
		break;
	case intrinsics::llvm_nearbyint_f64:
		add_llvm_nearbyint_support();
		break;
	case intrinsics::llvm_copysign_f64:
		add_copysign_support();
		break;
	case intrinsics::llvm_maxnum_f64:
		add_maxnum_support();
		break;
	case intrinsics::llvm_minnum_f64:
		add_minnum_support();
		break;
	case intrinsics::sin:
		add_sin_support();
		break;
	case intrinsics::cos:
		add_cos_support();
		break;
	case intrinsics::cprover_round_to_integral:
		add_round_to_integral_support();
		break;
	case intrinsics::cprover_round_to_integralf:
		add_round_to_integralf_support();
		break;
	case intrinsics::cprover_remainder:
		add_cprover_remainder_support();
		break;
	case intrinsics::cprover_remainderf:
		add_cprover_remainderf_support();
		break;
	default:
		error_state = "Intrinsic support requested for unkown func - "
				+ func_name;
	}
}
