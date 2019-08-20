/*
 * util.cpp
 *
 *  Created on: 16-Aug-2019
 *      Author: Akash Banerjee
 */

#include "llvm2goto.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

void ll2gb::print_help() {
	outs() << "Version: 2.0\n"
			<< "Usage: llvm2goto <ir_file> -o <op_file_name>\n";
}

void ll2gb::parse_input(int argc,
		char **argv,
		string &in_irfile,
		string &out_gbfile) {

	if (argc < 2) {
		print_help();
		exit(1);
	}
	else if (argc > 4) {
		print_help();
		exit(2);
	}
	if (!string(argv[1]).compare("-h") || !string(argv[1]).compare("--help"))
		print_help();

	if (argc == 4) {
		if (!string(argv[1]).compare("-o")) {
			out_gbfile = argv[2];
			in_irfile = argv[3];
		}
		else if (!string(argv[2]).compare("-o")) {
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
		string temp(argv[1]);
		auto index = temp.find(".ll");
		if (index != temp.npos)
			out_gbfile = string(argv[1]).substr(0, index) + ".gb";
		else
			out_gbfile = temp + ".gb";
	}
}
