#!/bin/bash
# A simple script
for file in */*.c
do
   rm ${file}".i" -f
   rm ${file}".ll" -f
   clang -S -emit-llvm -Xclang -disable-O0-optnone ${file} -o ${file}".ll" -Wno-everything
   ../../build/ll2gb -o ${file}".i" ${file}".ll" -v 1 -opt
done
