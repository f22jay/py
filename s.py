#!/usr/bin/python
#coding=utf-9
'''
发送文件 以html形式
'''

import sys
import smtplib

print sys.argv
from email.mime.text import MIMEText
from email.header import Header
from email.mime.multipart import MIMEMultipart

sender = "zhangfangjie@meituan.com"
receiver =["zhangfangjie@meituan.com"]

subject = 'mapper change'
smtpserver = 'smtp.meituan.com'
username='zhangfangjie'
password='rrrrrrrrrrrrrrr'

html=open("1","rb").read()
msg=MIMEMultipart()
html=MIMEText(str(html),'html','utf-8')

msg['Subject']=Header(subject,'utf-8')
msg.attach(html)

smtp = smtplib.SMTP()
smtp.connect(smtpserver)
smtp.login(username,password)
smtp.sendmail(sender,receiver,msg.as_string())

smtp.quit()


