#!/bin/bash -xv
###清理线上机器日志用的,规则比较多，逻辑复杂

clear_hotel()
{
	if [[ $2 -lt 60 ]]; then
	  return
	fi

	date=`date  +%Y-%m-%d`
	if test -d $1 ; then
		echo "no hotel dir"
		return
	fi
	api_files=$(find ./ -name "api_time*gz" | grep -v $date)
	if [ -n "$api_files" ] ;then
	for file in $api_files
	do
	echo $file
	rm $file
	done 
	fi
	if dir1_files=$(find ./ -name "hotel*" | grep -v $date) ;then
	return
	fi
	if [ $2 -gt 85 ]; then
	dir1_files=$(find ./ -name "hotel*")
	fi
	#clean file
	if [ -z $dir1_files  ];then
		return
	fi
	for file in $dir1_files
	do
	    echo $file  
	    rm $file
	done
}


clear_logs()
{
if [[ $2 -lt 70 ]]; then
return
fi

if [[ "$3" == "1" ]]; then
echo "delete 2个月的"
month=$(date  +%Y-%m  | awk -F"-"  '{month=$2-1; print month}')
else
echo "delete 1个月的"
month=$(date  +%Y-%m  | awk -F"-"  '{month=$2; print month}')
fi

year=$(date  +%Y-%m  | awk -F"-"  '{print $1}')
if [ $month -le 0 ] ; then
    month=$(($month+12))
    year=$(($year-1))
fi

if [ $month -lt 10 ] ; then
    month="0$month"
fi
clear_time="$year-$month-01"
files=`ls  -alh --time-style=long-iso $1 | awk '$6< "'"$clear_time"'"{print $8}'   | grep "gz" `
for file in $files
do
    echo $1"/"$file	
    rm $1"/"$file
done
}


#print disk stats
date +%m-%d-%H:%M
df -m | grep "/opt"

#clear big logs hotel need 50+   small logs need 70+
threhold=$(df -m | grep "/opt"  | awk '{print $5}' | awk -F"%"  '{print $1}')

dir1="/opt/logs/mobile/hotel"
dir2="/opt/logs/mobile/hotel/logs"


echo "start clean..."

clear_hotel $dir1 $threhold
clear_logs $dir2  $threhold 1

threhold1=$(df -m | grep "/opt"  | awk '{print $5}' | awk -F"%"  '{print $1}')

#任然大于90,加大力度
if [[ $threhold1 -ge 90 ]]; then
clear_logs $dir2  $threhold 0
echo "urgent"
fi


echo "clean  done..."

