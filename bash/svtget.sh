#!/bin/bash

# SVTGet v0.1
# Updates can be found at http://svtget.se/
# Support with Flattr: 
#
# Description: The script can download the RTMP streams available from the
# online streaming service "SVT Play", managed by Sveriges Television
#
# Original author: Mikael "MMN-o" Nordfeldth
# URL: http://blog.mmn-o.se/
# Flattr: https://flattr.com/thing/188162/MMN-o-on-Flattr
# Bitcoin: 1Nt5H47TU76pFpnaX6FQQvzLoS6F4sXC3Y

# Changelog:
# v0.1:
#

# Sample usage:
# ./svtget.sh http://svtplay.se/v/2440756/k_special/presspauseplay

DEPENDENCIES="rtmpdump curl"
for DEP in $DEPENDENCIES; do
	if [ -z "`which $DEP`" ]; then
		echo "ERROR: Dependency '$DEP' not in PATH. If you're running Debian/Ubuntu, ask your administrator or do:"
		echo "sudo apt-get install $DEPENDENCIES"
	fi
done

if [ -z "$1" ]; then
	echo "Usage: $0 http://svtplay.se/v/..."
	exit 1
fi

if [[ ! "$1" =~ http://svt ]]; then
	echo "Bad URL. Not SVT Play?"
	exit
fi

TMP_FILE="/tmp/svtget.$$"
curl -s "$1" -o "$TMP_FILE"
SVTPLAY_SWF="http://svtplay.se$(grep 'application/x-shockwave-flash' $TMP_FILE | cut -d\" -f4)"
SVTGET_STREAMS=$(sed "s/\(rtmp:[^|]*\),bitrate:\([0-9]\+\)/\n\2|\1\n/g" $TMP_FILE | grep rtmp | sort | uniq )
echo ----------------------
echo $SVTGET_STREAMS
echo ----------------------
rm "$TMP_FILE"

if [ -z "$SVTGET_STREAMS" ]; then
	echo "ERROR: No rtmp streams found. Website structure changed?"
	echo "Please visit http://svtget.se/ for updates and information. If the website's down, use a search engine to find copies."
	exit 1
fi

echo "Using SWF for rtmpdump --swfVfy: $SVTPLAY_SWF"

echo "#  Bitrate	Filename"
let n=0
for STREAM in $SVTGET_STREAMS; do
	let n++
	BITRATE=`echo $STREAM | cut -d '|' -f 1 -`
	expr $BITRATE + 1 &> /dev/null
	if [ $? -gt 0 ] || [ "$BITRATE" -eq 0 ]; then
		continue
	fi
	URL=`echo $STREAM | cut -d '|' -f 2 -`
	FILENAME=`echo $STREAM | cut -d '/' -f8 -`
	echo "$n. ${BITRATE} kbps	$FILENAME"
	Streams[$n]="$URL"
	Filenames[$n]="$FILENAME"
done

stream=0
while [ -z ${Streams[$stream]} ]; do
	echo ""
	echo "Which file do you want? [#] "
	read stream
	if [ -n "$stream" ] && [ "q" == "$stream" ]; then
		exit
	fi
done

echo Running RTMPDump for "${Streams[$stream]}" and saving to "${Filenames[$stream]}"

rtmpdump -r "${Streams[$stream]}" --swfVfy="$SVTPLAY_SWF" -o "${Filenames[$stream]}"