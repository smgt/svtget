#!/usr/bin/env python3.2
# -*- coding: utf-8 -*-
# vim:fileencoding=utf8
import urllib.request
import urllib.parse
import io
import json
import os
import sys

user_input_url = str(input("URL to the stream "))

if user_input_url.startswith("http://svt") is not True:
	print("Bad URL. Not SVT Play?")
	sys.exit()

final_url = "http://svtget.se/get/get.php?" + str(urllib.parse.urlencode({"url" : user_input_url}).encode('utf-8'), 'utf-8')
HTTP_socket = urllib.request.urlopen(final_url)
HTML_source = HTTP_socket.read().decode('utf-8')
HTTP_socket.close()
io = io.StringIO(HTML_source)
json_data = json.load(io)

print("#	Bitrate	Filename")

n=0

for tcUrl in json_data['tcUrls']:
	print(n, "	" + tcUrl[1] + "	" + tcUrl[0])
	n+=1

stream = json_data['tcUrls']

lfile = json_data['program_name'] + ".mp4"

user_input_n = int(input("Which file do you want? [#] "))

print("Running RTMPDump on " + json_data['tcUrls'][user_input_n][0] + " and saving it as " + json_data['program_name'] + ".mp4")

os.system('rtmpdump -r ' + json_data['tcUrls'][user_input_n][0] + ' --swfVfy=' + json_data['swfUrl'] + ' -o ' + json_data['program_name'] + '.mp4')
