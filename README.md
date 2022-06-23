# opentopomap

v.0.1

Goal of this repository is to automate steps described in https://github.com/der-stefan/OpenTopoMap/blob/master/mapnik/README.md

## Prerequisites

- Ubuntu 20.04 LTS Server

## Installation

- clone this repository
- observe/update parameters in ./etc directory
- execute `00-install.bash`
- execute `01-preprocess.bash`
- execute `02-run.bash`
- access XYZ tiles by http://localhost/hot/{z}/{x}/{y}.png url
