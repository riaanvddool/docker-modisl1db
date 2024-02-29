#!/bin/bash

if [ -d "modis_level1_test_data" ]; then
  echo "Test data already downloaded"
else
  echo "Downloading test data..."
  wget -N --show-progress --progress=bar:force:noscroll https://bin.ssec.wisc.edu/pub/IMAPP/MODIS/hidden/modis_level1/v1.0/IMAPP_MODIS_LEVEL1_V1.0_TEST_DATA.tar.gz
  tar -xzf IMAPP_MODIS_LEVEL1_V1.0_TEST_DATA.tar.gz
  rm IMAPP_MODIS_LEVEL1_V1.0_TEST_DATA.tar.gz
fi

/terra_level1.sh modis_level1_test_data/input/P0420064AAAAAAAAAAAAAA23221145411001.PDS
/aqua_level1.sh modis_level1_test_data/input/P1540064AAAAAAAAAAAAAA23219205954001.PDS modis_level1_test_data/input/P1540957AAAAAAAAAAAAAA23219205954001.PDS

cd modis_level1_test_data
./modisl1_compare.bash output /work | tee /work/test_report.txt

