#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"
 
echo " "
echo "--- Creating database ---"
echo " "

sudo -u postgres createuser --createdb gis -s
sudo -u postgres psql -c "CREATE DATABASE gis;"
sudo -u postgres psql -c "CREATE DATABASE contours;"
sudo -u postgres psql -d gis -c 'CREATE EXTENSION postgis;'
sudo -u postgres psql -d contours -c 'CREATE EXTENSION postgis;'