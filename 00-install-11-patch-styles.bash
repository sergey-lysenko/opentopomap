#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"

echo " "
echo "--- Patching styles ---"
echo " "

doPatch () {
 echo " "
 echo "--- Patching $1 ---"
 echo " "
 patch --verbose --forward -r - $1 patch/$1.patch
}

pushd $dir/src 

 doPatch OpenTopoMap/mapnik/styles-otm/hillshade.xml
 doPatch OpenTopoMap/mapnik/opentopomap.xml

popd