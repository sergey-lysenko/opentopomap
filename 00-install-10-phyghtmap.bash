#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"
v=`cat $dir/etc/phyghtmap-version`
g=`cat $dir/etc/phyghtmap-gist`
f=`cat $dir/etc/phyghtmap-file`
 
echo " "
echo "--- Downloding phyghtmap ---"
echo " "

pushd $dir/src 
 wget --no-clobber http://katze.tfiu.de/projects/phyghtmap/phyghtmap_$v.orig.tar.gz
 tar -zxvf phyghtmap_$v.orig.tar.gz
 wget --no-clobber https://gist.github.com/$g/archive/$f.zip
 unzip -jo $f.zip
 pushd phyghtmap-$v
  echo " "
  echo "--- Patching phyghtmap ---"
  echo " "
  diff ../hgt.py phyghtmap/hgt.py
  cp -v ../hgt.py phyghtmap
  echo " "
  echo "--- Installing phyghtmap ---"
  echo " "
  sudo python3 setup.py install
 popd
popd   