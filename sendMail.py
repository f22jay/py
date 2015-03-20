#!/usr/bin/python

import sys
import smtplib

print sys.argv
from email.mime.text import MIMEText
from email.header import Header
mss = raw_input();

sender = "zhangfangjie@meituan.com"
import pdb; pdb.set_trace()  # XXX BREAKPOINT
receiver = "f22jay@163.com"

subject = 'mapper change'
smtpserver = 'smtp.meituan.com'
username='zhangfangjie'
password='F22jay245819751'

msg=MIMEText(mss,'text','utf-8')
msg['Subject']=Header(subject,'utf-8')


smtp = smtplib.SMTP()
smtp.connect(smtpserver)

smtp.login(username,password)
smtp.sendmail(sender,receiver,msg.as_string())

smtp.quit()


