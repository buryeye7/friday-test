#!/bin/bash

PW=12345678
for i in {1..10000}
do
	for j in {1..100}
	do
		echo $j
		random=$(expr $RANDOM % 100)
		random=$((random+1))
		#ps -ef | grep defunct
		#ps -ef | grep defunct | awk '{print $3}' | xargs kill -9
		ps -ef | grep clif | awk '{print $2}' | xargs kill -9
		clif hdac transfer-to friday1sqv4r0lw2t2fqdq5j3xfrt6lpktl35dlte8st0 $random 0.01 30000000 --from node$j --chain-id testnet &
		ps -ef | grep "clif" | while read line
		do 
			echo "line:" $line
			if [ "$line" != *"grep"* ];then
				pid=$(echo $line | awk -F' ' '{print $2}')
				echo "pid ================== "$pid
				sudo echo "y\r" > "/proc/$pid/fd/0"
				sudo echo "$PW\r" > "/proc/$pid/fd/0"
			fi
		done
		sleep 0.01
	done
done
