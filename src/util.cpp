/*
 * util.cpp
 *
 *  Created on: 16-Aug-2019
 *      Author: Akash Banerjee
 */

#include "ll2gb.h"
#include "symbol_util.h"
#include "translator.h"
#include <signal.h>

using namespace std;
using namespace llvm;
using namespace ll2gb;

cl::OptionCategory ll2gb_cat("Options");

cl::opt<string> ll2gb::InputFilename(cl::Positional, cl::desc("<input file>"),
                                     cl::Required);

cl::opt<string> ll2gb::outputFilename("o", cl::desc("Specify output filename"),
                                      cl::value_desc("filename"), cl::init(""),
                                      cl::cat(ll2gb_cat));

cl::opt<bool> ll2gb::verbose("v", cl::desc("Verbose"), cl::init(false),
                             cl::cat(ll2gb_cat));

cl::opt<bool> ll2gb::verbose_very("vv", cl::desc("Very Verbose"),
                                  cl::init(false), cl::cat(ll2gb_cat));

cl::opt<bool> ll2gb::optEnabled("opt", cl::desc("Enable Optimization of IR"),
                                cl::init(false), cl::cat(ll2gb_cat));

cl::opt<bool> ll2gb::optimizeForced("f", cl::desc("Force Optimizations"),
                                    cl::init(false), cl::cat(ll2gb_cat));

void ll2gb::print_version(raw_ostream &ostream) {
  ostream << "LL2GB Version: 2.0\n\n";
  cl::PrintVersionMessage();
}

void ll2gb::parse_input(int argc, char **argv) {
  cl::SetVersionPrinter(print_version);
  cl::HideUnrelatedOptions(ll2gb_cat);
  cl::ParseCommandLineOptions(argc, argv);

  /// If output file name is not specified then <inputfilename>.gb is the
  ///  default name.
  if (outputFilename.empty()) {
    auto index = InputFilename.find(".ll");
    if (index != InputFilename.npos)
      outputFilename = InputFilename.substr(0, index) + ".gb";
    else
      outputFilename = InputFilename + ".gb";
  }

  if (verbose_very)
    verbose = true;

  secret();
}

bool ll2gb::is_assert_function(const string &func_name) {
  if (!func_name.compare("assert"))
    return true;
  if (!func_name.compare("assert_"))
    return true;
  if (!func_name.compare("__CPROVER_assert"))
    return true;
  if (!func_name.compare("__VERIFIER_assert"))
    return true;
  return false;
}

bool ll2gb::is_assert_fail_function(const string &func_name) {
  if (!func_name.compare("__ll2gb_assert_fail_"))
    return true;
  if (!func_name.compare("__VERIFIER_error"))
    return true;
  if (!func_name.compare("reach_error"))
    return true;
  return false;
}

bool ll2gb::is_assume_function(const string &func_name) {
  if (!func_name.compare("assume"))
    return true;
  if (!func_name.compare("__CPROVER_assume"))
    return true;
  if (!func_name.compare("__VERIFIER_assume"))
    return true;
  return false;
}

void ll2gb::print_error() {
  errs().changeColor(errs().RED, true);
  errs() << "error: ";
  errs().resetColor();
  errs().changeColor(errs().SAVEDCOLOR, true);
  errs() << translator::error_state << "\n\n";
  errs().resetColor();
}

void ll2gb::panic(int sig) {
  errs().changeColor(errs().MAGENTA, true);
  errs() << "\nI Panicked :(\n\n";
  if (translator::check_state()) {
    errs().resetColor();
    errs().changeColor(errs().SAVEDCOLOR, true);
    errs() << translator::error_state << "\n\n";
  }
  errs().resetColor();
  exit(3);
}

void ll2gb::secret() {
  static struct sigaction act;
  act.sa_handler = panic;
  sigemptyset(&act.sa_mask);
  act.sa_flags = 0;
  sigaction(SIGSEGV, &act, 0);
}
