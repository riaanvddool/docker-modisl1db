#!/bin/bash

function usage {
  echo "Usage: terra_level1.sh MODIS_L0_FILE"
}

if [ "$#" -ne 1 ]; then
  usage
  exit
fi

pds_file=$1

modis_L1A --log --verbose --mission=T --startnudge=5 --stopnudge=5 $pds_file
level1a_file=$(ls -1t TERRA_MODIS.*.L1A.hdf | head -1)

modis_GEO --log --verbose --entrained --enable-dem --disable-download $level1a_file
geo_file=$(ls -1t TERRA*.GEO.hdf | head -1)

modis_L1B --log --verbose $level1a_file $geo_file

imapp_file_rename.py
rm Log* *pcf *.l1a.hdf