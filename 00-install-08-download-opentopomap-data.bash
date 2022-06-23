#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"
v=`cat $dir/etc/water-polygons-version`

src="https://github.com/der-stefan/OpenTopoMap.git" 
 
echo " "
echo "--- Downloading $src ---"
echo " "

cd $dir/src
git clone $src
cd OpenTopoMap/mapnik
mkdir data && cd data

wuz () {
 [ ! -f "$1" ] && wget --no-clobber https://osmdata.openstreetmap.de/download/$1
 unzip -n $1
}

echo " "
echo "--- Downloading water polygons version $v ---"
echo " "

wuz simplified-water-polygons-split-$v.zip
wuz water-polygons-split-$v.zip