#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"
src=$dir/src/mod_tile.conf 
file="/etc/apache2/conf-available/mod_tile.conf"

echo " "
echo "--- Creating directories ---"
echo " "

sudo mkdir /var/lib/mod_tile
sudo chown $USER /var/lib/mod_tile
sudo mkdir /var/run/renderd
sudo chown $USER /var/run/renderd

echo " "
echo "--- Copying $file ---"
echo " "

sudo cp -v $src $file 

echo " "
echo "--- Enabling mod_tile ---"
echo " "

sudo a2enconf mod_tile

src=$dir/src/000-default.renderd.conf 
file="/etc/apache2/sites-available/000-default.conf"
 
echo " "
echo "--- Modifying $file ---"
echo " "

match="\tDocumentRoot"
sed -E ':a;N;$!ba;s/\//\\\//g' $src | sudo tee $src.s
sed -E ':a;N;$!ba;s/\t/\\t/g' $src.s | sudo tee $src.ts
sed -E ':a;N;$!ba;s/\n/\\n/g' $src.ts | sudo tee $src.nts
insert=`cat $src.nts`
pattern="s/$match/$insert\n$match/"

sedit () {
 sed "$1" $file | sudo tee $file.new
 diff $file $file.new
 sudo mv $file.new $file
}

if grep -q "LoadTileConfigFile" $file
then
 echo "LoadTileConfigFile parameter is already there"
else
 echo "adding apache configuration"
 sedit "$pattern"
fi
rm -f $src.*

echo " "
echo "--- Reloading apache2 ---"
echo " "

sudo service apache2 reload
sudo service apache2 status

