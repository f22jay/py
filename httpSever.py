#!/usr/bin/python

import socket

HOST=''
PORT= 8000
reply = 'yes'

s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

s.bind((HOST,PORT))

s.listen(100)

while True:
    conn,addr = s.accept()
    request = conn.recv(1024)

    print 'request is : ' ,request
    print 'adder is :' ,addr

    conn.sendall(reply)

    conn.close()

