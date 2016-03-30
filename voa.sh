#!/bin/bash


#
# search path
#
JADIR=./
IEDIR=./

LIVEURL=http://voa-28.akacast.akamaistream.net/7/54/322040/v1/ibb.akacast.akamaistream.net/voa-28

#
# $1 filename pattern
#
function recentone {
    ls $1 -t | head -n 1
}

IFS=$','
CHS="quit,live global,pod jazz,pod international"

select ch in $CHS; do
	if [ "$ch" = "quit" ]; then
	    exit
	elif [ "$ch" = "live global" ]; then
	    mplayer -loop 0 $LIVEURL
	elif [ "$ch" = "pod jazz" ]; then
	    TRGDIR=$JADIR . jazzamerica-dl.sh
	    file=`recentone $JADIR"JA*.mp3"`
	elif [ "$ch" = "pod international" ]; then
	    . international-dl.sh
	    file=`recentone $IEDIR"*VEN*.mp3"`
	else
	    continue
	fi

	# for podcast
	if [ -e "$file" ]; then
	    mplayer -loop 0 $file
	fi
done


