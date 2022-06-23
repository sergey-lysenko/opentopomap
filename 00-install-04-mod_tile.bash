#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"

echo " "
echo "--- Installing mod_tile ---"
echo " "

pushd $dir/src
 git clone  https://github.com/SomeoneElseOSM/mod_tile.git
 cd mod_tile
 ./autogen.sh
 ./configure
 make
 sudo make install
 sudo make install-mod_tile
 sudo ldconfig
popd