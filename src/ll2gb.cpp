//============================================================================
// Name        : ll2gb
// Author      : Akash Banerjee
// Version     : 0.1
// Copyright   : 
// Description : Translate LLVM IR to GOTO Program.
//============================================================================

#include "ll2gb.h"
#include "translator.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

int main(int argc, char **argv) {
	secret();
	vector<pair<string, string>> file_names;
	parse_input(argc, argv, file_names);
	for (auto a : file_names) {
		auto in_irfile = a.first;
		auto out_gbfile = a.second;
		LLVMContext context;
		auto ir_module = get_llvm_ir(in_irfile, context);
		run_llvm_passes(*ir_module);

		translator T(ir_module);
		if (T.generate_goto()) {
			print_error();
		}
		else
			T.write_goto(out_gbfile);
	}
	return 0;
}
