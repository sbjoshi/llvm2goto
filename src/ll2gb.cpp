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

	parse_input(argc, argv);

	auto ir_module = get_llvm_ir();

	run_llvm_passes(*ir_module);

	translator T(ir_module);
	if (T.generate_goto())
		print_error();
	else
		T.write_goto(outputFilename);
	return 0;
}
