#!/bin/bash
SCRIPTPATH=$(dirname $0)
IMAGE_ID=`docker images  |grep $1 | awk '{print $3}'`
echo Remove docker image $1 with id $IMAGE_ID
docker rmi $IMAGE_ID  --force
