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

typet translator::symbol_util::get_tag_type(const DIDerivedType *di_derived) {
//	TODO:All tags are being taken from the global namespace;Implement scoping
//	rules for tags, typedefs, etc.
	typet type;
	auto di_base = cast<DIType>(di_derived->getBaseType());
	if (typedef_tag_set.find(di_derived->getName().str())
			!= typedef_tag_set.end()) {
		symbolt symbol;
		symbol.type = get_goto_type(di_base);
		symbol.name = di_derived->getName().str();
		symbol.base_name = symbol.name;
		if (symbol.type.id() == ID_struct)
			symbol.pretty_name = string("struct ")
					+ string(symbol.name.c_str());
		else if (symbol.type.id() == ID_union)
			symbol.pretty_name = string("union ") + string(symbol.name.c_str());
		else
			symbol.pretty_name = symbol.name;
		symbol.is_thread_local = true;
		symbol.is_file_local = true;
		symbol.is_type = true;
		symbol.is_macro = true;
		symbol_table.insert(symbol);
	}
	auto *tag_symbol = symbol_table.lookup(di_derived->getName().str());
	if (tag_symbol->type.id() == ID_struct)
		type = tag_typet(ID_struct_tag, di_derived->getName().str());
	else if (tag_symbol->type.id() == ID_union)
		type = tag_typet(ID_struct_tag, di_derived->getName().str());
	else
		type = tag_typet(ID_tag, di_derived->getName().str());
	return type;
}

typet translator::symbol_util::get_derived_type(const DIDerivedType *di_derived) {
	typet type;
	auto di_base = cast<DIType>(di_derived->getBaseType());
	auto tag = di_derived->getTag();
	if (tag == dwarf::DW_TAG_pointer_type)
		type = pointer_type(get_goto_type(di_base));
	else if (tag == dwarf::DW_TAG_typedef) {
		type = get_tag_type(di_derived);
	}
	else if (tag == dwarf::DW_TAG_member) {
		type = get_goto_type(di_base);
	}
	else
		assert(false && "Unhandled DIDerivedType!");
	return type;
}

typet translator::symbol_util::get_composite_type(const DICompositeType *di_composite) {
	typet type;
	auto di_base = cast<DIType>(di_composite->getBaseType());
	auto tag = di_composite->getTag();
	if (tag == dwarf::DW_TAG_structure_type) {
		struct_typet struct_type;
		auto &components = struct_type.components();
		for (auto a : di_composite->getElements()) {
			auto di_type = cast<DIType>(a);
			struct_typet::componentt component(di_type->getName().str(),
					get_goto_type(di_type));
			components.push_back(component);
		}
		type = struct_type;
	}
	else if (tag == dwarf::DW_TAG_union_type) {
		union_typet union_type;
		auto &components = union_type.components();
		for (auto a : di_composite->getElements()) {
			auto di_type = cast<DIType>(a);
			union_typet::componentt component(di_type->getName().str(),
					get_goto_type(di_type));
			components.push_back(component);
		}
		type = union_type;
	}
	else if (tag == dwarf::DW_TAG_array_type) {
		exprt size;
		for (auto a : di_composite->getElements()) {
			if (auto sub_range = cast<DISubrange>(a)) {
				auto count =
						sub_range->getCount().dyn_cast<ConstantInt*>()->getZExtValue();
				size = index_exprt(size, from_integer(count, size_type()));
			}
		}
		type = array_typet(get_goto_type(di_base), size);
	}
	else
		assert(false && "Unhandled DICompositeType!");
	return type;
}

typet translator::symbol_util::get_goto_type(const DIType *di_type) {
	typet type;
	if (auto basic_type = cast<DIBasicType>(di_type)) {
		type = get_basic_type(basic_type);
	}
	else if (auto derived_type = cast<DIDerivedType>(di_type)) {
		type = get_derived_type(derived_type);
	}
	else if (auto composite_type = cast<DICompositeType>(di_type)) {
		type = get_composite_type(composite_type);
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
	auto func_code_type = code_typet();
	code_typet::parameterst parameters;
	auto *di_subprog = F.getSubprogram();
	if (F.hasMetadata()) {
		auto *di_subroutn = di_subprog->getType();
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
		if (&*di_subroutn->getTypeArray()[0] != NULL) {
			auto *md_node = cast<DIType>(&*di_subroutn->getTypeArray()[0]);
			func_code_type.return_type() = get_goto_type(md_node);
		}
		else
			func_code_type.return_type() = void_typet();

	}
	symbol.name = F.getName().str();
	symbol.base_name = di_subprog->getName().str();
	symbol.pretty_name = symbol.base_name;
	symbol.is_thread_local = false;
	symbol.mode = ID_C;
	symbol.is_lvalue = true;
	symbol.type = func_code_type;
	return symbol;
}
