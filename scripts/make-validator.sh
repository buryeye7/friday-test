#!/bin/bash

if [ $# == 0 ];then
	echo "Input node name"
	exit 0
fi

CN="testnet"
clif hdac create-validator \
--from $1 \
--pubkey $(nodef tendermint show-validator) \
--moniker $1 \
--chain-id $CN

clif hdac bond \
--from $1 1 0.01 30000000 \
--chain-id $CN 
