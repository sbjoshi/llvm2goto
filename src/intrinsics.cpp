/*
 * intrinsics.cpp
 *
 *  Created on: 25-Jan-2021
 *      Author: akash
 */

#include "ll2gb.h"
#include "translator.h"
#include "symbol_util.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

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

	auto br_inst = temp_gp.add_instruction(GOTO);

	auto sym5 = symbol_util::create_symbol(array_typet(signedbv_typet(8), len),
			"llvm.memcpy.p0i8.p0i8.i64::new_arr");
	symbol_table.insert(sym5);
	auto new_arr = sym5.symbol_expr();

	tgt = temp_gp.add(goto_programt::make_decl(code_declt(new_arr)));

	auto array_copy_code = codet(ID_array_copy);
	array_copy_code.operands().push_back(
			typecast_exprt(address_of_exprt(new_arr),
					pointer_type(signedbv_typet(8))));
	array_copy_code.operands().push_back(src);
	tgt = temp_gp.add(goto_programt::make_other(array_copy_code));

	auto array_replace_code = codet(ID_array_replace);
	array_replace_code.operands().push_back(dest);
	array_replace_code.operands().push_back(
			typecast_exprt(address_of_exprt(new_arr),
					pointer_type(signedbv_typet(8))));
	tgt = temp_gp.add(goto_programt::make_other(array_replace_code));

	tgt = temp_gp.add_instruction(END_FUNCTION);

	br_inst->set_target(tgt);
	br_inst->set_condition(
			not_exprt(
					binary_relation_exprt(len, ID_gt,
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
	goto_functions.function_map["llvm.memcpy.p0i8.p0i8.i64"].set_parameter_identifiers(
			to_code_type(fn->type));
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

	auto br_inst = temp_gp.add_instruction(GOTO);

	auto new_arr_sym = symbol_util::create_symbol(
			array_typet(signedbv_typet(8), len),
			"llvm.memset.p0i8.i64::new_arr");
	symbol_table.insert(new_arr_sym);
	auto new_arr = typecast_exprt(address_of_exprt(new_arr_sym.symbol_expr()),
			pointer_type(signedbv_typet(8)));

	tgt = temp_gp.add(
			goto_programt::make_decl(code_declt(new_arr_sym.symbol_expr())));

	auto array_set_code = codet(ID_array_set);
	array_set_code.operands().push_back(new_arr);
	array_set_code.operands().push_back(val);
	tgt = temp_gp.add(goto_programt::make_other(array_set_code));

	auto array_replace_code = codet(ID_array_replace);
	array_replace_code.operands().push_back(dest);
	array_replace_code.operands().push_back(new_arr);
	tgt = temp_gp.add(goto_programt::make_other(array_replace_code));

	tgt = temp_gp.add_instruction(END_FUNCTION);

	br_inst->set_target(tgt);
	br_inst->set_condition(
			not_exprt(
					binary_relation_exprt(len, ID_gt,
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
	goto_functions.function_map["llvm.memset.p0i8.i64"].set_parameter_identifiers(
			to_code_type(fn->type));
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
	tgt = temp_gp.add(goto_programt::make_decl(rti));

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_llvm_intrinsic_support("CPROVER__round_to_integral");
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(rounding_mode);
	call_expr.arguments().push_back(e1);
	call_expr.lhs() = rti;
	tgt = temp_gp.add(goto_programt::make_function_call(call_expr));

	auto expr = rti;
	temp_gp.add(goto_programt::make_set_return_value(expr));

	tgt = temp_gp.add_instruction(END_FUNCTION);

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, expr.type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.rint.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.rint.f64");
	goto_functions.function_map["llvm.rint.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.rint.f64"].set_parameter_identifiers(
			to_code_type(fn->type));
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
	tgt = temp_gp.add(goto_programt::make_decl(rti));

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_llvm_intrinsic_support("CPROVER__round_to_integral");
	auto rounding_mode =
			symbol_table.lookup("__CPROVER_rounding_mode")->symbol_expr();
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(rounding_mode);
	call_expr.arguments().push_back(e1);
	call_expr.lhs() = rti;
	tgt = temp_gp.add(goto_programt::make_function_call(call_expr));

	auto expr = rti;
	temp_gp.add(goto_programt::make_set_return_value(expr));

	tgt = temp_gp.add_instruction(END_FUNCTION);

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, expr.type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.nearbyint.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.nearbyint.f64");
	goto_functions.function_map["llvm.nearbyint.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.nearbyint.f64"].set_parameter_identifiers(
			to_code_type(fn->type));
}

void translator::add_llvm_trunc_support() {
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
	add_llvm_intrinsic_support("CPROVER__round_to_integral");
	auto rounding_mode = from_integer(ieee_floatt::ROUND_TO_ZERO,
			signed_int_type());
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(rounding_mode);
	call_expr.arguments().push_back(x);
	call_expr.lhs() = ret;
	tgt = temp_gp.add(goto_programt::make_function_call(call_expr));

	auto expr = ret;
	temp_gp.add(goto_programt::make_set_return_value(expr));

	tgt = temp_gp.add_instruction(END_FUNCTION);

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, expr.type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.trunc.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.trunc.f64");
	goto_functions.function_map["llvm.trunc.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.trunc.f64"].set_parameter_identifiers(
			to_code_type(fn->type));
}

void translator::add_llvm_fabs_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "llvm.fabs.f64::d");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto expr = abs_exprt(e1);
	temp_gp.add(goto_programt::make_set_return_value(expr));

	tgt = temp_gp.add_instruction(END_FUNCTION);

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, expr.type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.fabs.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.fabs.f64");
	goto_functions.function_map["llvm.fabs.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.fabs.f64"].set_parameter_identifiers(
			to_code_type(fn->type));
}

void translator::add_llvm_fabs80_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(ieee_float_spect::x86_80().to_type(),
			"llvm.fabs.f80::d");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto expr = abs_exprt(e1);
	temp_gp.add(goto_programt::make_set_return_value(expr));

	tgt = temp_gp.add_instruction(END_FUNCTION);

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, expr.type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.fabs.f80";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.fabs.f80");
	goto_functions.function_map["llvm.fabs.f80"].body.swap(temp_gp);
	goto_functions.function_map["llvm.fabs.f80"].set_parameter_identifiers(
			to_code_type(fn->type));
}

void translator::add_llvm_fabs32_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(float_type(), "llvm.fabs.f32::d");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto expr = abs_exprt(e1);
	temp_gp.add(goto_programt::make_set_return_value(expr));

	tgt = temp_gp.add_instruction(END_FUNCTION);

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, expr.type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.fabs.f32";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.fabs.f32");
	goto_functions.function_map["llvm.fabs.f32"].body.swap(temp_gp);
	goto_functions.function_map["llvm.fabs.f32"].set_parameter_identifiers(
			to_code_type(fn->type));
}

void translator::add_llvm_copysign_support() {
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
			unary_minus_exprt(abs_exprt(x)), abs_exprt(x), x.type());
	temp_gp.add(goto_programt::make_set_return_value(expr));

	tgt = temp_gp.add_instruction(END_FUNCTION);

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
	auto func_code_type = code_typet(parameters, expr.type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.copysign.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.copysign.f64");
	goto_functions.function_map["llvm.copysign.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.copysign.f64"].set_parameter_identifiers(
			to_code_type(fn->type));
}

void translator::add_llvm_maxnum_support() {
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
	auto expr = ternary_exprt(ID_if, binary_relation_exprt(x, ID_gt, y), x, y,
			double_type());
	temp_gp.add(goto_programt::make_set_return_value(expr));

	tgt = temp_gp.add_instruction(END_FUNCTION);

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
	auto func_code_type = code_typet(parameters, expr.type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.maxnum.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.maxnum.f64");
	goto_functions.function_map["llvm.maxnum.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.maxnum.f64"].set_parameter_identifiers(
			to_code_type(fn->type));
}

void translator::add_llvm_minnum_support() {
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
	auto expr = ternary_exprt(ID_if, binary_relation_exprt(x, ID_lt, y), x, y,
			double_type());
	temp_gp.add(goto_programt::make_set_return_value(expr));

	tgt = temp_gp.add_instruction(END_FUNCTION);

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
	auto func_code_type = code_typet(parameters, expr.type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.minnum.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.minnum.f64");
	goto_functions.function_map["llvm.minnum.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.minnum.f64"].set_parameter_identifiers(
			to_code_type(fn->type));
}

void translator::add_llvm_floor_support() {
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
	tgt = temp_gp.add(goto_programt::make_decl(sym2.symbol_expr()));

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_llvm_intrinsic_support("CPROVER__round_to_integral");
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(
			from_integer(ieee_floatt::ROUND_TO_MINUS_INF, signed_int_type()));
	call_expr.arguments().push_back(e1);
	call_expr.lhs() = rti;
	tgt = temp_gp.add(goto_programt::make_function_call(call_expr));

	auto expr = rti;
	temp_gp.add(goto_programt::make_set_return_value(expr));

	tgt = temp_gp.add_instruction(END_FUNCTION);

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, expr.type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.floor.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.floor.f64");
	goto_functions.function_map["llvm.floor.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.floor.f64"].set_parameter_identifiers(
			to_code_type(fn->type));
}

void translator::add_llvm_ceil_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "llvm.ceil.f64::d");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(), "llvm.ceil.f64::ret");
	symbol_table.insert(sym2);
	auto ret = sym2.symbol_expr();
	tgt = temp_gp.add(goto_programt::make_decl(sym2.symbol_expr()));

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_llvm_intrinsic_support("CPROVER__round_to_integral");
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(
			from_integer(ieee_floatt::ROUND_TO_PLUS_INF, signed_int_type()));
	call_expr.arguments().push_back(e1);
	call_expr.lhs() = ret;
	tgt = temp_gp.add(goto_programt::make_function_call(call_expr));

	auto expr = ret;
	temp_gp.add(goto_programt::make_set_return_value(expr));

	tgt = temp_gp.add_instruction(END_FUNCTION);

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, expr.type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.ceil.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.ceil.f64");
	goto_functions.function_map["llvm.ceil.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.ceil.f64"].set_parameter_identifiers(
			to_code_type(fn->type));
}

void translator::add_llvm_round_support() {
	goto_programt temp_gp;
	goto_programt::targett tgt;

	auto sym1 = symbol_util::create_symbol(double_type(), "llvm.round.f64::x");
	sym1.is_parameter = true;
	symbol_table.insert(sym1);
	auto e1 = sym1.symbol_expr();

	auto sym2 = symbol_util::create_symbol(double_type(), "llvm.round.f64::xp");
	symbol_table.insert(sym2);
	auto xp = sym2.symbol_expr();
	tgt = temp_gp.add(goto_programt::make_decl(sym2.symbol_expr()));

	auto br_inst = temp_gp.add_instruction(GOTO);
	ieee_floatt half_double;
	half_double.from_double(0.5);
	temp_gp.add(
			goto_programt::make_assignment(xp,
					ieee_float_op_exprt(e1, ID_floatbv_plus,
							half_double.to_expr(),
							from_integer(ieee_floatt::ROUND_TO_ZERO,
									signed_int_type()))));

	auto goto_inst = temp_gp.add_instruction(GOTO);

	auto br_inst2 = temp_gp.add_instruction(GOTO);
	br_inst->set_target(br_inst2);
	br_inst->set_condition(
			not_exprt(
					binary_relation_exprt(e1, ID_gt,
							from_integer(0, e1.type()))));

	temp_gp.add(
			goto_programt::make_assignment(xp,
					ieee_float_op_exprt(e1, ID_floatbv_minus,
							half_double.to_expr(),
							from_integer(ieee_floatt::ROUND_TO_ZERO,
									signed_int_type()))));
	auto goto_inst2 = temp_gp.add_instruction(GOTO);

	temp_gp.add(goto_programt::make_assignment(xp, e1));

	br_inst2->set_target(tgt);
	br_inst2->set_condition(
			not_exprt(
					binary_relation_exprt(e1, ID_lt,
							from_integer(0, e1.type()))));

	exprt temp_expr;
	code_function_callt call_expr(temp_expr);
	add_llvm_intrinsic_support("CPROVER__round_to_integral");
	call_expr.function() =
			symbol_table.lookup("CPROVER__round_to_integral")->symbol_expr();
	call_expr.arguments().push_back(
			from_integer(ieee_floatt::ROUND_TO_ZERO, signed_int_type()));
	call_expr.arguments().push_back(xp);
	call_expr.lhs() = xp;
	tgt = temp_gp.add(goto_programt::make_function_call(call_expr));

	goto_inst->set_target(tgt);
	goto_inst->set_condition(true_exprt());
	goto_inst2->set_target(tgt);
	goto_inst2->set_condition(true_exprt());

	auto expr = xp;
	temp_gp.add(goto_programt::make_set_return_value(expr));

	tgt = temp_gp.add_instruction(END_FUNCTION);

	temp_gp.update();

	symbolt sym;
	code_typet::parameterst parameters;
	code_typet::parametert para(sym1.type);
	para.set_identifier(sym1.name);
	para.set_base_name(sym1.base_name);
	parameters.push_back(para);
	auto func_code_type = code_typet(parameters, expr.type());
	sym.name = sym.base_name = sym.pretty_name = "llvm.round.f64";
	sym.is_thread_local = false;
	sym.mode = ID_C;
	sym.is_lvalue = true;
	sym.type = func_code_type;
	symbol_table.add(sym);

	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();

	const auto *fn = symbol_table.lookup("llvm.round.f64");
	goto_functions.function_map["llvm.round.f64"].body.swap(temp_gp);
	goto_functions.function_map["llvm.round.f64"].set_parameter_identifiers(
			to_code_type(fn->type));
}

translator::intrinsics translator::get_intrinsic_id(
		const string &intrinsic_name) {
	if (!intrinsic_name.compare("__fpclassify"))
		return intrinsics::__fpclassify;
	if (!intrinsic_name.compare("__fpclassifyf"))
		return intrinsics::__fpclassifyf;
	if (!intrinsic_name.compare("__fpclassifyl"))
		return intrinsics::__fpclassifyl;
	if (!intrinsic_name.compare("fesetround"))
		return intrinsics::fesetround;
	if (!intrinsic_name.compare("fegetround"))
		return intrinsics::fegetround;
	if (!intrinsic_name.compare("fdim"))
		return intrinsics::fdim;
	if (!intrinsic_name.compare("fmod"))
		return intrinsics::fmod;
	if (!intrinsic_name.compare("fmodf"))
		return intrinsics::fmodf;
	if (!intrinsic_name.compare("remainder"))
		return intrinsics::remainder;
	if (!intrinsic_name.compare("lround"))
		return intrinsics::lround;
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
	if (!intrinsic_name.compare("sin"))
		return intrinsics::sin;
	if (!intrinsic_name.compare("cos"))
		return intrinsics::cos;
	if (!intrinsic_name.compare("modff"))
		return intrinsics::modff;
	if (!intrinsic_name.compare("lrint"))
		return intrinsics::lrint;
	if (!intrinsic_name.compare("nan"))
		return intrinsics::nan;
	if (!intrinsic_name.compare("__isinf"))
		return intrinsics::__isinf;
	if (!intrinsic_name.compare("__isinff"))
		return intrinsics::__isinff;
	if (!intrinsic_name.compare("__isinfl"))
		return intrinsics::__isinfl;
	if (!intrinsic_name.compare("__isnan"))
		return intrinsics::__isnan;
	if (!intrinsic_name.compare("__isnanf"))
		return intrinsics::__isnanf;
	if (!intrinsic_name.compare("__signbit"))
		return intrinsics::__signbit;
	if (!intrinsic_name.compare("__signbitf"))
		return intrinsics::__signbitf;
	if (!intrinsic_name.compare("abort"))
		return intrinsics::abort;
	if (!intrinsic_name.compare("malloc"))
		return intrinsics::malloc;
	if (!intrinsic_name.compare("calloc"))
		return intrinsics::calloc;
	if (!intrinsic_name.compare("free"))
		return intrinsics::free;
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

void translator::add_intrinsic_support(const llvm::Function &F) {
	auto func_name = F.getName().str();
	if (intrinsic_support_added[get_intrinsic_id(func_name)])
		return;

	intrinsic_support_added[get_intrinsic_id(func_name)] = true;

	config.ansi_c.lib = configt::ansi_ct::libt::LIB_FULL;
	symbol_table.insert(symbol_util::create_goto_func_symbol(F));
	std::set<irep_idt> functions;
	functions.insert(func_name);
	cprover_c_library_factory(functions, symbol_table, msg_handler);
}

void translator::add_llvm_intrinsic_support(const string &func_name) {
	if (intrinsic_support_added[get_intrinsic_id(func_name)])
		return;

	intrinsic_support_added[get_intrinsic_id(func_name)] = true;
	config.ansi_c.lib = configt::ansi_ct::libt::LIB_FULL;

	switch (get_intrinsic_id(func_name)) {
	case intrinsics::llvm_memset_p0i8_i64:
		add_llvm_memset_support();
		break;
	case intrinsics::llvm_memcpy_p0i8_p0i8_i64:
		add_llvm_memcpy_support();
		break;
	case intrinsics::llvm_rint_f64:
		add_llvm_rint_support();
		break;
	case intrinsics::llvm_nearbyint_f64:
		add_llvm_nearbyint_support();
		break;
	case intrinsics::llvm_trunc_f64:
		add_llvm_trunc_support();
		break;
	case intrinsics::llvm_fabs_f80:
		add_llvm_fabs80_support();
		break;
	case intrinsics::llvm_fabs_f64:
		add_llvm_fabs_support();
		break;
	case intrinsics::llvm_fabs_f32:
		add_llvm_fabs32_support();
		break;
	case intrinsics::llvm_floor_f64:
		add_llvm_floor_support();
		break;
	case intrinsics::llvm_ceil_f64:
		add_llvm_ceil_support();
		break;
	case intrinsics::llvm_round_f64:
		add_llvm_round_support();
		break;
	case intrinsics::llvm_copysign_f64:
		add_llvm_copysign_support();
		break;
	case intrinsics::llvm_maxnum_f64:
		add_llvm_maxnum_support();
		break;
	case intrinsics::llvm_minnum_f64:
		add_llvm_minnum_support();
		break;
	case intrinsics::cprover_round_to_integral: {
		config.ansi_c.lib = configt::ansi_ct::libt::LIB_FULL;
		symbolt sym;
		sym.name = sym.base_name = sym.pretty_name = func_name;
		sym.type = code_typet(code_typet::parameterst(), void_type());
		symbol_table.insert(sym);
		std::set<irep_idt> functions;
		functions.insert(func_name);
		cprover_c_library_factory(functions, symbol_table, msg_handler);
		break;
	}
	case intrinsics::cprover_round_to_integralf: {
		config.ansi_c.lib = configt::ansi_ct::libt::LIB_FULL;
		symbolt sym;
		sym.name = sym.base_name = sym.pretty_name = func_name;
		sym.type = code_typet(code_typet::parameterst(), void_type());
		symbol_table.insert(sym);
		std::set<irep_idt> functions;
		functions.insert(func_name);
		cprover_c_library_factory(functions, symbol_table, msg_handler);
		break;
	}
	default:
		error_state = "Intrinsic support requested for unkown func - "
				+ func_name;
	}
}
//}
//
//void translator::add_round_to_integralf_support() {
//	goto_programt temp_gp;
//	goto_programt::targett tgt;
//
//	auto sym1 = symbol_util::create_symbol(signed_int_type(),
//			"CPROVER__round_to_integralf::rnd_mode");
//	sym1.is_parameter = true;
//	symbol_table.insert(sym1);
//	auto rnd_mode = sym1.symbol_expr();
//
//	auto sym2 = symbol_util::create_symbol(float_type(),
//			"CPROVER__round_to_integralf::f");
//	sym2.is_parameter = true;
//	symbol_table.insert(sym2);
//	auto f = sym2.symbol_expr();
//
//	exprt rounding = rnd_mode;
//	ieee_floatt magic_const(ieee_float_spect::single_precision().to_type());
//	float mgc_const_bit = 0x4B000000;
//	magic_const.from_float(mgc_const_bit);
//	auto mgc_cnst_expr = magic_const.to_expr();
//	auto expr = ternary_exprt(ID_if,
//			binary_relation_exprt(abs_exprt(f), ID_ge, mgc_cnst_expr), f,
//			ternary_exprt(ID_if,
//					ieee_float_equal_exprt(f, from_integer(0, f.type())), f,
//					ternary_exprt(ID_if,
//							extractbit_exprt(f,
//									to_bitvector_type(f.type()).get_width()
//											- 1),
//							ieee_float_op_exprt(
//									ieee_float_op_exprt(f, ID_floatbv_minus,
//											mgc_cnst_expr, rounding),
//									ID_floatbv_plus, mgc_cnst_expr, rounding),
//							ieee_float_op_exprt(
//									ieee_float_op_exprt(f, ID_floatbv_plus,
//											mgc_cnst_expr, rounding),
//									ID_floatbv_minus, mgc_cnst_expr, rounding),
//							f.type()), f.type()), f.type());
//	temp_gp.add(goto_programt::make_set_return_value(expr));
//
//	tgt = temp_gp.add_instruction(END_FUNCTION);
//
//	temp_gp.update();
//
//	symbolt sym;
//	code_typet::parameterst parameters;
//	code_typet::parametert para(sym1.type);
//	para.set_identifier(sym1.name);
//	para.set_base_name(sym1.base_name);
//	code_typet::parametert para2(sym2.type);
//	para2.set_identifier(sym2.name);
//	para2.set_base_name(sym2.base_name);
//	parameters.push_back(para);
//	parameters.push_back(para2);
//	auto func_code_type = code_typet(parameters, expr.type());
//	sym.name = sym.base_name = sym.pretty_name = "CPROVER__round_to_integralf";
//	sym.is_thread_local = false;
//	sym.mode = ID_C;
//	sym.is_lvalue = true;
//	sym.type = func_code_type;
//	symbol_table.add(sym);
//
//	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();
//
//	const auto *fn = symbol_table.lookup("CPROVER__round_to_integralf");
//	goto_functions.function_map["CPROVER__round_to_integralf"].body.swap(
//			temp_gp);
//	goto_functions.function_map["CPROVER__round_to_integralf"].set_parameter_identifiers(
//			to_code_type(fn->type));
//}
//
//void translator::add_round_to_integral_support() {
//	goto_programt temp_gp;
//	goto_programt::targett tgt;
//
//	auto sym1 = symbol_util::create_symbol(signed_int_type(),
//			"CPROVER__round_to_integral::rnd_mode");
//	sym1.is_parameter = true;
//	symbol_table.insert(sym1);
//	auto rnd_mode = sym1.symbol_expr();
//
//	auto sym2 = symbol_util::create_symbol(double_type(),
//			"CPROVER__round_to_integral::d");
//	sym2.is_parameter = true;
//	symbol_table.insert(sym2);
//	auto d = sym2.symbol_expr();
//
//	exprt rounding = rnd_mode;
//	ieee_floatt magic_const(ieee_float_spect::double_precision().to_type());
//	double mgc_const_bit = 0x4330000000000000;
//	magic_const.from_double(mgc_const_bit);
//	auto mgc_cnst_expr = magic_const.to_expr();
//	auto expr = ternary_exprt(ID_if,
//			binary_relation_exprt(abs_exprt(d), ID_ge, mgc_cnst_expr), d,
//			ternary_exprt(ID_if,
//					ieee_float_equal_exprt(d, from_integer(0, d.type())), d,
//					ternary_exprt(ID_if,
//							extractbit_exprt(d,
//									to_bitvector_type(d.type()).get_width()
//											- 1),
//							ieee_float_op_exprt(
//									ieee_float_op_exprt(d, ID_floatbv_minus,
//											mgc_cnst_expr, rounding),
//									ID_floatbv_plus, mgc_cnst_expr, rounding),
//							ieee_float_op_exprt(
//									ieee_float_op_exprt(d, ID_floatbv_plus,
//											mgc_cnst_expr, rounding),
//									ID_floatbv_minus, mgc_cnst_expr, rounding),
//							d.type()), d.type()), d.type());
//	temp_gp.add(goto_programt::make_set_return_value(expr));
//
//	tgt = temp_gp.add_instruction(END_FUNCTION);
//
//	temp_gp.update();
//
//	symbolt sym;
//	code_typet::parameterst parameters;
//	code_typet::parametert para(sym1.type);
//	para.set_identifier(sym1.name);
//	para.set_base_name(sym1.base_name);
//	code_typet::parametert para2(sym2.type);
//	para2.set_identifier(sym2.name);
//	para2.set_base_name(sym2.base_name);
//	parameters.push_back(para);
//	parameters.push_back(para2);
//	auto func_code_type = code_typet(parameters, expr.type());
//	sym.name = sym.base_name = sym.pretty_name = "CPROVER__round_to_integral";
//	sym.is_thread_local = false;
//	sym.mode = ID_C;
//	sym.is_lvalue = true;
//	sym.type = func_code_type;
//	symbol_table.add(sym);
//
//	goto_functions.function_map[sym.name] = goto_functionst::goto_functiont();
//
//	const auto *fn = symbol_table.lookup("CPROVER__round_to_integral");
//	goto_functions.function_map["CPROVER__round_to_integral"].body.swap(
//			temp_gp);
//	goto_functions.function_map["CPROVER__round_to_integral"].set_parameter_identifiers(
//			to_code_type(fn->type));
//}

