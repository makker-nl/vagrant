#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
#
OC_TAR=oc.tar
OC_TAR_PATH=$STAGE_HOME/installBinaries/RedHat
OC_HOME=/app/redhat/openshift
OC_BIN=$OC_HOME/bin/oc
CD=$(pwd)
echo Install OpenShift cli
if [ ! -f "${OC_BIN}" ]; then
  mkdir -p $OC_HOME/bin
  echo . Untar $OC_TAR_PATH/$OC_TAR 
  sudo tar xf $OC_TAR_PATH/$OC_TAR -C $OC_HOME/bin
  echo . Make symbolic link
  sudo ln -s ${OC_BIN} /usr/bin/oc
else 
  echo . OpenShift cli already installed!
fi
