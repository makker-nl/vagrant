#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Following https://oracle-base.com/articles/linux/docker-install-docker-on-oracle-linux-ol7
#
function prop {
    grep "${1}" $SCRIPTPATH/makeDockerUser.properties|cut -d'=' -f2
}

#
DOCKER_USER=$(prop 'docker.user')
DOCKER_GROUP=docker
#
echo 1. Install Docker Engine
echo . add ol7_addons and ol7_optional_latest repos.
sudo yum-config-manager --enable ol7_addons
sudo yum-config-manager --enable ol7_optional_latest
#
echo . install docker-engine
sudo yum install -q -y docker-engine
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
echo 5. Change docker default folder
# According to oracle-base you should create a filesystem, preferably using BTRFS, for the container-home. https://oracle-base.com/articles/linux/docker-install-docker-on-oracle-linux-ol7. 
# But let's stick with ext4.
## Adapted from  https://sanenthusiast.com/change-default-image-container-location-docker/
##https://stackoverflow.com/questions/30091681/why-does-docker-prompt-permission-denied-when-backing-up-the-data-volume
echo 5.1. Find Storage Driver
GREP_STRG_DRVR=$(sudo docker info |grep "Storage Driver")
DOCKER_STORAGE_DRVR=${GREP_STRG_DRVR#*": "}
echo "Storage Driver: ${DOCKER_STORAGE_DRVR}"
echo 5.2. Stop docker
sudo systemctl stop docker
echo 5.3. Add reference to data folders for storage.
DOCKER_DATA_HOME=/app/docker/data
echo mkdir -p ${DOCKER_DATA_HOME}
sudo mkdir ${DOCKER_DATA_HOME}
echo disable selinux enforcing
sudo setenforce 0
#
DOCKER_STORAGE_CFG=/etc/sysconfig/docker-storage
DOCKER_CONTAINER_HOME=/data/docker
sudo sh -c "echo 'DOCKER_STORAGE_OPTIONS = --graph=\"${DOCKER_DATA_HOME}\" --storage-driver=${DOCKER_STORAGE_DRVR}' >> ${DOCKER_STORAGE_CFG}"

echo 5.4 Reload deamon
sudo systemctl daemon-reload 
echo 5.5 Start docker again
sudo systemctl start docker


