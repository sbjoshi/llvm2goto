#!/bin/bash
# A simple script
for file in */*.c
do
   # echo "FILE : ${file}"
   # cp ${file} ${file}".i"	
   #sed -i 3's/$/ --bfs &/'  ${file}
   /usr/local/bin/clang -S -g -emit-llvm ${file} -o ${file}".ll"
   /home/akash/Documents/CBMC/cbmc/src/llvm2goto/llvm2goto ${file}".ll" -o ${file}".i"
done
