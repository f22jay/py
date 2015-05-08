#!/bin/bash

if [ $# -ne 1 ];then
	echo "./dump.sh hotel_apt"
	exit
fi

echo "start dump"
#mysqldump --lock-tables=false -hdb38 -P5002 -umobile -pmobile123 mobile_service $1>$1.sql
mysqldump --lock-tables=false -hdbmobile01 -P5003 -uhotel -pQ\!Y/pd0}4MjC8? hotel $1>$1.sql

echo "start scp to devdb 192.168.11.154"
scp -c blowfish $1.sql zfj@192.168.11.154:/home/zfj/$1.sql

echo "start to reload to devdb"
ssh jun.zeng@192.168.11.154 "/usr/local/mysql/bin/mysql -h192.168.11.154 -umoon -p123 mobile_service < /home/zfj/$1.sql"
