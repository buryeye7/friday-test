#!/bin/bash

PW="12345678"
for i in {2..100}
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
