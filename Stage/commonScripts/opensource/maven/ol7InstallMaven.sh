#!/bin/bash
#
# 2020-09-21, taken from https://tecadmin.net/install-apache-maven-on-centos/
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
MVN_VER=3.6.3
MVN_TAR=apache-maven-${MVN_VER}-bin.tar.gz
MVN_TAR_URL=https://www-eu.apache.org/dist/maven/maven-3/${MVN_VER}/binaries/${MVN_TAR}
CD=$(pwd)
echo Install Apache Maven
echo . Change dir to /opt
cd /opt
echo . Download ${MVN_TAR_URL}
sudo wget ${MVN_TAR_URL}
echo . Untar $MVN_TAR
sudo tar xzf $MVN_TAR
echo . Make symbolic link
sudo ln -s apache-maven-3.6.3 maven
echo . Copy $SCRIPTPATH/maven.sh to /etc/profile.d
sudo cp $SCRIPTPATH/maven.sh /etc/profile.d
echo . Remove downloaded 
sudo rm -rf ./${MVN_TAR}
echo . Change dir back to $CD
cd $CD