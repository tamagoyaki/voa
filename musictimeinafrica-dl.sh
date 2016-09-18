#!/bin/bash
#
# USAGE
#
#   $ musictimeinafrica-dl.sh [N]
#
#       N: 0 to n to look back a past program
#

# How past ?
NUM=1

if [ -n "$1" ] && [ $1 -gt 0 ]; then
    NUM=$((NUM + $1))
fi

#
# URL format
#
# http://av.voanews.com/clips/VEN/2016/03/05/20160305-090000-VEN091-program.mp3
#
HEADER=http://av.voanews.com/clips/VEN/
TRAILER=-090000-VEN091-program.mp3

#
# $1 string of date
#
function download {
    year=`date -d $1 +%Y`
    mon=`date -d $1 +%m`
    day=`date -d $1 +%d`
    url="$HEADER$year/$mon/$day/$year$mon$day$TRAILER"
    wget -c $url
    #echo $url
}

#
# every saturday and sunday on air
#
download $NUM"weeks-ago-saturday"

#
# sunday's program is rerun
#
# download $NUM"weeks-ago-sunday"
