#!/bin/bash

# dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"
file="/etc/sysctl.conf"
 
echo " "
echo "--- Modifying $file ---"
echo " "

if grep -q "kernel.shmmax" $file
then
    echo `grep "kernel.shmmax" $file` is already there
else
    echo "adding parameter"
    echo ' ' | sudo tee -a $file
    echo 'kernel.shmmax=268435456' | sudo tee -a $file
fi
