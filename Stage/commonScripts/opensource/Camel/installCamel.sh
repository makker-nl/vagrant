#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
CML_ZIP_HOME=$STAGE_HOME/installBinaries/OpenSource/Camel
CML_INSTALL_NAME=apache-camel-3.5.0
CML_INSTALL_TMP=$INSTALL_TMP_DIR/$CML_INSTALL_NAME
CML_INSTALL_TAR=apache-camel-3.5.0.tar.gz
CML_HOME=$OS_BASE/$CML_INSTALL_NAME
CML_SUB_DIR=$CML_INSTALL_NAME
#
echo "Checking Camel Home: "$CML_HOME
if [ ! -d "$CML_HOME" ]; then
 #
  # Install Camel
  echo Install Camel
  echo create folder $CML_INSTALL_TMP
  mkdir -p $CML_INSTALL_TMP
  echo create CML_HOME $CML_HOME
  mkdir -p $CML_HOME
  echo Untar $CML_ZIP_HOME/$CML_INSTALL_TAR to $CML_INSTALL_TMP
  tar -xf $CML_ZIP_HOME/$CML_INSTALL_TAR -C $CML_INSTALL_TMP
  echo Move $CML_INSTALL_TMP/$CML_SUB_DIR/* to $CML_HOME
  mv  $CML_INSTALL_TMP/$CML_SUB_DIR/* $CML_HOME
  echo Cleanup $INSTALL_TMP_DIR
  rm -rf $INSTALL_TMP_DIR
else
  echo Camel already installed
fi