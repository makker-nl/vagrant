#!/bin/bash
#
#Download a zip with tar.gz containing complete JDK
#On MOS: Search for Doc ID 1439822.1
#Download latest 1.8 (public) patch, eg.:
#27412872 	Oracle JDK 8 Update 172 (complete JDK, incl. jmc, jvisualvm)
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../install_env.sh
#
JAVA_HOME=$ORACLE_BASE/product/jdk8
JAVA_INSTALL_HOME=$INSTALL_HOME/Oracle/Java
JAVA_INSTALL_TMP=$INSTALL_TMP_DIR/jdk
#JAVA_INSTALL_TAR=jdk-8u261-linux-x64.tar.gz
#JAVA_INSTALL_NAME=jdk1.8.0_261
JAVA_INSTALL_TAR=jdk-8u341-linux-x64.tar.gz
JAVA_INSTALL_NAME=jdk1.8.0_341

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
  echo jdk 1.8 already installed
fi