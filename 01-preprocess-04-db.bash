#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"

 echo " "
 echo "--- Checking database sizes ---"
 echo " "
 sudo -u postgres psql -d gis -c "SELECT pg_database.datname, pg_size_pretty(pg_database_size(pg_database.datname)) AS size FROM pg_database;"