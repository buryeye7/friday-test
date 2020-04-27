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


if [ $1 == 0 ];then
	rm -rf mytestnet
	tendermint testnet
	git add mytestnet
	git commit -m "."
	git push origin master
fi

for i in {1..4}
do
	tmp=$((i-1))
	sed -i "s/prometheus = false/prometheus = true/g" ./mytestnet/node$tmp/config/config.toml
done

ID0=$(tendermint show_node_id --home ./mytestnet/node0)
ID1=$(tendermint show_node_id --home ./mytestnet/node1)
ID2=$(tendermint show_node_id --home ./mytestnet/node2)
ID3=$(tendermint show_node_id --home ./mytestnet/node3)

IP0="132.145.82.179"
IP1="140.238.3.232"
IP2="158.101.103.98"
IP3="129.213.164.217"

tendermint node --home ./mytestnet/node$1 --proxy_app=kvstore --p2p.persistent_peers=$ID0@$IP0:26656,$ID1@$IP1:26656,$ID2@$IP2:26656,$ID3@$IP3:26656
