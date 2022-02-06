#! /bin/bash
# Start the metaverseserver with persistant data in local dir

BASE=$(pwd)
cd "${BASE}"

DVERSION=latest

docker run -d \
    --name=vircadia-web \
    -p 8080:8080 \
    --volume ${BASE}/log:/home/cadia/vircadia-web/log \
    vircadia-web:${DVERSION}
