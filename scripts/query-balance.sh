#!/bin/bash

cat ../settings/$1-address.txt | while read line 
do
	#echo $line
	clif hdac getbalance --from $line
done
