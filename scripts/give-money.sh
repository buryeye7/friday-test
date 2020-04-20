#!/bin/bash

if [ $# == 0 ];then
	echo "Please node name"
	exit 0
fi 

git pull

DEST_PATH="$HOME/git/friday-test/settings/$1-address.txt"

PW="12345678"
i=1
amount=100000000
cat $DEST_PATH | while read line 
do
	echo "i:" $i
	echo "address:" $line
	expect -c "
        spawn clif hdac transfer-to $line 100000000 0.01 30000000 --from node$i
        expect "N]:"
            send \"y\\r\"
        expect "\'node$i\':"
            send \"$PW\\r\"
        expect eof
        "
	i=$((i+1))
done



