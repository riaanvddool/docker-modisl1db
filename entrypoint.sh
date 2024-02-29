#!/bin/sh

export OCSSWROOT=/modisl1db/ocssw
source $OCSSWROOT/OCSSW_bash.env
export PATH=/modisl1db/gbad/bin:$PATH
export PATH=/modisl1db/bin:$PATH

exec "$@"