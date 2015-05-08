#!/usr/bin/python
#coding=utf-8

import sys
import smtplib
from email.mime.text import MIMEText
from email.header import Header

'''pdb 调试  发送邮件
'''


mss = raw_input();

sender = "zhangfangjie@meituan.com"
import pdb; pdb.set_trace()  # XXX BREAKPOINT
receiver = "f22jay@163.com"

subject = 'mapper change'
smtpserver = 'smtp.meituan.com'
username='zhangfangjie'
password='rrrrrrrrrrrrrrrr'

msg=MIMEText(mss,'text','utf-8')
msg['Subject']=Header(subject,'utf-8')


smtp = smtplib.SMTP()
smtp.connect(smtpserver)
smtp.login(username,password)
smtp.sendmail(sender,receiver,msg.as_string())

smtp.quit()


