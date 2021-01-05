#!/bin/bash
#
# 2020-09-21, taken from https://tecadmin.net/install-apache-maven-on-centos/
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
PMN_TAR=postman.tar.gz
PMN_TAR_URL=https://dl.pstmn.io/download/latest/linux64
PMN_BIN=/opt/Postman/Postman
CD=$(pwd)
echo Install Postman
if [ ! -f "${PMN_BIN}" ]; then
  echo . Install libXScrnSaver because of required shared object.
  sudo yum -q -y install libXScrnSaver
  echo . Download ${PMN_TAR} from ${PMN_TAR_URL}
  sudo wget ${PMN_TAR_URL} -O ${PMN_TAR}
  echo . Untar $PMN_TAR 
  sudo tar xzf $PMN_TAR -C /opt
  echo . Make symbolic link
  sudo ln -s ${PMN_BIN} /usr/bin/postman
  echo Add Postman to menu
  sudo cp $SCRIPTPATH/postman.desktop /usr/share/applications
  echo . Remove download
  sudo rm -rf ./${PMN_TAR}
else 
  echo . Postman already installed!
fi
