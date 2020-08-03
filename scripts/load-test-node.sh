#!/bin/bash

PW=12345678
for i in {1..10}
do
	for j in {1..1100}
	do
		echo $j
		res=$(expect -c "
		spawn clif hdac transfer-to friday19ktfw6flujxvxfnpgvldn4wj5mdx0565g6n4cj7zgshcfaxsyudsd9248t $j 0.01 --from node --chain-id testnet
		expect "N]:"
			send \"y\\r\"  
		expect "\'node$j\':"
			send \"$PW\\r\"
		expect eof 
		" | sed '/confirm/d' | sed '/Password/d' ) 
		echo $res
		echo "$res" | grep "txhash:"
		echo "$res" | grep "code:"
		sleep 5
	done
done
