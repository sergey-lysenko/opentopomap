#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"

start=`date +"%s"`

 echo " "
 echo "--- Patching ---"
 echo " "
 cp -vr $dir/src/patch/* $dir/src

finish=`date +"%s"`
echo "$0 execution took `bc <<< ${finish}-${start}` seconds"
