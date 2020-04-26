#!/bin/bash

i=1
while true
do
	proposer=$(curl -s "localhost:26657/block?height=$i" | jq .result.block_meta.header.proposer_address)
	#if [ $proposer == "\"99AC1E60087A65E1E50F58F157674D121E4E23AC\"" ];then
	num_txs=$(curl -s "localhost:26657/block?height=$i" | jq .result.block_meta.header.num_txs)
	echo $proposer $num_txs
	#fi
	i=$((i+1))
done
