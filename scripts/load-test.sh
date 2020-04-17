#!/bin/bash

PW=12345678
for i in {1..10000}
do
	for j in {1..100}
	do
		echo $j
		res=$(expect -c "
		spawn clif hdac transfer-to friday1sqv4r0lw2t2fqdq5j3xfrt6lpktl35dlte8st0 1 0.01 30000000 --from node$j --chain-id testnet
		expect "N]:"
			send \"y\\r\"  
		expect "\'node$j\':"
			send \"$PW\\r\"
		expect eof 
		" | sed '/spawn/d' | sed '/confirm/d' | sed '/Password/d' | jq .) 
		echo $res
		txhash=$(echo $res | jq .txhash | sed 's/null//g')
		code=$(echo $res | jq .code | sed 's/null//g')
		echo $txhash $code
	done
done
