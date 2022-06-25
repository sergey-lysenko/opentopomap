#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"
c=`cat $dir/etc/country`
r=`cat $dir/etc/region`
file="$c-latest.osm.pbf"

start=`date +"%s"`

echo " "
echo "--- Downloading '$file' map data ---"
echo " "

pushd $dir/var/data

 wget --no-clobber  http://download.geofabrik.de/$r/$file
 mkdir updates
 cd updates
 wget --no-clobber http://download.geofabrik.de/$r-updates/state.txt

 echo " "
 echo "--- Importing map data into database ---"
 echo " "
 sudo -u postgres osm2pgsql --slim -d gis -C 12000 --number-processes 10 --style $dir/src/OpenTopoMap/mapnik/osm2pgsql/opentopomap.style $dir/var/data/$file
popd

finish=`date +"%s"`
echo "$0 execution took `bc <<< ${finish}-${start}` seconds"
