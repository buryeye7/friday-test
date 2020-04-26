#!/bin/bash

if [ $# -eq 0 ];then
	echo "input node number"
	exit 0
fi

ID0=$(tendermint show_node_id --home ./mytestnet/node0)
ID1=$(tendermint show_node_id --home ./mytestnet/node1)
ID2=$(tendermint show_node_id --home ./mytestnet/node2)

IP0="10.0.0.39"
IP1="10.0.0.41"
IP2="10.0.0.42"

tendermint node --home ./mytestnet/node$1 --proxy_app=kvstore --p2p.persistent_peers=$ID0@$IP0:26656,$ID1@$IP1:26656,$ID2@$IP2:26656
