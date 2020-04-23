#!/bin/bash

if [ $# -eq 0 ];then
	echo "input node number"
	exit 0
fi

ps -ef | grep tendermint | while read line
do
	if [ "$line" != *"grep"* ];then
		echo "line" $line
		pid=$(echo $line | awk -F' ' '{print $2}')
		kill -9 $pid
	fi
done 

rm -rf mytestnet
tendermint testnet

sed -i "s/prometheus = false/prometheus = true/g" ./mytestnet/node0/config/config.toml

ID0=$(tendermint show_node_id --home ./mytestnet/node0)
ID1=$(tendermint show_node_id --home ./mytestnet/node1)
ID2=$(tendermint show_node_id --home ./mytestnet/node2)

IP0="10.0.0.39"
IP1="10.0.0.40"
IP2="10.0.0.41"

tendermint node --home ./mytestnet/node$1 --proxy_app=kvstore --p2p.persistent_peers=&quot;ID0@IP0:26656,ID1@IP1:26656,ID2@IP2:26656&quot;
