#!/bin/bash
# TODO: remove excessive packages
 
echo " "
echo "--- Installing required dependencies ---"
echo " "

sudo apt update
sudo apt-get install -y \
apache2 \
apache2-dev \
autoconf \
build-essential \
bzip2 \
certbot \
clang \
cmake \
curl \
debhelper \
devscripts \
gdal-bin \
git \
libagg-dev \
libbz2-dev \
libboost-all-dev \
libcairo2-dev \
libcairomm-1.0-dev \
libfreetype6-dev \
libgd-perl \
libgdal-dev \
libgeos-dev \
libgeos++-dev \
libgeotiff-dev \
libicu-dev \
libipc-sharelite-perl \
libjson-perl \
liblua5.1-0-dev \
liblua5.2-dev \
liblua5.3-dev \
libmapnik3.0 \
libmapnik-dev \
libpq-dev \
libpng-dev \
libproj-dev \
libprotobuf-dev \
libtiff5-dev \
libtool \
libxml2-dev \
lua5.1 \
lua5.2 \
lua5.3 \
make \
mapnik-utils \
munin \
munin-node \
nano \
openssh-server \
osm2pgsql \
pkg-config \
postgis \
postgresql \
postgresql-contrib \
postgresql-12-postgis-3 \
protobuf-c-compiler \
python-setuptools \
python3 \
python3-bs4 \
python3-certbot \
python3-certbot-apache \
python3-gdal \
python3-mapnik \
python3-matplotlib \
python3-numpy \
python3-setuptools \
rsyslog \
screen \
tar \
unifont \
unzip \
wget \
zlib1g-dev