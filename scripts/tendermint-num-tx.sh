#!/bin/bash

i=1
while true
do
	num_txs=$(curl -s "localhost:26657/block?height=$i" | jq .result.block_meta.header.num_txs)
	curr_time=$(curl -s "localhost:26657/block?height=$i" | jq .result.block_meta.header.time)
	proposer=$(curl -s "localhost:26657/block?height=$i" | jq .result.block_meta.header.proposer_address)
	
	echo $curr_time $num_txs $proposer
	i=$((i+1))
done
