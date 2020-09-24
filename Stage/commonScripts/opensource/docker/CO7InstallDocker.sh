#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install docker on Oracle Linux.
# @author: Martien van den Akker, Darwin-IT Professionals.
# 
# CentOS variant taken from https://docs.docker.com/engine/install/centos/
#
function prop {
    grep "${1}" $SCRIPTPATH/makeDockerUser.properties|cut -d'=' -f2
}
#

echo Docker User: $NEW_USER
#
DOCKER_USER=$(prop 'docker.user')
DOCKER_GROUP=docker
#
echo 1. Install Docker Engine on CentOS
echo . Add docker-ce repo
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#
echo . install docker-engine
#sudo yum install -q -y docker-engine
sudo yum install docker-ce docker-ce-cli containerd.io
#
echo 2. Install curl 
sudo yum install -q -y  curl 
#
echo 3. Add  ${DOCKER_GROUP} group to ${DOCKER_USER}
sudo usermod -aG ${DOCKER_GROUP} ${DOCKER_USER}
#
echo 4. Check Docker install
docker --version
sudo systemctl start docker
sudo systemctl status docker
#
echo 5. Change docker default folder
# According to oracle-base you should create a filesystem, preferably using BTRFS, for the container-home. https://oracle-base.com/articles/linux/docker-install-docker-on-oracle-linux-ol7. 
# But let's stick with ext4.
## Adapted from  https://sanenthusiast.com/change-default-image-container-location-docker/
echo 5.1. Find Storage Driver
GREP_STRG_DRVR=$(sudo docker info |grep "Storage Driver")
DOCKER_STORAGE_DRVR=${GREP_STRG_DRVR#*": "}
echo "Storage Driver: ${DOCKER_STORAGE_DRVR}"
echo 5.2. Stop docker
sudo systemctl stop docker
echo 5.3. Add reference to data folders for storage.
DOCKER_DATA_HOME=/app/docker/data
echo mkdir -p ${DOCKER_DATA_HOME}
sudo mkdir -p ${DOCKER_DATA_HOME}
#

DOCKER_STORAGE_CFG=/etc/sysconfig/docker-storage
echo Check $DOCKER_STORAGE_CFG for $DOCKER_STORAGE_DRVR
if grep -Fq $DOCKER_STORAGE_DRVR $DOCKER_STORAGE_CFG
then
  echo 'WARNING: '${DOCKER_STORAGE_DRVR}' already in '${DOCKER_STORAGE_CFG}
  echo 'Skipping, please verify!'
else
  echo 'Adding '${DOCKER_STORAGE_DRVR}' to '${DOCKER_STORAGE_CFG}
  
  sudo sh -c "echo 'DOCKER_STORAGE_OPTIONS = --graph=\"${DOCKER_DATA_HOME}\" --storage-driver=${DOCKER_STORAGE_DRVR}' >> ${DOCKER_STORAGE_CFG}"
fi
#
echo 5.4 Reload deamon
sudo systemctl daemon-reload 
echo 5.5 Start docker again
sudo systemctl start docker


