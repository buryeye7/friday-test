#!/bin/bash

if [ $# -eq 0 ];then
	echo "input node number"
	exit 0
fi

ID0=$(tendermint show_node_id --home ./mytestnet/node0)
ID1=$(tendermint show_node_id --home ./mytestnet/node1)
ID2=$(tendermint show_node_id --home ./mytestnet/node2)
ID3=$(tendermint show_node_id --home ./mytestnet/node3)

IP0="132.145.82.179"
IP1="140.238.3.232"
IP2="158.101.103.98"
IP3="129.213.164.217"


tendermint node --home ./mytestnet/node$1 --proxy_app=kvstore --p2p.persistent_peers=$ID0@$IP0:26656,$ID1@$IP1:26656,$ID2@$IP2:26656,$ID3@$IP3:26656
