#!/bin/bash
# A simple script
for file in */*.c
do
   # echo "FILE : ${file}"
   # cp ${file} ${file}".i"	
   #sed -i 3's/$/ --bfs &/'  ${file}
   rm ${file}".i"
   clang -S -g -emit-llvm ${file} -o ${file}".ll" -Wno-implicit-function-declaration
   ll2gb -o ${file}".i" ${file}".ll" -v
done
