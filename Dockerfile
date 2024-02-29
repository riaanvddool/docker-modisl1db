FROM rvddool/modisl1db-sif:1.0 AS build

RUN yum -y install wget && yum -y clean all && rm -rf /var/cache

# download modisl1db
RUN wget --no-verbose --show-progress --progress=bar:force:noscroll \
 "https://bin.ssec.wisc.edu/pub/IMAPP/MODIS/hidden/modis_level1/v1.0/IMAPP_MODIS_LEVEL1_V1.0.tar.gz" \
 && tar -xf IMAPP_MODIS_LEVEL1_V1.0.tar.gz \
 && rm IMAPP_MODIS_LEVEL1_V1.0.tar.gz


FROM rvddool/modisl1db-sif:1.0

COPY --from=build ./modisl1db/data/share /modisl1db/ocssw/share
COPY --from=build ./modisl1db/data/var /modisl1db/ocssw/var
COPY --from=build ./modisl1db/data/noradfile /modisl1db/noradfile
COPY --from=build ./modisl1db/libexec/ocssw/bin/mlp/get_output_name_utils.py /modisl1db/ocssw/bin/mlp/get_output_name_utils.py
COPY --from=build ./modisl1db/libexec/ocssw/bin/modis_GEO /modisl1db/ocssw/bin/modis_GEO
COPY --from=build ./modisl1db/libexec/imapp_file_rename.py /modisl1db/bin/imapp_file_rename.py
COPY --from=build ./modisl1db/libexec/check_can_find_input.bash /modisl1db/bin/check_can_find_input.bash

COPY ./terra_level1.sh /terra_level1.sh
COPY ./update_luts.sh /update_luts.sh

WORKDIR /work

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN yum -y install wget && yum -y clean all && rm -rf /var/cache
RUN yum -y install findutils && yum -y clean all && rm -rf /var/cache

COPY ./test.sh /test.sh
CMD ["/test.sh"]

COPY ./aqua_level1.sh /aqua_level1.sh
