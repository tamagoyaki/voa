#!/bin/bash
#
# USAGE
#
#   $ international-dl.sh [N]
#
#       N: 0 to n to look back a past program
#

#
# XXXDIR must be followed by '/'
#
if [ -z "$TRGDIR" ]; then
    TRGDIR=./
fi


#
# path to voa
#
IEPATH=http://www.voanews.com/podcast/\?count=20\&zoneId=1451


# select a program
sel=$(($1 + 1))
url=`wget -q -O- $IEPATH | grep 'url.*mp3' | sed -n $sel,$sel"p" \
    | sed 's/.*\(http:.*mp3\).*/\1/'`
name=`basename $url`


# download
if [ -n "$url" ]; then
    wget $url -c -O $name
fi

