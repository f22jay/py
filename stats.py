#!/usr/bin/python
#coding=utf-8
'''
统计日志 发送报告邮件
'''

import sys
import operator

file=open("./stastic.log","rb")
nums={}
sums={}
mins={}
maxs={}
avgs={}

for i in file.readlines():
    ss=str(i).split()
    if len(ss)>0:
        if nums.has_key(ss[6]):
            nums[ss[6]]=1+int(nums[ss[6]])
        else:
            nums[ss[6]]=1
        if sums.has_key(ss[6]):
            sums[ss[6]]+=int(ss[8])
        else:
            sums[ss[6]]=int(ss[8])
        if maxs.has_key(ss[6]):
            if maxs[ss[6]] < int(ss[8]):
                maxs[ss[6]]=int(ss[8])
        else:
            maxs[ss[6]]=int(ss[8])
        if mins.has_key(ss[6]):
            if mins[ss[6]] > int(ss[8]):
                mins[ss[6]]=int(ss[8])
        else:
            mins[ss[6]]=int(ss[8])


for key,value in nums.items():
    avgs[key]=sums[key]/nums[key]


sort_avgs=sorted(avgs.iteritems(),key=operator.itemgetter(1),reverse=True)

print avgs
print sort_avgs

print "<table border=\"1\">"
print "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>" %("method","nums","avg","max","min")
for item in sort_avgs:
    print "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>" %(item[0],nums[item[0]],item[1],maxs[item[0]],mins[item[0]])
print "</table>"


