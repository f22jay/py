#!/bin/bash
###统计外网端口
SAVE_LOG=dst_ip_port
TIME=`date +%s`
while [ `date +%s` -lt $((TIME + 10)) ];do
#	tcpdump -i eth0 -nn -c 100000 src net 192.168.0.0/16 and dst net ! 192.168.0.0/16 and \(tcp or udp\)|cut -d" " -f3,5,6|awk '{a[$0]}END{for(i in a)print i}'>>$SAVE_LOG
	tcpdump -i eth0 -nn -c 1000 src net 192.168.0.0/16 and dst net ! 192.168.0.0/16 and \(tcp or udp\)|cut -d" " -f3,5 | cut -d: -f1 |awk '{split($2,snum,".");port=snum[5];a[port]++;}END{for (i in a) print i;}' >> $SAVE_LOG 
done
