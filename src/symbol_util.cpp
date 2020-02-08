/*
 * symbols.cpp
 *
 *  Created on: 16-Aug-2019
 *      Author: Akash Banerjee
 */

#include "ll2gb.h"
#include "symbol_util.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

set<string> translator::symbol_util::typedef_tag_set = set<string>();
set<const Type*> translator::symbol_util::current_struct_eval =
		set<const Type*>();
unsigned translator::symbol_util::var_counter = 1;

string translator::symbol_util::lookup_namespace(string str) {
	while (symbol_table.lookup(str) == nullptr) {
		string::iterator i = str.end() - 1;
		while (*i != ':' && i >= str.begin()) {
			i--;
		}
		if (i < str.begin()) return str;
		str.erase(i);
		i--;
		str.erase(i);
		i--;
		while (*i != ':' && i >= str.begin()) {
			str.erase(i);
			i--;
		}
	}
	return str;
}

/// Returns the corresponding GOTO type
/// for the input llvm type.
typet translator::symbol_util::get_goto_type(const Type *ll_type) {
	typet type;
	switch (ll_type->getTypeID()) {
	case Type::VoidTyID: {
		type = void_type();
		break;
	}
	case Type::HalfTyID: {
		type = ieee_float_spect::half_precision().to_type();
		type.set(ID_C_c_type, ID_gcc_float16);
		break;
	}
	case Type::FloatTyID: {
		type = ieee_float_spect::single_precision().to_type();
		type.set(ID_C_c_type, ID_float);
		break;
	}
	case Type::DoubleTyID: {
		type = ieee_float_spect::double_precision().to_type();
		type.set(ID_C_c_type, ID_double);
		break;
	}
	case Type::FP128TyID: {
		type = ieee_float_spect::quadruple_precision().to_type();
		type.set(ID_C_c_type, ID_long_double);
		break;
	}
	case Type::X86_FP80TyID: {
		type = ieee_float_spect::x86_80().to_type();
		type.set(ID_C_c_type, ID_long_double);
		break;
	}
	case Type::IntegerTyID: {
		if (ll_type->getIntegerBitWidth() == 1)
			type = bool_typet();
		else
			type = signedbv_typet(ll_type->getIntegerBitWidth());
		break;
	}
	case Type::StructTyID: {
		string strct_name;
		if (current_struct_eval.find(ll_type) != current_struct_eval.end()) {
			if (cast<StructType>(ll_type)->isLiteral())
				error_state = "Struct name not available for struct ptr component.";
			else
				type = struct_tag_typet(ll_type->getStructName().str());
			break;
		}
		current_struct_eval.insert(ll_type);
		if (cast<StructType>(ll_type)->isLiteral()) {
			struct_typet struct_type;
			auto &components = struct_type.components();
			for (unsigned i = 0, n = ll_type->getStructNumElements(); i < n; i++) {
				auto struct_element = ll_type->getStructElementType(i);
				struct_typet::componentt component(string("ele_" + to_string(i)),
						get_goto_type(struct_element));
				components.push_back(component);
			}
			type = struct_type;
			current_struct_eval.erase(ll_type);
			break;
		}
		else
			strct_name = ll_type->getStructName().str();
		if (typedef_tag_set.find(strct_name) == typedef_tag_set.end()) {
			struct_typet struct_type;
			auto &components = struct_type.components();
			for (unsigned i = 0, n = ll_type->getStructNumElements(); i < n; i++) {
				auto struct_element = ll_type->getStructElementType(i);
				struct_typet::componentt component(string("ele_" + to_string(i)),
						get_goto_type(struct_element));
				components.push_back(component);
			}
			struct_type.set_tag(strct_name);
			symbolt symbol;
			symbol.type = struct_type;
			symbol.mode = ID_C;
			symbol.name = strct_name;
			symbol.base_name = strct_name;
			if (symbol.type.id() == ID_struct)
				symbol.pretty_name = string("struct ") + string(symbol.name.c_str());
			else
				symbol.pretty_name = symbol.name;
			symbol.is_type = true;
			symbol_table.insert(symbol);
			typedef_tag_set.insert(strct_name);
		}
		type = struct_tag_typet(strct_name);
		current_struct_eval.erase(ll_type);
		break;
	}
	case Type::ArrayTyID: {
		auto arr_len = from_integer(ll_type->getArrayNumElements(), size_type());
		type = array_typet(get_goto_type(ll_type->getArrayElementType()), arr_len);
		break;
	}
	case Type::PointerTyID: {
		type = pointer_type(get_goto_type(ll_type->getPointerElementType()));
		break;
	}
	case Type::FunctionTyID: {
		auto ll_func_type = cast<FunctionType>(ll_type);
		auto func_type = code_typet();
		code_typet::parameterst parameters;
		for (auto param_type : ll_func_type->params()) {
			code_typet::parametert para(get_goto_type(param_type));
			parameters.push_back(para);
		}
		func_type.parameters() = parameters;
		func_type.return_type() = get_goto_type(ll_func_type->getReturnType());
		type = func_type;
		break;
	}
	default: {
		error_state = "Unknown llvm::Type";
	}
	}
	return type;
}

/// Creates and returns a new GOTO symbol
/// of the corresponding GOTO type from the
/// input llvm type.
symbolt translator::symbol_util::create_symbol(const Type *ll_type) {
	symbolt symbol;
	symbol.is_file_local = true;
	symbol.is_thread_local = true;
	symbol.is_lvalue = true;

	symbol.name = "var" + to_string(var_counter);
	symbol.base_name = symbol.name;
	var_counter++;
	symbol.type = get_goto_type(ll_type);
	symbol.mode = ID_C;
	return symbol;
}

/// Creates and returns a new GOTO symbol
symbolt translator::symbol_util::create_symbol(const typet &gb_type,
		const string name) {
	symbolt symbol;
	symbol.is_file_local = true;
	symbol.is_thread_local = true;
	symbol.is_lvalue = true;

	if (name.empty())
		symbol.name = "var" + to_string(var_counter);
	else
		symbol.name = name;
	symbol.base_name = symbol.name;
	var_counter++;
	symbol.type = gb_type;
	symbol.mode = ID_C;
	return symbol;
}

/// Creates and returns a new GOTO function
/// symbol of the corresponding GOTO type from the
/// input llvm function.
symbolt translator::symbol_util::create_goto_func_symbol(const Function &F) {
	symbolt symbol;
	symbol.clear();
	auto func_code_type = code_typet();
	code_typet::parameterst parameters;
	for (const auto &arg_iter : F.args()) {
		auto arg_symbol = symbol_table.lookup(func_arg_name_map[&arg_iter]);
		code_typet::parametert para(arg_symbol->type);
		para.set_identifier(arg_symbol->name);
		para.set_base_name(arg_symbol->base_name);
		parameters.push_back(para);
	}
	func_code_type.parameters() = parameters;
	func_code_type.return_type() = get_goto_type(F.getReturnType());

	symbol.name = F.getName().str();
	symbol.base_name = symbol.name;
	symbol.pretty_name = symbol.base_name;
	symbol.is_thread_local = false;
	symbol.mode = ID_C;
	symbol.is_lvalue = true;
	symbol.type = func_code_type;
	return symbol;
}
