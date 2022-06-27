#!/bin/bash
#
# 2020-09-21, taken from https://tecadmin.net/install-apache-maven-on-centos/
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#NJS_REPO_URL=https://rpm.nodesource.com/setup_10.x
NJS_REPO_URL=https://rpm.nodesource.com/setup_18.x
CD=$(pwd)
echo Install NodeJS 10
if [ ! -d "${NBS_HOME}" ]; then
  echo . Add NodeJS repo to system: ${NJS_REPO_URL}
  curl -sL NJS_REPO_URL | sudo bash -
  echo . Install NodeJS
  sudo yum -yq install nodejs
  echo . Check NodeJS version
  node --version
  echo . Check npm version
  npm --version
else 
  echo . NetBeans already installed!
fi
