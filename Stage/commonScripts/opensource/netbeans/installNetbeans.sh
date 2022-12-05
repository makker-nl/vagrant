#!/bin/bash
#
# 2020-09-21, taken from https://tecadmin.net/install-apache-maven-on-centos/
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
NBS_ZIP=netbeans-11.3-bin.zip
NBS_ZIP_URL=https://archive.apache.org/dist/netbeans/netbeans/11.3/${NBS_ZIP}
OS_HOME=/app/opensource
NBS_HOME=$OS_HOME/netbeans
CD=$(pwd)
echo Install NetBeans
if [ ! -d "${NBS_HOME}" ]; then
  echo . Download ${NBS_ZIP} from ${NBS_ZIP_URL}
  mkdir -p $INSTALL_TMP_DIR
  wget ${NBS_ZIP_URL} -O $INSTALL_TMP_DIR/${NBS_ZIP}
  echo . Unzip $NBS_ZIP  to $OS_HOME
  unzip $INSTALL_TMP_DIR/${NBS_ZIP} -d $OS_HOME
  echo Add Netbeans to menu
  #cp $SCRIPTPATH/netbeans.desktop /usr/share/applications
  cp $SCRIPTPATH/netbeans.desktop $MENU_ENTRIES
  echo Add startscript to ~/bin
  cp $SCRIPTPATH/netbeans.sh ~/bin
  echo . Remove download
  rm -rf  $INSTALL_TMP_DIR/${NBS_ZIP}
else 
  echo . NetBeans already installed!
fi
