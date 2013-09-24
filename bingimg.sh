#!/bin/bash

cd ~/bingimg

wget -q www.bing.com
BINGPIC="$(cat index.html | grep g_img={url: | sed -e s/.*g_img={url:\'// | sed 's/\.jpg.*//')"
ADDRESS="www.bing.com"
ADDRESS+=$BINGPIC
ADDRESS+=".jpg"
#echo $ADDRESS
wget -q $ADDRESS

FILE=$(echo $ADDRESS | cut -d '/' -f 5)
DEST=$(echo $FILE | cut -d '_' -f 1)
DEST+=".jpg"

rm index.html
mv $FILE archive/$DEST

cp archive/$DEST /var/www/bing.jpg
