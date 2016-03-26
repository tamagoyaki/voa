#!/bin/bash

TMPJA=/tmp

LIVEURL=http://voa-28.akacast.akamaistream.net/7/54/322040/v1/ibb.akacast.akamaistream.net/voa-28
JAZZAM=http://russdavismoja.com/voice-america-2/
JAZZJA="http://russdavismoja.com/Music/Jazz America Show Files/"
RSSINE=http://www.voanews.com/podcast/\?count=20\&zoneId=1451

function jafilename {
    num=`wget -q -O- $1 | grep 'JAZZ AMERICA.*SHOW' | tail -n 1 \
	| sed 's/.*#\([0-9]*\).*/\1/'`
    echo "JA"$num"seg"
}

function podcast {
    wget -q -O- $1 | grep 'url.*mp3' | head -n 1 \
	| sed 's/.*\(http:.*mp3\).*/\1/'
}

IFS=$','
CHS="quit,live global,pod jazz,pod international"

select ch in $CHS; do
	if [ "$ch" = "quit" ]; then
	    exit
	elif [ "$ch" = "live global" ]; then
	    mplayer -loop 0 $LIVEURL
	elif [ "$ch" = "pod jazz" ]; then
	    fn=`jafilename $JAZZAM`
	    f1="$fn one.mp3"
	    f2="$fn two.mp3"

	    # cache
	    if [ ! -e $TMPJA/$f1 ]; then
		wget $JAZZJA$f1 -O $TMPJA/$f1;
	    fi
	    
	    if [ ! -e $TMPJA/$f2 ]; then
		wget $JAZZJA$f2 -O $TMPJA/$f2;
	    fi

	    # play cached files
	    mplayer $TMPJA/$f1 $TMPJA/$f2
	elif [ "$ch" = "pod international" ]; then
	    mplayer -loop 0 `podcast $RSSINE`
	fi
done


