#!/bin/bash

rm diff.txt
i=10000
count=1000000000000
end=$((i + count))
while [ $i -lt $end ]
do
	echo $i
	i=$((i+1))
	start_time=$(echo '('`date +"%s.%N"` ' * 1000000)/1' | bc)
	curl -s "localhost:26657/broadcast_tx_async?tx=\"name=satoshi$i\""
	end_time=$(echo '('`date +"%s.%N"` ' * 1000000)/1' | bc)
	diff=$((end_time - start_time))
	echo $diff >> diff.txt
done

sum=0
cat diff.txt | while read line
do
	echo "line:" $line
	sum=`expr $sum + $line`
	echo "sum:" $sum
done
