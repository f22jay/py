#!/usr/bin/awk  -f
#统计日志文件  与stats.py类似
BEGIN{
	while (getline < "./stastic.log" > 0){
		nums[$7]++;
		time[$7]+=$9;
		if (max[$7]<$9)
			max[$7]=$9;
		if (! min[$7] || min[$7]>$9)
			min[$7]=$9;
		}
	exit;
}
END{
	printf("<table border=\"1\"><tr><td>%-100s </td><td> %-10s </td><td> %-10s </td><td> %-10s  </td><td> %-10s</td></tr>\n" ,"method","nums","avg","max","min");
for (i in nums){
	if ( i)
	printf("<tr><td>%-100s </td><td> %-10d </td><td> %-10d </td><td> %-10d  </td><td> %-10d</td></tr>\n" ,i,nums[i],time[i]/nums[i],max[i],min[i]);
	}
}
