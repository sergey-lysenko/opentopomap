#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"
file="$HOME/.bashrc"
 
echo " "
echo "--- Modifying $file ---"
echo " "

if grep -q "python=python3" $file
then
    echo "python=python3 alias is already there"
else
    echo "adding python=python3 alias"
    echo " " >> $file
    echo "alias python=python3" >> $file
fi
