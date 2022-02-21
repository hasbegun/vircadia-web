#! /bin/bash
if [ -z "$1" ]
then
    WEB_SDK_VER=2022.1.2
    echo "Vircadia Web SDK version is not supplied."
else
    WEB_SDK_VER=$1
fi
echo "Vircadia Web SDK version ${WEB_SDK_VER} is used."

REPO=hasbegun
BRANCH=dev_ssl
COMMIT=$(git rev-parse --short HEAD)

docker build -t vircadia-web \
  --build-arg WEB_SDK_VER=${WEB_SDK_VER} \
  --build-arg=REPO=$REPO \
  --build-arg=BRANCH=$BRANCH \
  --build-arg=COMMIT=$COMMIT \
  -f Dockerfile .
