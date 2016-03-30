#!/bin/bash
#
# USAGE
#
#   $ jazzamerica-dl.sh [N]
#
#       N: 0 to n to look back a past program
#

#
# XXXDIR must be followed by '/'
#
if [ -z "$TMPDIR" ]; then
    TMPDIR=/tmp/
fi

if [ -z "$TRGDIR" ]; then
    TRGDIR=./
fi


#
# path to voa
#
IDXPATH=http://russdavismoja.com/voice-america-2/
MP3PATH="http://russdavismoja.com/Music/Jazz America Show Files/"


#
# $1 location of mp3 file
# $2 number of past program (0 is most recently)
#
function prognum {
    num=`wget -q -O- $1 | grep 'JAZZ AMERICA.*SHOW' | tail -n 1 \
	| sed 's/.*#\([0-9]*\).*/\1/'`

    if [ -n "$2" ] && [ $2 -gt 0 ]; then
	num=$((num - $2))
    fi
    
    echo $num
}

#
# prepare filename by program number
#
num=`prognum $IDXPATH $1`
f1="JA"$num"seg one.mp3"
f2="JA"$num"seg two.mp3"
trg=$TRGDIR"JA"$num".mp3"


#
# get all parts of the program, then combine them.
#
if [ ! -e $trg ]; then
    wget "$MP3PATH$f1" -c -O "$TMPDIR$f1";
    wget "$MP3PATH$f2" -c -O "$TMPDIR$f2";
    ffmpeg -i concat:"$TMPDIR$f1"\|"$TMPDIR$f2" -acodec copy "$trg"
fi
