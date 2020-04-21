#!/bin/bash

if [ $# == 0 ]; then
	echo "Please input node name"
	exit 0 
fi

git pull
GIT="$HOME/git/friday-test"
SRC="$HOME/go/src/github.com/hdac-io/friday"
rm -rf ~/.nodef/config
rm -rf ~/.nodef/data
rm -rf ~/.clif

tmp=$(ps -ef | grep grpc)
echo $tmp | while read line 
do 
	if [[ $line == *"CasperLabs"* ]];then
		target=$(echo $line |  awk -F' ' '{print $2}')
		kill -9 $target
	fi
done

tmp=$(ps -ef | grep nodef)
echo $tmp | while read line 
do 
	if [[ $line == *"nodef"* ]];then
		target=$(echo $line |  awk -F' ' '{print $2}')
		kill -9 $target
	fi
done

# run execution engine grpc server
$SRC/CasperLabs/execution-engine/target/release/casperlabs-engine-grpc-server -t 8 $HOME/.casperlabs/.casper-node.sock&

nodef init $1 --chain-id testnet

# apply default clif configure
clif config chain-id testnet
clif config output json
clif config indent true
clif config trust-node true

cp ~/git/friday-test/settings/genesis.json ~/.nodef/config/
cp ~/git/friday-test/settings/manifest.toml ~/.nodef/config/
SEED=$(cat ~/git/friday-test/settings/seed-address.txt)
sed -i "s/seeds = \"\"/seeds = $SEED/g" ~/.nodef/config/config.toml
sed -i "s/prometheus = false/prometheus = false/g" ~/.nodef/config/config.toml

./make-account.sh $1
