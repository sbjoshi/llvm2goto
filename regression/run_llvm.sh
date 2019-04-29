#!/bin/bash
# A simple script
for file in */*.c
do
   echo "FILE : ${file}"
   # cp ${file} ${file}".i"	
   #sed -i 3's/$/ --bfs &/'  ${file}
   /home/akash/my_path/clang -S -g -emit-llvm -O0 ${file} -o ${file}".ll"
   /home/akash/Documents/CBMC/cbmc/src/llvm2goto/llvm2goto ${file}".ll" -o ${file}".i"
done
