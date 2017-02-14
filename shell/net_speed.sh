#!/bin/bash
###统计网卡速度

bytes=$(ifconfig eth0 | grep RX | grep TX | sed 's/.*RX bytes:\([0-9]*\).*bytes:\([0-9]*\).*/\1:\2/g')
last_in=$(echo $bytes | cut -d: -f 1)
last_out=$(echo $bytes | cut -d: -f 2)
while [ 1 ]; do
sleep 1
bytes=$(ifconfig eth0 | grep RX | grep TX | sed 's/.*RX bytes:\([0-9]*\).*bytes:\([0-9]*\).*/\1:\2/g')
in=$(echo $bytes | cut -d: -f 1)
out=$(echo $bytes | cut -d: -f 2)

in_rates=$(expr \( $in - $last_in \) / 1000)
out_rates=$(expr \( $out - $last_out \) / 1000)
echo "in $in_rates KB/S"  "out $out_rates KB/S"
last_in=$in
last_out=$out

done
