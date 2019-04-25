#!/bin/bash
#
#Download a zip with tar.gz containing complete JDK
#On MOS: Search for Doc ID 1439822.1
#Download latest 1.8 (public) patch, eg.:
#27412872 	Oracle JDK 8 Update 172 (complete JDK, incl. jmc, jvisualvm)
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../install_env.sh
. $SCRIPTPATH/fmw12c_env.sh
#
JAVA_ZIP_HOME=$STAGE_HOME/Java
JAVA_INSTALL_HOME=$EXTRACT_HOME/Java
JAVA_INSTALL_TMP=$INSTALL_TMP_DIR/jdk
#JAVA_INSTALL_ZIP=p27412872_180172_Linux-x86-64.zip
JAVA_INSTALL_ZIP=p27890715_180181_Linux-x86-64.zip
JAVA_INSTALL_TAR=jdk-8u181-linux-x64.tar.gz
JAVA_INSTALL_NAME=jdk1.8.0_181

#
echo "Checking Java Home: "$JAVA_HOME
if [ ! -f "$JAVA_HOME/bin/java" ]; then
 #
  #Unzip Java
if [ ! -f "$JAVA_INSTALL_HOME/$JAVA_INSTALL_TAR" ]; then
    if [ -f "$JAVA_ZIP_HOME/$JAVA_INSTALL_ZIP" ]; then
      echo Unzip $JAVA_ZIP_HOME/$JAVA_INSTALL_ZIP  to $JAVA_INSTALL_HOME/$JAVA_INSTALL_TAR
      mkdir -p $JAVA_INSTALL_HOME
      unzip -o $JAVA_ZIP_HOME/$JAVA_INSTALL_ZIP -d $JAVA_INSTALL_HOME
    else
      echo JAVA Zip File $JAVA_ZIP_HOME/$JAVA_INSTALL_ZIP does not exist!
    fi  
  else
    echo $JAVA_INSTALL_TAR already unzipped
  fi
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
  echo jdk 1.8 already installed
fi