#!/bin/bash

echo " "
echo "=== Running renderd ==="
echo " "

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"

sudo mkdir /var/run/renderd
sudo chown postgres /var/run/renderd
sudo chown postgres /var/lib/mod_tile
sudo -u postgres renderd -f -c /usr/local/etc/renderd.conf
