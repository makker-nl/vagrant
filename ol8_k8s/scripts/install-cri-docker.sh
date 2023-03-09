#!/bin/bash
# Taken from https://www.mirantis.com/blog/how-to-install-cri-dockerd-and-migrate-nodes-from-dockershim/
#
SCRIPTPATH=$(dirname $0)
#
# Check latest version here: https://github.com/Mirantis/cri-dockerd/releases
CRID_VER=0.3.1 
CRID_TAR=cri-dockerd-${CRID_VER}.amd64.tgz
CRID_TAR_URL=https://github.com/Mirantis/cri-dockerd/releases/download/v${CRID_VER}/${CRID_TAR}
CRID_HOME=/opt/cri-dockerd
CD=$(pwd)
echo Install cri-dockerd
echo . Change dir to $CRID_HOME
sudo mkdir -p $CRID_HOME
cd $CRID_HOME/..
echo . Download ${CRID_TAR_URL}
sudo wget ${CRID_TAR_URL}
echo . Untar $CRID_TAR
sudo tar xzf $CRID_TAR
echo . Make symbolic link
sudo rm /usr/local/bin/cri-dockerd
sudo ln -s $CRID_HOME/cri-dockerd /usr/local/bin/cri-dockerd
echo Check cri-dockerd version
cri-dockerd --version

echo Configure systemd
sudo wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.service
sudo wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.socket
sudo mv cri-docker.socket cri-docker.service /etc/systemd/system/
#
CRI_DCKR_STRT_STMT="ExecStart=/usr/bin/cri-dockerd"
CRI_DCKR_STRT_STMT_EXP="/usr/local/bin/cri-dockerd"
CRI_DCKR_SVC_SCR=/etc/systemd/system/cri-docker.service
#
if grep -Fq "$CRI_DCKR_STRT_STMT_EXP" $DOCKER_SVC_SCR
then
  echo "WARNING: ${CRI_DCKR_STRT_STMT_EXP} already in ${DOCKER_SVC_SCR}"
  echo "Skipping, please verify!"
else
  echo "Change  ${CRI_DCKR_STRT_STMT} to ${CRI_DCKR_STRT_STMT_EXP} to ${DOCKER_SVC_SCR}"
  sudo sed -i -e 's,${CRI_DCKR_STRT_STMT},${CRI_DCKR_STRT_STMT_EXP},' ${DOCKER_SVC_SCR}
fi

echo Start the service with cri-dockerd enabled
sudo systemctl daemon-reload
sudo systemctl enable cri-docker.service
sudo systemctl enable --now cri-docker.socket

echo Verify that the service is running
sudo systemctl status cri-docker.socket

echo . Remove downloaded ${CRID_TAR}
sudo rm -rf ./${CRID_TAR}
echo . Change dir back to $CD
cd $CD


