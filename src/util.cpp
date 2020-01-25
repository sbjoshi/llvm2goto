/*
 * util.cpp
 *
 *  Created on: 16-Aug-2019
 *      Author: Akash Banerjee
 */

#include "ll2gb.h"
#include "translator.h"
#include <signal.h>

using namespace std;
using namespace llvm;
using namespace ll2gb;

unsigned ll2gb::verbose = 0;

void ll2gb::print_help() {
	outs() << "Version: 2.0\n"
			<< "    Usage: ll2gb <ir_file> -o <op_file_name>\n"
			<< "           ll2gb <ir_file_1> <ir_file_2> ...\n";
	exit(1);
}

void ll2gb::parse_input(int argc,
		char **argv,
		vector<pair<string, string>> &file_names) {

	if (argc < 2) {
		print_help();
	}
	if (!string(argv[1]).compare("-h") || !string(argv[1]).compare("--help"))
		print_help();

	if (argc == 4) {
		if (!string(argv[1]).compare("-o")) {
			file_names.push_back(make_pair(argv[3], argv[2]));
		}
		else if (!string(argv[2]).compare("-o")) {
			file_names.push_back(make_pair(argv[1], argv[3]));
		}
		else if (!string(argv[1]).compare("-v") || !string(argv[2]).compare("-v"))
			goto L1;
		else
			print_help();
	}
	else {
		L1: string out_file;
		for (auto i = 1; i < argc; i++) {
			string temp(argv[i]);
			if (!temp.compare("-o")) {
				if (argc > i + 1) {
					out_file = argv[i + 1];
					i++;
				}
				else {
					print_help();
				}
				continue;
			}
			if (!temp.compare("-v")) {
				if (argc > i + 1) {
					char *p;
					auto t = strtoul(argv[i + 1], &p, 10);
					if (*p) {
						verbose = 1;
					}
					else {
						verbose = t;
						i++;
					}
				}
				else {
					verbose = 1;
				}
				continue;
			}
			if (!out_file.empty()) {
				file_names.push_back(make_pair(argv[i], out_file));
				out_file.clear();
			}
			else {
				auto index = temp.find(".ll");
				if (index != temp.npos)
					file_names.push_back(make_pair(argv[i],
							string(argv[i]).substr(0, index) + ".gb"));
				else
					file_names.push_back(make_pair(argv[i], temp + ".gb"));
			}
		}
	}
}

void ll2gb::set_function_symbol_value(goto_functionst::function_mapt &function_map,
		symbol_tablet &symbol_table) {
	for (typename goto_functionst::function_mapt::iterator it =
			function_map.begin(); it != function_map.end(); it++) {
		goto_programt::instructionst instructions = it->second.body.instructions;
		code_blockt cb;
		for (goto_programt::targett ins = instructions.begin();
				ins != instructions.end(); ins++) {
			cb.add(ins->code);
		}
		symbolt *symbol = const_cast<symbolt*>(symbol_table.lookup(it->first));
		symbol->value.swap(cb);
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

void ll2gb::add_function_definitions(string name,
		goto_functionst &goto_functions,
		symbol_tablet &symbol_table) {
	goto_programt gp;
	code_blockt cb = to_code_block(to_code(symbol_table.lookup(name)->value));
	for (unsigned int b = 0; b < cb.operands().size(); b++) {
		goto_programt::targett ins = gp.add_instruction();
		codet c = to_code(cb.operands()[b]);
		if (ID_assign == c.get_statement()) {
			ins->make_assignment();
			ins->code = code_assignt(c.operands()[0], c.operands()[1]);
		}
		else if (ID_output == c.get_statement()) {
			c.operands().resize(2);

			const symbolt &return_symbol = *symbol_table.lookup("return'");

			c.op0() =
					address_of_exprt(index_exprt(string_constantt(return_symbol.base_name),
							from_integer(0, index_type())));

			c.op1() = return_symbol.symbol_expr();
			ins->make_other(c);
		}
		else if (ID_label == c.get_statement()) {
			ins->make_skip();
		}
		else if (ID_function_call == c.get_statement()) {
			ins->make_function_call(c);
		}
		else if (ID_input == c.get_statement()) {
			c.operands().resize(2);
			c.op0() = address_of_exprt(index_exprt(string_constantt("argc"),
					from_integer(0, index_type())));
			c.op1() = symbol_table.lookup("argc'")->symbol_expr();
			ins->make_other(c);
		}
		else if (ID_assume == c.get_statement()) {
			ins->make_assumption(c.op0());
		}
		else {
			ins->code = c;
		}
	}
	gp.add_instruction(END_FUNCTION);
	gp.update();
	(*goto_functions.function_map.find(name)).second.body.swap(gp);
}

void ll2gb::set_entry_point(goto_functionst &goto_functions,
		symbol_tablet &symbol_table) {
	set_function_symbol_value(goto_functions.function_map, symbol_table);
	int argc = 0;
	const char **argv = nullptr;
	cbmc_parse_optionst parse_options(argc, argv);
	c_object_factory_parameterst object_factory_params;
	optionst options;
	parse_options.set_default_options(options);
	object_factory_params.set(options);
	parse_options.get_message_handler();
	ansi_c_entry_point(symbol_table,
			parse_options.get_message_handler(),
			object_factory_params);
	goto_functions.function_map.insert(pair<const dstringt,
			goto_functionst::goto_functiont>("__CPROVER__start",
			goto_functionst::goto_functiont()));
	add_function_definitions("__CPROVER__start", goto_functions, symbol_table);
	goto_functions.function_map.insert(pair<const dstringt,
			goto_functionst::goto_functiont>(
	INITIALIZE_FUNCTION, goto_functionst::goto_functiont()));
	add_function_definitions(INITIALIZE_FUNCTION, goto_functions, symbol_table);
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
	sym.is_parameter = true;
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
	tgt->code = code_assignt(cp_de_alloc_expr,
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
	tgt->code = code_assignt(symbol_table.lookup("record_malloc")->symbol_expr(),
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
	tgt->code = code_assignt(cp_malloc_size_expr,
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
					pointer_typet(signedbv_typet(8), config.ansi_c.pointer_width));
	tgt->code = cret;

	tgt = malloc_gp.add_instruction();
	tgt->make_dead();
	tgt->code = code_deadt(symbol_table.lookup("record_may_leak")->symbol_expr());

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

bool translator::is_intrinsic_function(const string &intrinsic_name) {
	if (intrinsic_name.find("__fpclassify") != string::npos) return true;
	if (!intrinsic_name.compare("fesetround")) return true;
	if (!intrinsic_name.compare("fegetround")) return true;
	if (!intrinsic_name.compare("fdim")) return true;
	if (intrinsic_name.find("__isinf") != string::npos) return true;
	if (intrinsic_name.find("__isnan") != string::npos) return true;
	if (intrinsic_name.find("__signbit") != string::npos) return true;
	if (!intrinsic_name.compare("abort")) return true;
	return false;
}

exprt translator::get_intrinsics(const string &intrinsic_name,
		const vector<exprt> &args,
		const symbol_tablet &symbol_table,
		goto_programt &goto_program) {
	exprt expr;
	if (intrinsic_name.find("__fpclassify") != string::npos) {
		auto e = args[0];
		expr = ternary_exprt(ID_if,
				isnan_exprt(e),
				from_integer(0, signedbv_typet(32)),
				ternary_exprt(ID_if,
						isinf_exprt(e),
						from_integer(1, signedbv_typet(32)),
						ternary_exprt(ID_if,
								isnormal_exprt(e),
								from_integer(4, signedbv_typet(32)),
								ternary_exprt(ID_if,
										ieee_float_equal_exprt(e, from_integer(0, e.type())),
										from_integer(2, signedbv_typet(32)),
										from_integer(3, signedbv_typet(32)),
										signedbv_typet(32)),
								signedbv_typet(32)),
						signedbv_typet(32)),
				signedbv_typet(32));
	}
	else if (!intrinsic_name.compare("fesetround")) {
		auto e = args[0];
		auto rnd_mod =
				symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
		expr = ternary_exprt(ID_if,
				equal_exprt(e, from_integer(0x400, e.type())),
				from_integer(1, e.type()),
				ternary_exprt(ID_if,
						equal_exprt(e, from_integer(0, e.type())),
						from_integer(0, e.type()),
						ternary_exprt(ID_if,
								equal_exprt(e, from_integer(0xc00, e.type())),
								from_integer(3, e.type()),
								ternary_exprt(ID_if,
										equal_exprt(e, from_integer(0x800, e.type())),
										from_integer(2, e.type()),
										from_integer(0, e.type()),
										e.type()),
								e.type()),
						e.type()),
				e.type());
		auto asgn_inst = goto_program.add_instruction();
		asgn_inst->make_assignment();
		asgn_inst->code = code_assignt(rnd_mod, expr);
		expr = from_integer(0, e.type());
		goto_program.update();
	}
	else if (!intrinsic_name.compare("fegetround")) {
		auto rounding =
				symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
		expr = ternary_exprt(ID_if,
				equal_exprt(rounding, from_integer(1, rounding.type())),
				from_integer(0x400, rounding.type()),
				ternary_exprt(ID_if,
						equal_exprt(rounding, from_integer(0, rounding.type())),
						from_integer(0, rounding.type()),
						ternary_exprt(ID_if,
								equal_exprt(rounding, from_integer(3, rounding.type())),
								from_integer(0xc00, rounding.type()),
								ternary_exprt(ID_if,
										equal_exprt(rounding, from_integer(2, rounding.type())),
										from_integer(0x800, rounding.type()),
										from_integer(-1, rounding.type()),
										rounding.type()),
								rounding.type()),
						rounding.type()),
				rounding.type());
	}
	else if (!intrinsic_name.compare("fdim")) {
		auto e1 = args[0];
		auto e2 = args[1];
		auto rounding_mode =
				symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
		expr = ternary_exprt(ID_if,
				binary_relation_exprt(e1, ID_gt, e2),
				ieee_float_op_exprt(e1, ID_floatbv_minus, e2, rounding_mode),
				from_integer(0, e1.type()),
				e1.type());
	}
	else if (intrinsic_name.find("__isinf") != string::npos) {
		auto e = args[0];
		expr = typecast_exprt(isinf_exprt(e), signedbv_typet(32));
	}
	else if (intrinsic_name.find("__isnan") != string::npos) {
		auto e = args[0];
		expr = typecast_exprt(isnan_exprt(e), signedbv_typet(32));
	}
	else if (intrinsic_name.find("__signbit") != string::npos) {
		auto e = args[0];
		expr = typecast_exprt(extractbit_exprt(e,
				to_bitvector_type(e.type()).get_width() - 1),
				signedbv_typet(32));
	}
	else if (!intrinsic_name.compare("abort")) {
		auto assume_instr = goto_program.add_instruction();
		assume_instr->make_assumption(false_exprt());
		goto_program.update();
	}
	else {
		translator::error_state = "Unreachable in func ll2gb::get_intrinsics";
	}
	return expr;
}
