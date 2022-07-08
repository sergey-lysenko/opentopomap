#!/bin/bash

echo " "
echo "=== Installing OpenTopoMap server ==="
echo " "

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"

for file in $dir/00-install-*;
  do
  $file
  done

pushd $dir
 df -h
 du -h --max-depth=1
popd