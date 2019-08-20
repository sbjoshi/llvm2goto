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
	string in_irfile, out_gbfile;
	parse_input(argc, argv, in_irfile, out_gbfile);

	auto ir_module = get_llvm_ir(in_irfile);
	translator T(ir_module);
	if (!T.generate_goto()) {
		errs() << "Encountered an error in generating goto-binary!\nProgram will now terminate.\n";
		exit(3);
	}

	return 0;
}
