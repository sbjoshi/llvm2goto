//============================================================================
// Name        : LLVM2GOTO
// Author      : Akash Banerjee
// Version     :
// Copyright   : 
// Description : Translate LLVM IR to GOTO Program.
//============================================================================

#include "llvm2goto.h"

using namespace ll2gb;

int main(int argc, char **argv) {

	if (argc < 2) {
		print_help();
		exit(1);
	}
	else if (argc > 4) {
		print_help();
		exit(2);
	}
	std::string in_irfile, out_gbfile;
	if (!std::string(argv[1]).compare("-h")
			|| !std::string(argv[1]).compare("--help")) print_help();

	if (argc == 4) {
		if (!std::string(argv[1]).compare("-o")) {
			out_gbfile = argv[2];
			in_irfile = argv[3];
		}
		else if (!std::string(argv[2]).compare("-o")) {
			out_gbfile = argv[3];
			in_irfile = argv[1];
		}
		else
			print_help();
	}
	else if (argc == 3) {
		in_irfile = argv[1];
		out_gbfile = argv[2];
	}
	else {
		in_irfile = argv[1];
		std::string temp(argv[1]);
		auto index = temp.find(".ll");
		if (index != temp.npos)
			out_gbfile = std::string(argv[1]).substr(0, index) + ".gb";
		else
			out_gbfile = temp + ".gb";
	}

	static llvm::LLVMContext context;
	llvm::SMDiagnostic err;
	auto M = llvm::parseIRFile(in_irfile, err, context);

	if (!M) {
		err.print(argv[0], llvm::errs());
		return 1;
	}
	else {
		llvm::errs() << "IR File Successfully read!\n";
		translator T(M);

		llvm::errs() << "Generating GOTO Binary\n";
		if (T.generate_goto()) {
			llvm::errs() << "llvm2goto.generate_goto() Encountered error\n";
			exit(3);
		}
		llvm::errs() << "GOTO Binary generated successfully\n";
	}

	return 0;
}
