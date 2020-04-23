#!/bin/bash

i=1
while true
do
	curl -s "localhost:26657/block?height=$i" | jq .result.block_meta.header.total_txs
	i=$((i+1))
done
