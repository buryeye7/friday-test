#!/bin/bash

if [ $# -eq 0 ];then
	echo "input node number"
	exit 0
fi

ID1=$(tendermint show_node_id --home ./mytestnet/node0)
ID2=$(tendermint show_node_id --home ./mytestnet/node1)
ID3=$(tendermint show_node_id --home ./mytestnet/node2)

IP1="10.0.0.39"
IP2="10.0.0.40"
IP3="10.0.0.41"

tendermint node --home ./mytestnet/node$1 --proxy_app=kvstore --p2p.persistent_peers=&quot;ID1@IP1:26656,ID2@IP2:26656,ID3@IP3:26656&quot;
