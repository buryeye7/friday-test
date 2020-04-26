#!/bin/bash

i=0
while true
do
	curl -s "localhost:26657/block?height=$i"  | jq .result.block_meta.header.proposer_address
	i=$((i+1))
done
