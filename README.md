# opentopomap

v.0.1.2

Goal of this repository is to automate steps described in https://github.com/der-stefan/OpenTopoMap/blob/master/mapnik/README.md

## Prerequisites

- Ubuntu 20.04 LTS Server (not yet compatible with other versions, neither older nor newer)

## Installation

- clone this repository
- update `./etc/region` and `./etc/country` (refer to http://download.geofabrik.de/ for possible values)
- update `./etc/maps` (refer to http://viewfinderpanoramas.org/Coverage%20map%20viewfinderpanoramas_org3.htm for possible values)
- observe/update other parameters in ./etc directory
- execute `./00-install.bash`
- execute `./01-preprocess.bash`
- execute `./02-run.bash`
- access XYZ tiles by http://localhost/hot/{z}/{x}/{y}.png url

## Additional Information about diffenences with original installation procedure

- added update of **plugins_dir** parameter in `renderd.conf` file
- currently there's a known issue with `./update_isolations.sh` not working as expected, this is currently being investigated
- renderd executed by postgres user, while user account used for installation does not matter/used (except that it must be in sudoers list)

### Hillshades

- jpeg compression of rasters was removed. Is was causing holes in dark sections of hillshades
- hillshades scaling for zoom8 and more set to bicubic instead of bilinear, which was causing visible square artifacts in darker shades
- generation of 60m and 30m data was added as well as correspondent hillshade styles, but those aren't used as of now, because of low quality of rasters. Way to produce more valid high resolition hillshades is under inverstigation.

### Contours

- contours are stored in separate database for easier handling of changes and updates
- added patching of phyghtmap to be compatible with version 3.x of gdal (added handling of reversed lat/lon)
- utilized phyghtmap's --simplifyContoursEpsilon parameter which simplifies contours. Without this parameter, generated contours contain a lot of noice data as well as lines are too "blocky"
- аmount of simplification is configurable by changing of `./etc/contours-epsilon` parameter
- recommended values are between **0.0001** and **0.0005**
- setting of **0.0000** does not deactivate simplification, but sets it to remove extra geometry only
- activated simplification reduces amount of required RAM and size of generated data, but **increases runtime significantly**
- to deactivate simplification, remove `./etc/contours-epsilon` file completely
