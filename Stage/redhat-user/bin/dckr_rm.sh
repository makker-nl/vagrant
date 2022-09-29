#!/bin/bash
SCRIPTPATH=$(dirname $0)
CONTAINER_ID=`docker ps -a |grep $1 | awk '{print $1}'`
echo Remove docker container $1 with id $CONTAINER_ID
docker rm $CONTAINER_ID  --force
