# opentopomap

v.0.1

Goal of this repository is to automate steps described in https://github.com/der-stefan/OpenTopoMap/blob/master/mapnik/README.md

## Prerequisites

- Ubuntu 20.04 LTS Server (not yet compatible with other versions, neither older nor newer)

## Installation

- clone this repository
- observe/update parameters in ./etc directory
- execute `00-install.bash`
- execute `01-preprocess.bash`
- execute `02-run.bash`
- access XYZ tiles by http://localhost/hot/{z}/{x}/{y}.png url

## Additional Information about diffenences with original installation procedure

- added update of plugins_dir parameter in renderd.conf file
- contours stored in separate database for easier handling of changes and updates
- added patching of phyghtmap to be compatible with gdal 3.x (added handling of reversed lat/lon)
- removed any jpeg compression of rasters which was causing holes in dark sections of hillshades
- currently there's a known issue with `./update_isolations.sh` not working as expected, this is currently being investigated
- renderd executed by postgres user, while user account used for installation does not matter/used (except that it must be in sudoers list)
