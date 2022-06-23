#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"
 
echo " "
echo "--- Installing osm2pgsql from source ---"
echo " "

mkdir -p $dir/src
pushd $dir/src
 git clone https://github.com/openstreetmap/osm2pgsql.git
 cd osm2pgsql
 mkdir build && cd build
 cmake ..
 make
 sudo make install
popd