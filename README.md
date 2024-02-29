# IMAPP MODIS L1 processor
The International MODIS/AIRS Processing Package (IMAPP) allows ground stations capable of receiving direct broadcast data from the NASA Terra and Aqua spacecraft to create a suite of products from the MODIS instruments. The IMAPP software is maintained and distrubuted by the University of Wisconsin-Madison Space Science and Engineering Center (SSEC): https://cimss.ssec.wisc.edu/imapp

This solution uses a Docker base image created from the MODISL1DB Singularity Image File (SIF) distributed by SSEC.
https://hub.docker.com/repository/docker/rvddool/modisl1db-sif

## Disclaimer

There is no expressed or implied warranty made to anyone as to the suitability of this software
for any purpose. All risk of use is assumed by the user. 


## Testing

```
docker-compose build
docker-compose up
```