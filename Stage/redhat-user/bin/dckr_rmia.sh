#!/bin/bash
SCRIPTPATH=$(dirname $0)
echo Remove all docker images
docker rmi $(docker images -a -q)
