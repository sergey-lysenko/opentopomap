#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"
r=`cat $dir/etc/contours-resolution`
s=`cat $dir/etc/contours-step`
f="$dir/etc/contours-epsilon"
if [ -f "$f" ]; then
    e=--simplifyContoursEpsilon=`cat $f`
else 
    e=""
fi
j=`cat $dir/etc/contours-jobs`

file="contours.pbf"

start=`date +"%s"`
 
echo " "
echo "--- Generating contours ---"
echo " "

pushd $dir/var/data

 [ ! -f $file ] && phyghtmap $e --max-nodes-per-tile=0 -j $j -s $s -0 --pbf warp-$r.tif
 [ ! -f $file ] && mv lon-*.osm.pbf $file

 echo " "
 echo "--- Importing contours into database ---"
 echo " "
 sudo 
 sudo -u postgres osm2pgsql --slim -d contours -C 12000 --number-processes 10 --style $dir/src/OpenTopoMap/mapnik/osm2pgsql/contours.style $dir/var/data/contours.pbf
popd

finish=`date +"%s"`
echo "$0 execution took `bc <<< ${finish}-${start}` seconds"
