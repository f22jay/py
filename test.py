#!/usr/bin/python

import commands
import MySQLdb

print  commands.getoutput("ls -al | wc -l")

coon=MySQLdb.connect(host='192.168.11.154',port=3306,user='q3boy',passwd='123',db='mobile_service')

cur=coon.cursor()

aa=cur.execute('select * from hotel_zl_black_list limit 10')

one=cur.fetchone()
print one[2]
info = cur.fetchmany(aa)

