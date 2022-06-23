#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"
src=$dir/src/renderd.otm.conf 
file="/usr/local/etc/renderd.conf"
 
echo " "
echo "--- Modifying $file ---"
echo " "

sedit () {
 sed "$1" $file | sudo tee $file.new
 diff $file $file.new
 sudo mv $file.new $file
}

sedit "s/plugins_dir=.*/plugins_dir=\/usr\/lib\/mapnik\/3.0\/input/"
sedit "s/num_threads=.*/num_threads=4/"
sedit "s/XML=.*/XML=${dir//\//\\\/}\/src\/OpenTopoMap\/mapnik\/opentopomap.xml/"
sedit "s/URI=.*/URI=\/hot\//"
