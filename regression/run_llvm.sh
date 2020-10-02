#!/bin/bash
# A simple script
for file in */*.c
do
   # echo "FILE : ${file}"
   # cp ${file} ${file}".i"	
   #sed -i 3's/$/ --bfs &/'  ${file}
   rm ${file}".i"
   <your_path_here>/clang -S -g -emit-llvm ${file} -o ${file}".ll"
   /home/<your_path_here>/llvm2goto/llvm2goto ${file}".ll" -o ${file}".i"
done
