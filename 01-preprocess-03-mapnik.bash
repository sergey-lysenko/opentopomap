#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"

sedit () {
 sed "$1" $2 > $2.new
 diff $2 $2.new
 mv $2.new $2
}

crun () {
 [ ! -f $1.done ] && chmod 777 $1 && sudo -u postgres $1 && touch $1.done
}

pushd $dir/src/OpenTopoMap/mapnik/tools/

 echo " "
 echo "--- Updating lowzoom database ---"
 echo " "
 cc -o saddledirection saddledirection.c -lm -lgdal
 cc -Wall -o isolation isolation.c -lgdal -lm -O2
 sudo -u postgres psql gis < arealabel.sql
 crun ./update_lowzoom.sh

 echo " "
 echo "--- Updating saddles ---"
 echo " "
 sedit "s/mapnik\/dem\/dem-srtm.tiff/${dir//\//\\\/}\/var\/data\/raw.tif/" "./update_saddles.sh"
 sedit "s/cd ~\/OpenTopoMap/cd ${dir//\//\\\/}\/src\/OpenTopoMap/" "./update_saddles.sh"
 crun ./update_saddles.sh

 echo " "
 echo "--- Updating isolations ---"
 echo " "
 sedit "s/mapnik\/dem\/dem-srtm.tiff/${dir//\//\\\/}\/var\/data\/raw.tif/" "./update_isolations.sh"
 sedit "s/cd ~\/OpenTopoMap/cd ${dir//\//\\\/}\/src\/OpenTopoMap/" "./update_isolations.sh"
 crun ./update_isolations.sh

 echo " "
 echo "--- Additional updates ---"
 echo " "
 sudo -u postgres psql gis < stationdirection.sql
 sudo -u postgres psql gis < viewpointdirection.sql
 sudo -u postgres psql gis < pitchicon.sql

 echo " "
 echo "--- Linking data files ---"
 echo " "
 mkdir -p $dir/src/OpenTopoMap/mapnik/dem && cd $dir/src/OpenTopoMap/mapnik/dem
 ln -s $dir/var/data/*.tif .
popd