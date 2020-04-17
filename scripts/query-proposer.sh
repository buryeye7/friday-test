#!/bin/bash

if [ $# != 2 ];then
	echo "input start end"
	exit 0
fi 

for i in {$1..$2}
do
	clif query block $i | jq .block.header.proposer_address
done
