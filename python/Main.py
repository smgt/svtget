#!/usr/bin/env python3.2
# -*- coding: utf-8 -*-
# vim:fileencoding=utf8
import urllib.request
import urllib.parse
import io
import json
import os

url = urllib.parse.urlencode({"url" : "http://svtplay.se/t/157980/pojkskolan_med_gareth_malone"})
url = url.encode('utf-8')
url = "http://svtget.se/get/get.php?" + str(url, 'utf-8')
HTTP_socket = urllib.request.urlopen(url)
HTML_source = HTTP_socket.read().decode('utf-8')
HTTP_socket.close()
io = io.StringIO(HTML_source)
moo = json.load(io)

print("#	Bitrate	Filename")
n=0
for stream in moo['streams']:
	print(n, "	" + stream[1] + "	" + stream[0])
	n+=1
stream = moo['streams']
lfile = moo['program_name'] + ".mp4"
userinput = int(input("Which file do you want? [#] "))
get = stream[userinput][0]
print ("Running RTMPDump for " + get + " and saving it as " + lfile)
os.system('rtmpdump -r ' + get + ' --swfVfy=' + moo['swf_url'] + ' -o ' + lfile)
