============================================
LLVM2GOTO : Translate llvm IR to GOTO Binary
============================================

To Build llvm2goto:
1: Set the appropriate path variables in config.inc
2: make

To run on the test cases in regression:
1: Set the paths in regression/Makefile
2: Set the paths in run_llvm.sh
3: run the run_llvm bash script.
4: make test

To use the tool:
llvm2goto <yourllvmir>.ll -o output.gb

NOTE:
Use complete paths wherever applicable, i.e, don't use ~/Documents/..., use /home/yourname/Documents/... instead.
LLVM IR should be compiled using following flags - '-O0 -S -emit-llvm -g'
