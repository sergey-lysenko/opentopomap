#!/bin/bash

dir="$( dirname -- "$( readlink -f -- "$0"; )"; )"
m=`cat $dir/etc/maps`
r=`cat $dir/etc/resolutions`
c=`cat $dir/etc/cresolutions`
 
start=`date +"%s"`
 
echo " "
echo "--- Downloding height data files ---"
echo " "

mkdir -p $dir/var/srtm
pushd $dir/var/srtm
 for map in $m
 do
  wget --no-clobber http://viewfinderpanoramas.org/dem3/$map.zip
 done
 
 echo " "
 echo "--- Unpacking heihgt data ---"
 echo " "

 for zipfile in *.zip
 do 
  unzip -jn "$zipfile" -d unpacked
 done

 pushd $dir/var/srtm/unpacked
 
  echo " "
  echo "--- hgt -> tiff ---"
  echo " "
  for hgtfile in *.hgt
  do
   [ ! -f $hgtfile.tif ] && echo -n "$hgtfile -> $hgtfile.tif: " && gdal_fillnodata.py $hgtfile $hgtfile.tif
  done

  echo " "
  echo "--- Merging all tiffs to $dir/var/data/raw.tif ---"
  echo " "
  mkdir -p $dir/var/data
   [ ! -f $dir/var/data/raw.tif ] && gdal_merge.py -n 32767 -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2 -o $dir/var/data/raw.tif *.hgt.tif
  pushd $dir/var/data

   echo " "
   echo "--- Generation of scaled tiffs ---"
   echo " "
   for res in $r
   do
    [ ! -f warp-$res.tif ] && echo -n "$res m: " && gdalwarp -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2 -t_srs "+proj=merc +ellps=sphere +R=6378137 +a=6378137 +units=m" -r bilinear -tr $res $res raw.tif warp-$res.tif
   done
   
   echo " "
   echo "--- Generation of color reliefs ---"
   echo " "
   for cres in $c
   do
    [ ! -f relief-$cres.tif ] && echo -n "$cres m: " && gdaldem color-relief -co COMPRESS=LZW -co PREDICTOR=2 -alpha warp-$cres.tif $dir/src/OpenTopoMap/mapnik/relief_color_text_file.txt relief-$cres.tif
   done

   echo " "
   echo "--- Generation of scaled hillshades ---"
   echo " "
   for res in $r
   do
    [ ! -f hillshade-$res.tif ] && echo -n "$res m: " && gdaldem hillshade -z 7 -compute_edges -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW warp-$res.tif hillshade-$res.tif
   done
  popd
 popd
popd

finish=`date +"%s"`
echo "$0 execution took `bc <<< ${finish}-${start}` seconds"
