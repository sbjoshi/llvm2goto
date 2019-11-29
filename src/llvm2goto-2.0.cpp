//============================================================================
// Name        : LLVM2GOTO
// Author      : Akash Banerjee
// Version     :
// Copyright   : 
// Description : Translate LLVM IR to GOTO Program.
//============================================================================

#include "llvm2goto.h"
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

		translator T(ir_module);
		if (T.generate_goto()) {
			print_error();
		}
		else {
			dbgs() << "GOTO Binary generated successfully\n";
			T.write_goto(out_gbfile);
		}
	}
	return 0;
}
