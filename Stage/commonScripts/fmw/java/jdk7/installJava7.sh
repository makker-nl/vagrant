#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../install_env.sh
. $SCRIPTPATH/java7_env.sh
#
JAVA_ZIP_HOME=$INSTALL_HOME/Java
JAVA_INSTALL_HOME=$EXTRACT_HOME/Java
JAVA_INSTALL_TMP=$INSTALL_TMP_DIR/jdk
JAVA_INSTALL_TAR=jdk-7u80-linux-x64.tar.gz
JAVA_INSTALL_NAME=jdk1.7.0_80
#
echo "Checking Java Home: "$JAVA_HOME
if [ ! -f "$JAVA_HOME/bin/java" ]; then
 #
  #Check Java
  if [ ! -f "$JAVA_INSTALL_HOME/$JAVA_INSTALL_TAR" ]; then
    echo JAVA Tar File  $JAVA_ZIP_HOME/$JAVA_INSTALL_TAR does not exist!
  else
    # Install jdk
    echo Install jdk 
    echo create folder $JAVA_INSTALL_TMP
    mkdir -p $JAVA_INSTALL_TMP
    echo create JAVA_HOME $JAVA_HOME
    mkdir -p $JAVA_HOME
    echo Untar $JAVA_ZIP_HOME/$JAVA_INSTALL_TAR to $JAVA_INSTALL_TMP
    tar -xzf $JAVA_ZIP_HOME/$JAVA_INSTALL_TAR -C $JAVA_INSTALL_TMP
    echo Move $JAVA_INSTALL_TMP/$JAVA_INSTALL_NAME/* to $JAVA_HOME
    mv  $JAVA_INSTALL_TMP/$JAVA_INSTALL_NAME/* $JAVA_HOME
    echo Cleanup $INSTALL_TMP_DIR
    rm -rf $INSTALL_TMP_DIR
  fi
else
  echo jdk 1.7 already installed
fi