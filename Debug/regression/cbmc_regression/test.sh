#!/bin/bash
# A simple script
i=0
i=$((i+1))
for file in */*.ll
do
    i=$((i+1))
done
echo $i
