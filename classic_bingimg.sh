#!/usr/bin/env bash

URL="www.bing.com"
ADDRESS=$URL$(curl -s $URL | grep g_img={url: | sed -e s/.*g_img={url:\'// | sed 's/\.jpg.*//')".jpg"
NAME=$(echo $ADDRESS | awk -F/ '{print $(NF)}' | cut -d _ -f 1)".jpg"

curl -so archive/$NAME $ADDRESS

cp archive/$NAME /var/www/bing.jpg
