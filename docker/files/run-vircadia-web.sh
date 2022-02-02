#! /bin/bash

BASE=/home/cadia/vircadia-web

# Default location for logs is in the Iamus sub-directory
LOGDIR=${BASE}/log
# If a log directory is provided in the mounted 'config' dir, use that one
if [[ -d "/home/cadia/vircadia-web/log" ]] ; then
    LOGDIR=/home/cadia/vircadia-web/log
fi
mkdir -p "${LOGDIR}"

LOGFILE=${LOGDIR}/$(date --utc "+%Y%m%d.%H%M").log

cd /usr/local/src/vircadia-web
npm run serve >> ${LOGFILE} 2>&1
