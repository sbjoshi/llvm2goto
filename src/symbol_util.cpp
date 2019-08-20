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

typet translator::symbol_util::get_goto_type(const DIType*) {
	typet type;
	return type;
}

typet translator::symbol_util::get_goto_type(const Type*) {
	typet type;
	return type;
}

symbolt translator::symbol_util::create_symbol(const DIType *di_type) {
	symbolt symbol;
	return symbol;
}

symbolt translator::symbol_util::create_symbol(const Type *type) {
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
	code_typet::parameterst para;
	if (F.hasMetadata()) {
		auto *meta_data = dyn_cast<DISubprogram>(F.getSubprogram())->getType();
		for (auto arg_iter = F.arg_begin(), arg_end = F.arg_end();
				arg_iter != arg_end; arg_iter++) {
			auto arg_symbol = symbol_table.lookup(F.getName().str() + "::"
					+ arg_iter->getName().str());
			code_typet::parametert p(arg_symbol->type);
			para.push_back(p);
		}
		func_code_type.parameters() = para;
		if (&*meta_data->getTypeArray()[0] != NULL) {
			auto *mdn = dyn_cast<DIType>(&*meta_data->getTypeArray()[0]);
			type->getReturnType();
			while (mdn->getTag() == dwarf::DW_TAG_typedef)
				mdn =
						dyn_cast<DIType>(dyn_cast<DIDerivedType>(mdn)->getBaseType());
			func_code_type.return_type() = get_goto_type(mdn);
		}
		else {
			func_code_type.return_type() = void_typet();
		}
	}
	symbol.type = func_code_type;
	return symbol;
}
