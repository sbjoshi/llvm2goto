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

string translator::symbol_util::lookup_namespace(string str) {
	while (var_name_map.find(str) == var_name_map.end()) {
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

typet translator::symbol_util::get_basic_type(const DIBasicType *di_basic) {
	typet type;
	switch (di_basic->getEncoding()) {
	case dwarf::DW_ATE_signed: {
		switch (di_basic->getSizeInBits()) {
		case 1: {
			type = bool_typet();
			break;
		}
		case 32: {
			type = signed_int_type();
			break;
		}
		case 64: {
			type = signed_long_int_type();
			break;
		}
		case 128: {
			config.ansi_c.long_long_int_width = 128;
			type = signed_long_long_int_type();
			break;
		}
		default: {
			errs() << "Unknown type for var "
					<< di_basic->getName()
					<< ". Creating signedbv type of size "
					<< di_basic->getSizeInBits()
					<< '\n';
			type = signedbv_typet(di_basic->getSizeInBits());
		}
		}
		break;
	}
	case dwarf::DW_ATE_unsigned: {
		switch (di_basic->getSizeInBits()) {
		case 1: {
			type = bool_typet();
			break;
		}
		case 32: {
			type = unsigned_int_type();
			break;
		}
		case 64: {
			type = unsigned_long_int_type();
			break;
		}
		case 128: {
			config.ansi_c.long_long_int_width = 128;
			type = unsigned_long_long_int_type();
			break;
		}
		default: {
			errs() << "Unknown type for var "
					<< di_basic->getName()
					<< ". Creating unsignedbv type of size "
					<< di_basic->getSizeInBits()
					<< '\n';
			type = unsignedbv_typet(di_basic->getSizeInBits());
		}
		}
		break;
	}
	case dwarf::DW_ATE_float: {
		switch (di_basic->getSizeInBits()) {
		case 32: {
			type = float_type();
			break;
		}
		case 64: {
			type = double_type();
			break;
		}
		default: {
			errs() << "Unknown type for var "
					<< di_basic->getName()
					<< ". Creating long_double type of size "
					<< di_basic->getSizeInBits()
					<< '\n';
			config.ansi_c.long_double_width = di_basic->getSizeInBits();
			type = long_double_type();
		}
		}
		break;
	}
	default:
		assert(false && "Unhandled DIBasicType!");
	}
	return type;
}

typet translator::symbol_util::get_derived_type(const DIDerivedType *di_derived) {
	typet type;
	auto di_base = dyn_cast<DIType>(di_derived->getBaseType());
	if (auto tag = di_derived->getTag() == dwarf::DW_TAG_pointer_type)
		type = pointer_type(get_goto_type(di_base));
	else if (tag == dwarf::DW_TAG_typedef) {

	}
	return type;
}

typet translator::symbol_util::get_goto_type(const DIType *di_type) {
	typet type;
	if (auto basic_type = dyn_cast<DIBasicType>(di_type)) {
		type = get_basic_type(basic_type);
	}
	if (auto basic_type = dyn_cast<DIDerivedType>(di_type)) {
		type = get_derived_type(basic_type);
	}
	return type;
}

typet translator::symbol_util::get_goto_type(const Type *ll_type) {
	typet type;
	return type;
}

symbolt translator::symbol_util::create_symbol(const DIType *di_type) {
	symbolt symbol;
	return symbol;
}

symbolt translator::symbol_util::create_symbol(const Type *ll_type) {
	symbolt symbol;
	return symbol;
}

symbolt translator::symbol_util::create_goto_func_symbol(const FunctionType *type,
		const Function &F) {
	symbolt symbol;
	symbol.clear();
	symbol.is_thread_local = false;
	symbol.mode = ID_C;
	auto func_code_type = code_typet();
	code_typet::parameterst parameters;
	if (F.hasMetadata()) {
		auto *meta_data = dyn_cast<DISubprogram>(F.getSubprogram())->getType();
		for (auto arg_iter = F.arg_begin(), arg_end = F.arg_end();
				arg_iter != arg_end; arg_iter++) {
			auto arg_symbol =
					symbol_table.lookup(lookup_namespace(F.getName().str()
							+ "::" + arg_iter->getName().str()));
			code_typet::parametert para(arg_symbol->type);
			para.set_identifier(F.getName().str() + "::"
					+ arg_iter->getName().str());
			para.set_base_name(arg_iter->getName().str());
			parameters.push_back(para);
		}
		func_code_type.parameters() = parameters;
		if (&*meta_data->getTypeArray()[0] != NULL) {
			auto *md_node = dyn_cast<DIType>(&*meta_data->getTypeArray()[0]);
			type->getReturnType();
			func_code_type.return_type() = get_goto_type(md_node);
		}
		else
			func_code_type.return_type() = void_typet();

	}
	symbol.type = func_code_type;
	return symbol;
}
