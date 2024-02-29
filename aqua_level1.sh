#!/bin/bash

function usage {
  echo "Usage: aqua_level1.sh MODIS_L0_FILE GBAD_FILE"
}

if [ "$#" -ne 2 ]; then
  usage
  exit
fi

pds_file=$1
gbad_file=$2

touch configfile

aqua_main -packetfile $gbad_file -noradfile /modisl1db/noradfile -attitudefile aqua.att -ephemerisfile aqua.eph -listconfig yes

modis_L1A --log --verbose --mission=A --startnudge=5 --stopnudge=5 $pds_file
level1a_file=$(ls -1t AQUA_MODIS.*.L1A.hdf | head -1)

modis_GEO --log --verbose --enable-dem --disable-download --att1 aqua.att --eph1 aqua.eph $level1a_file
geo_file=$(ls -1t AQUA*.GEO.hdf | head -1)

modis_L1B --log --verbose $level1a_file $geo_file

imapp_file_rename.py

rm Log* *pcf aqua.* configfile *.l1a.hdf
