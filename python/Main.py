#!/usr/bin/env python3.2
# -*- coding: utf-8 -*-
# vim:fileencoding=utf8
import urllib.request
import urllib.parse
import io
import json
import os
import sys

lurl = str(input("URL to the stream "))
if lurl.startswith("http://svt") is not True:
	print("Bad URL. Not SVT Play?")
	sys.exit()

url = "http://svtget.se/get/get.php?" + str(urllib.parse.urlencode({"url" : lurl}).encode('utf-8'), 'utf-8')
HTTP_socket = urllib.request.urlopen(url)
HTML_source = HTTP_socket.read().decode('utf-8')
HTTP_socket.close()
io = io.StringIO(HTML_source)
moo = json.load(io)

print("#	Bitrate	Filename")
n=0
for tcUrl in moo['tcUrls']:
	print(n, "	" + tcUrl[1] + "	" + tcUrl[0])
	n+=1
stream = moo['tcUrls']
lfile = moo['program_name'] + ".mp4"
userinput = int(input("Which file do you want? [#] "))
get = stream[userinput][0]
print ("Running RTMPDump for " + get + " and saving it as " + lfile)
os.system('rtmpdump -r ' + get + ' --swfVfy=' + moo['swfUrl'] + ' -o ' + lfile)
