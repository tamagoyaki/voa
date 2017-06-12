#!/bin/bash
#
# USAGE
#
#   $ learningenglish-dl.sh
#
# NOTE
#
#   There are two mp3 files which have the same name. The one is 64kbps,
#   the other one is 128kbps.
#
#   For example
#
#     128kbps: 2016 3a3d7fad-d2f3-47f7-9489-13725b1f5117_hq.mp3
#     64kbps : 2016 3a3d7fad-d2f3-47f7-9489-13725b1f5117.mp3
#

URL=http://learningenglish.voanews.com

if [ "grammar" == "$1" ]; then
    LATEST=$URL/archive/everyday-grammar/latest/4456
    file=4456.html
elif [ "broadcast" == "$1" ]; then
    LATEST=$URL/z
    file=1689.html
else
    echo ""
    echo "USAGE:"
    echo ""
    echo "   ./learningenglish-dl [grammar|broadcast] "
    echo ""
    echo "       grammar : everyday grammar"
    echo "       broadcast : learning english broadcast"
    echo ""
    exit
fi

url=$LATEST/$file


while [ -n "$url" ]; do
    wget -c $url
    list=`awk '/<li class="col-xs-12/,/<\/li>/' $file | grep '<a href.*>' | sed 's/.*href="\(.*\)".*>/http:\/\/learningenglish.voanews.com\1/'`

    #echo $list

    for html in $list; do
	fn=`basename $html`

	# for time saving (optional)
	if [ -e $fn ]; then
	    continue
	fi

	wget -c $html
	mp3s=`cat $fn | grep '^<audio' | sed 's/.*\(https*[^$;]*\.mp3\).*\(https*:.*\.mp3\).*/\1 \2/'`
	wget -c $mp3s

	# echo $mp3s
	# exit
    done

    showmore=`cat $file | grep 'btn link-showMore' | sed 's/.*href="\(.*\)">Load more.*/\1/'`

    if [ -n "$showmore" ]; then
	url=$URL/$showmore
	file=`basename $showmore`
    else
	url=""
    fi
done
