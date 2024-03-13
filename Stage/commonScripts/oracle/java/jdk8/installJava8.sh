#!/bin/bash
#
# Download the Linux X64 Compressed Archive from https://www.oracle.com/java/technologies/downloads/#java8
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../install_env.sh
#
JAVA_HOME=$ORACLE_BASE/product/jdk8
JAVA_INSTALL_HOME=$INSTALL_HOME/Oracle/Java
JAVA_INSTALL_TMP=$INSTALL_TMP_DIR/jdk
JDK_BASE_NAME=jdk-8*
JAVA_INSTALL_TAR=$(find $JAVA_INSTALL_HOME -type f -name $JDK_BASE_NAME  | awk -F"/" '{print $NF}' | sort -r | head -1)
#
echo "Checking Java Home: "$JAVA_HOME
if [ ! -f "$JAVA_HOME/bin/java" ]; then
  if [[ -z "$JAVA_INSTALL_TAR" ]]; then
    echo There is no $JDK_BASE_NAME*.tgz file in $JAVA_INSTALL_HOME.
  else
	  # Install and unzip jdk 
    echo Try to install Jdk8 from $JAVA_INSTALL_HOME/$JAVA_INSTALL_TAR
	  echo create folder $JAVA_INSTALL_TMP
	  mkdir -p $JAVA_INSTALL_TMP
	  echo create JAVA_HOME $JAVA_HOME
	  mkdir -p $JAVA_HOME
	  echo Untar $JAVA_ZIP_HOME/$JAVA_INSTALL_TAR to $JAVA_INSTALL_TMP
	  tar -xf $JAVA_INSTALL_HOME/$JAVA_INSTALL_TAR -C $JAVA_INSTALL_TMP
    JAVA_INSTALL_NAME=$(find $JAVA_INSTALL_TMP/* -maxdepth 0 -type d  | awk -F"/" '{print $NF}' | sort -r | head -1)
	  echo Move $JAVA_INSTALL_TMP/$JAVA_INSTALL_NAME/* to $JAVA_HOME
	  mv  $JAVA_INSTALL_TMP/$JAVA_INSTALL_NAME/* $JAVA_HOME
	  echo Cleanup $INSTALL_TMP_DIR
	  rm -rf $INSTALL_TMP_DIR
  fi
else
  echo jdk 1.8 already installed
fi
if [ -f "$JAVA_HOME/bin/java" ]; then
  $JAVA_HOME/bin/java -version
fi