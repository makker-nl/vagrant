#!/bin/bash
#
# Download the LInux X64 Compressed Archive from https://www.oracle.com/nl/java/technologies/javase-jdk11-downloads.html
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../install_env.sh
#
JAVA_HOME=$ORACLE_BASE/product/jdk11
JAVA_INSTALL_HOME=$INSTALL_HOME/Oracle/Java
JAVA_INSTALL_TMP=$INSTALL_TMP_DIR/jdk
#JAVA_INSTALL_TAR=jdk-11.0.10_linux-x64_bin.tar.gz
#JAVA_INSTALL_NAME=jdk-11.0.10
JAVA_INSTALL_TAR=jdk-11.0.16.1_linux-x64_bin.tar.gz
JAVA_INSTALL_NAME=jdk-11.0.16.1
#
echo "Checking Java Home: "$JAVA_HOME
if [ ! -f "$JAVA_HOME/bin/java" ]; then
 #
  #Unzip Java
  if [ -f "$JAVA_INSTALL_HOME/$JAVA_INSTALL_TAR" ]; then
	  # Install jdk
	  echo Install jdk 
	  echo create folder $JAVA_INSTALL_TMP
	  mkdir -p $JAVA_INSTALL_TMP
	  echo create JAVA_HOME $JAVA_HOME
	  mkdir -p $JAVA_HOME
	  echo Untar $JAVA_ZIP_HOME/$JAVA_INSTALL_TAR to $JAVA_INSTALL_TMP
	  tar -xf $JAVA_INSTALL_HOME/$JAVA_INSTALL_TAR -C $JAVA_INSTALL_TMP
	  echo Move $JAVA_INSTALL_TMP/$JAVA_INSTALL_NAME/* to $JAVA_HOME
	  mv  $JAVA_INSTALL_TMP/$JAVA_INSTALL_NAME/* $JAVA_HOME
	  echo Cleanup $INSTALL_TMP_DIR
	  rm -rf $INSTALL_TMP_DIR
  else
    echo $JAVA_INSTALL_HOME/$JAVA_INSTALL_TAR does not exist.
  fi
else
  echo jdk 11 already installed
fi