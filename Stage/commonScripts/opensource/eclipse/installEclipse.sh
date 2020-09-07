#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
ECLIPSE_ZIP_HOME=$STAGE_HOME/installBinaries/OpenSource/Eclipse
ECLIPSE_INSTALL_NAME=Eclipse-2020-06
ECLIPSE_INSTALL_TMP=$INSTALL_TMP_DIR/$ECLIPSE_INSTALL_NAME
ECLIPSE_INSTALL_TAR=eclipse-java-2020-06-R-linux-gtk-x86_64.tar.gz
ECLIPSE_HOME=$OS_BASE/$ECLIPSE_INSTALL_NAME/eclipse

#
echo "Checking Eclipse Home: "$ECLIPSE_HOME
if [ ! -f "$ECLIPSE_HOME/eclipse" ]; then
 #
  # Install Eclipse
  echo Install Eclipse
  echo create folder $ECLIPSE_INSTALL_TMP
  mkdir -p $ECLIPSE_INSTALL_TMP
  echo create ECLIPSE_HOME $ECLIPSE_HOME
  mkdir -p $ECLIPSE_HOME
  echo Untar $ECLIPSE_ZIP_HOME/$ECLIPSE_INSTALL_TAR to $ECLIPSE_INSTALL_TMP
  tar -xf $ECLIPSE_ZIP_HOME/$ECLIPSE_INSTALL_TAR -C $ECLIPSE_INSTALL_TMP
  echo Move $ECLIPSE_INSTALL_TMP/eclipse/* to $ECLIPSE_HOME
  mv  $ECLIPSE_INSTALL_TMP/eclipse/* $ECLIPSE_HOME
  echo Cleanup $INSTALL_TMP_DIR
  rm -rf $INSTALL_TMP_DIR
  echo Copy start script to user home
  mkdir -p ~/bin
  cp $SCRIPTPATH/eclipse.sh ~/bin
else
  echo Eclipse already installed
fi