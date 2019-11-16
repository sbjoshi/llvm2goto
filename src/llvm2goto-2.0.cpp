//============================================================================
// Name        : LLVM2GOTO
// Author      : Akash Banerjee
// Version     :
// Copyright   : 
// Description : Translate LLVM IR to GOTO Program.
//============================================================================

#include "llvm2goto.h"
#include "translator.h"
#include <signal.h>

using namespace std;
using namespace llvm;
using namespace ll2gb;

int main(int argc, char **argv) {
	vector<pair<string, string>> file_names;
	parse_input(argc, argv, file_names);

	for (auto a : file_names) {
		auto in_irfile = a.first;
		auto out_gbfile = a.second;
		LLVMContext context;
		auto ir_module = get_llvm_ir(in_irfile, context);
		translator T(ir_module);

		struct sigaction act;
		act.sa_handler = print_error;
		sigemptyset(&act.sa_mask);
		act.sa_flags = 0;
		sigaction(SIGSEGV, &act, 0);

		if (T.generate_goto()) {
			exit(3);
		}
		T.write_goto(out_gbfile);
	}
	return 0;
}
