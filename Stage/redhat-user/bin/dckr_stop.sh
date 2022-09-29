#!/bin/bash
SCRIPTPATH=$(dirname $0)
CONTAINER_ID=`docker ps |grep $1 |awk '{print $1}'`
echo Stop docker container $1 id $CONTAINER_ID
docker stop $CONTAINER_ID
