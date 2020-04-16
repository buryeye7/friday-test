#!/bin/bash

cat ~/git/friday-test/settings/account-address.txt | while read line
do
  	clif hdac transfer-to $line 1 0.01 30000000  --from $line
done
