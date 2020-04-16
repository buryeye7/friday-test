#!/bin/bash

cat txs.txt | while read line 
do
	echo $line
	clif query tx $line --chain-id testnet
done
