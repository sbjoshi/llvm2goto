/*
 * symbols.cpp
 *
 *  Created on: 16-Aug-2019
 *      Author: Akash Banerjee
 */

#include "llvm2goto.h"
#include "symbol_util.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

set<string> translator::symbol_util::typedef_tag_set = set<string>();
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
		type = signedbv_typet(ll_type->getIntegerBitWidth());
		break;
	}
	case Type::StructTyID: {
		auto strct_name = ll_type->getStructName().str();
		if (typedef_tag_set.find(strct_name) == typedef_tag_set.end()) {
			struct_typet struct_type;
			auto &components = struct_type.components();
			for (unsigned i = 0, n = ll_type->getStructNumElements(); i < n;
					i++) {
				auto struct_element = ll_type->getStructElementType(i);
				struct_typet::componentt component(string("ele_"
						+ to_string(i)),
						get_goto_type(struct_element));
				components.push_back(component);
			}
			symbolt symbol;
			struct_type.set_tag(strct_name);
			symbol.type = struct_type;
			symbol.mode = ID_C;
			symbol.name = strct_name;
			symbol.base_name = strct_name;
			symbol.type.set(ID_name, symbol.name);
			if (symbol.type.id() == ID_struct)
				symbol.pretty_name = string("struct ")
						+ string(symbol.name.c_str());
			else if (symbol.type.id() == ID_union)
				symbol.pretty_name = string("union ")
						+ string(symbol.name.c_str());
			else
				symbol.pretty_name = symbol.name;
			symbol.is_type = true;
			symbol_table.insert(symbol);
			typedef_tag_set.insert(strct_name);
		}
		auto *tag_symbol = symbol_table.lookup(strct_name);
//		if (tag_symbol->type.id() == ID_struct
//				|| tag_symbol->type.id() == ID_incomplete_struct)
//			type = struct_tag_typet(strct_name);
//		else
//			assert(false);
		type = tag_symbol->type;
		break;
	}
	case Type::ArrayTyID: {
		auto arr_len = from_integer(ll_type->getArrayNumElements(),
				size_type());
		type = array_typet(get_goto_type(ll_type->getArrayElementType()),
				arr_len);
		break;
	}
	case Type::PointerTyID: {
		type = pointer_type(get_goto_type(ll_type->getPointerElementType()));
		break;
	}
	case Type::FunctionTyID: {
		assert(false && "Function llvm::TypeID encountered!");
		break;
	}
	default: {
		errs() << "TYPE ID: " << ll_type->getTypeID() << '\n';
		assert(false && "Unhandled llvm::TypeID");
	}
	}
	return type;
}

symbolt translator::symbol_util::create_symbol(const Type *ll_type) {
	symbolt symbol;
	symbol.is_file_local = true;
	symbol.is_thread_local = true;
	symbol.is_lvalue = true;

	symbol.name = string("var" + to_string(var_counter));
	symbol.base_name = symbol.name;
	var_counter++;
	symbol.type = get_goto_type(ll_type);
	symbol.mode = ID_C;
	return symbol;
}

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
