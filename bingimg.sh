#!/usr/bin/env bash

help_msg() {
	echo "Usage: $0 [-h] [-a dir] [-d path] [-n name]"
	echo "Options:"
	echo "  -a <dir>   archive picture in given directory"
	echo "  -d <path>  destination of picture (default's current directory)"
	echo "  -h         display this message"
	echo "  -n <name>  choose name for picture"
}

while getopts ":a:d:hn:" opt; do
	case $opt in
		a)
			ARCHIVE=$OPTARG
			if [[ ! $ARCHIVE =~ ^.*\/$ ]]; then
				ARCHIVE=$ARCHIVE"/"
			fi
			if [ ! -d "$ARCHIVE" ]; then
				echo "No such directory: $ARCHIVE"
				exit 1
			fi
			;;
		d)
			DEST="$OPTARG"
			if [[ ! $DEST =~ ^.*\/$ ]]; then
				DEST=$DEST"/"
			fi
			if [ ! -d "$DEST" ]; then
				echo "No such directory: $DEST"
				exit 1
			fi
			;;
		h)
			help_msg
			exit 0
			;;

		n)
			FILE=$OPTARG
			;;
		\?)
			echo "Invalid option -$opt" >&2
			help_msg
			exit 1
			;;
		:)
			echo "Option -$opt requires an argument" >&2
			help_msg
			exit 1
			;;
	esac
done

URL="www.bing.com"
ADDRESS=$URL$(curl -s $URL | grep g_img={url: | sed -e s/.*g_img={url:\'// | sed 's/\.jpg.*//')".jpg"
NAME=$(echo $ADDRESS | awk -F/ '{print $(NF)}' | cut -d _ -f 1)".jpg"

curl -so $DEST$NAME $ADDRESS

if [ -n "$ARCHIVE" ]; then
	cp $DEST$NAME $ARCHIVE
fi

if [ -n "$FILE" ]; then
	mv $DEST$NAME $DEST$FILE
fi
