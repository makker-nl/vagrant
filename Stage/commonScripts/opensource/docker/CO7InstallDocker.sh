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
DOCKER_USER=$(prop 'docker.user')
DOCKER_GROUP=docker
echo Docker User: $DOCKER_USER
#
echo 1. Install Docker Engine on CentOS
echo . Add docker-ce repo
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#
echo . install docker-engine
#sudo yum install -q -y docker-engine
sudo yum install -q -y docker-ce docker-ce-cli containerd.io
#
echo 2. Install curl 
sudo yum install -q -y  curl 
#
echo 3. Add  ${DOCKER_GROUP} group to ${DOCKER_USER}
# https://www.digitalocean.com/community/questions/how-to-fix-docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket
sudo groupadd ${DOCKER_GROUP} 
sudo usermod -aG ${DOCKER_GROUP} ${DOCKER_USER}
#
echo 4. Check Docker install
docker --version
sudo systemctl start docker
sudo systemctl status docker
#
echo 5. Change docker default folder
echo 5.1. Stop docker
sudo systemctl stop docker
echo 5.2. Add reference to data folders for storage.
# Taken from:
# https://www.digitalocean.com/community/questions/how-to-move-the-default-var-lib-docker-to-another-directory-for-docker-on-linux
DOCKER_DATA_HOME=/app/docker/data
DOCKER_STRT_STMT="ExecStart=/usr/bin/dockerd"
DOCKER_STRT_STMT_EXP="${DOCKER_STRT_STMT} -g ${DOCKER_DATA_HOME}"
DOCKER_SVC_SCR=/lib/systemd/system/docker.service
echo mkdir -p ${DOCKER_DATA_HOME}
sudo mkdir -p ${DOCKER_DATA_HOME}
if grep -Fq "$DOCKER_STRT_STMT_EXP" $DOCKER_SVC_SCR
then
  echo "WARNING: ${DOCKER_STRT_STMT_EXP} already in ${DOCKER_SVC_SCR}"
  echo "Skipping, please verify!"
else
  echo "Change  ${DOCKER_STRT_STMT} to ${DOCKER_STRT_STMT_EXP} to ${DOCKER_SVC_SCR}"
  sudo sed -i "s|${DOCKER_STRT_STMT} |${DOCKER_STRT_STMT_EXP} |g" ${DOCKER_SVC_SCR}
fi
#
echo 5.4 Reload deamon
sudo systemctl daemon-reload 
echo 5.5 Start docker again
sudo systemctl start docker
echo 5.6 Enable docker as a systemd service
#https://docs.docker.com/engine/install/linux-postinstall/#configure-docker-to-start-on-boot
sudo systemctl enable docker