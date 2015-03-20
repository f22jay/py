#!/usr/bin/python
import sys
import urllib2
import urllib
import re

downed={}
x=0

def gethtml(url):
    header={
            'User-Agent':'Mozilla/5.0 (Windows NT 6.2; rv:16.0) Gecko/20100101 Firefox/16.0',
            'Accept':'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            'Connection':'keep-alive'
            }
    request = urllib2.Request(url,headers=header)
    con = urllib2.urlopen(request)
    html = con.read()
    html =  html.decode('utf-8','replace').encode(sys.getfilesystemencoding())

    return html

def downhtml(url,name):
    header={
            'User-Agent':'Mozilla/5.0 (Windows NT 6.2; rv:16.0) Gecko/20100101 Firefox/16.0',
            'Accept':'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            'Connection':'keep-alive'
            }
    request = urllib2.Request(url,headers=header)
    try :
        con = urllib2.urlopen(request)
        html = con.read()
        html =  html.decode('utf-8','replace').encode(sys.getfilesystemencoding())
        fp = open(name,"wb")
        fp.write(html)
    except Exception ,e:
        print e

def geturl(html):
    url_re = r'"(http\S*)"'
    url_com = re.compile(url_re)
    match_rul = re.findall(url_com,html)
    return match_rul
def recurse_down(url):
    global x
    if downed.has_key(url):
        return
    else:
        downed[url]="down"
    print downed
    html=gethtml(url)
    urls =  geturl(html)
    for i in urls:
        if i.__contains__("sina"):
            if  i.endswith("/"):
                print "recurse_down",i
                recurse_down(i)
            else :
                try:
                    print "get" ,i
                    name = i.split("/")
                    urllib.urlretrieve(i,"sina/%s" %(name[-1]))
                    #downhtml(i,"sina/%s" %(name[-1]))
                    x+=1
                    print "got" ,i
                except Exception,e:
                    print e



#recurse_down("http://www.360doc.com/")
#downhtml("http://www.360doc.com/","360")
recurse_down("http://www.sina.com.cn/")
