#!/bin/bash
SCRIPTPATH=$(dirname $0)
CONTAINER_ID=`docker ps |grep $1 |awk '{print $1}'`
echo Shell to docker container $1 id $CONTAINER_ID
docker exec -it $CONTAINER_ID  /bin/bash
