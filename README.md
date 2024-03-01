# IMAPP MODIS L1 processor
The International MODIS/AIRS Processing Package (IMAPP) allows ground stations capable of receiving direct broadcast data from the NASA Terra and Aqua spacecraft to create a suite of products from the MODIS instruments. The IMAPP software is maintained and distrubuted by the University of Wisconsin-Madison Space Science and Engineering Center (SSEC): https://cimss.ssec.wisc.edu/imapp

This repository repackages the IMAPP L1 processor into a Docker container. This is not an official IMAPP repository and the author is not affiliated with SSEC in any way.    

## Disclaimer

There is no expressed or implied warranty made to anyone as to the suitability of this software
for any purpose. All risk of use is assumed by the user. 


## Testing

```
docker-compose build
docker-compose up
```

## Docker base image

This solution uses a Docker base image created from the MODISL1DB Singularity Image File (SIF) distributed by SSEC.

The base image was created by exporting the `squashfs` filesystem from the Singularity Image File (SIF). To reproduce, use the following steps:

Step 1: Download `IMAPP_MODIS_LEVEL1_V1.0.tar.gz` and extract `modisl1db.sif`
```
wget https://bin.ssec.wisc.edu/pub/IMAPP/MODIS/hidden/modis_level1/v1.0/IMAPP_MODIS_LEVEL1_V1.0.tar.gz
tar -xzf IMAPP_MODIS_LEVEL1_V1.0.tar.gz
rm IMAPP_MODIS_LEVEL1_V1.0.tar.gz
cp modisl1db/libexec/modisl1db.sif .
rm -r modisl1db
```

Step 2: Dump the SIF filesystem to a squashfs file 
```
# Find out which SIF ID to use (look for Squashfs)
singularity sif list modisl1db.sif
singularity sif dump 4 modisl1db.sif > data.squash
rm modisl1db.sif
```

Step 3: Use `unsquashfs` to extract the filesystem into a local directory
```
unsquashfs -dest data data.squash
rm data.squash
```

Step 4: Build a new Docker image using the Dockerfile below:

```
FROM scratch
COPY data /
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/modisl1db/bin
CMD ["/bin/bash"]
```

The image is available on Docker Hub: https://hub.docker.com/repository/docker/rvddool/modisl1db-sif
