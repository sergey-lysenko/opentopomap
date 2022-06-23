#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"
v=`cat $dir/etc/postgresql-version`
file="/etc/postgresql/$v/main/postgresql.conf"
newfile="/etc/postgresql/$v/main/postgresql.newconf"
 
echo " "
echo "--- Modifying $file ---"
echo " "

sedit () {
 sed "$1" $file | sudo tee $newfile
 diff $file $newfile
 sudo mv $newfile $file
}

sedit "s/^#\?shared_buffers = .*/shared_buffers = 128MB/"
sedit "s/^#\?work_mem = .*/work_mem = 256MB/"
sedit "s/^#\?maintenance_work_mem = .*/maintenance_work_mem = 256MB/"
sedit "s/^#\?autovacuum = .*/autovacuum = off/"
