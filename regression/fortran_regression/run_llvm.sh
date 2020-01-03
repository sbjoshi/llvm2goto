#!/bin/bash
# A simple script
for file in */*.f90
do
	rm ${file}".i"
	flang -S -g -emit-llvm ${file} -o ${file}".ll" -Wno-implicit-function-declaration
   llvm2goto -o ${file}".i" ${file}".ll" -v
done
