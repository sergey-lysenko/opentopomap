#!/bin/bash

echo " "
echo "=== Preprocessing data ==="
echo " "

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"

for file in $dir/01-preprocess-*;
  do
  $file
  done