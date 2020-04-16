#!/bin/bash

PW="12345678"
for i in {1..100}
do 
	expect -c "
	spawn clif keys add node$i
	expect "disk:"
		send \"$PW\\r\"
	expect "passphrase:"
		send \"$PW\\r\"
	expect eof
	"
done

rm $HOME/git/friday-test/settings/$1-address.txt

for i in {1..100}
do 
	clif keys show node$i -a >> ~/git/friday-test/settings/$1-address.txt
done
