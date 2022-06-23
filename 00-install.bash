#!/bin/bash

echo " "
echo "=== Installing OpenTopoMap server ==="
echo " "

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"

for file in $dir/00-install-*;
  do
  $file
  done