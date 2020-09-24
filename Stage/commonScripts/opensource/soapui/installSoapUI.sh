#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
#SOAPUI_VER=5.6.0
SOAPUI_VER=5.5.0
SOAPUI_ZIP_HOME=$STAGE_HOME/installBinaries/OpenSource/SoapUI
SOAPUI_INSTALL_TMP=$INSTALL_TMP_DIR/soapui
SOAPUI_INSTALL_TAR=SoapUI-${SOAPUI_VER}-linux-bin.tar.gz
SOAPUI_INSTALL_NAME=SoapUI-${SOAPUI_VER}
SOAPUI_HOME=$OS_BASE/$SOAPUI_INSTALL_NAME

#
echo "Checking SoapUI Home: "$SOAPUI_HOME
if [ ! -f "$SOAPUI_HOME/bin/soapui.sh" ]; then
 #
  # Install SoapUI
  echo Install SoapUI
  echo create folder $SOAPUI_INSTALL_TMP
  mkdir -p $SOAPUI_INSTALL_TMP
  echo create SOAPUI_HOME $SOAPUI_HOME
  mkdir -p $SOAPUI_HOME
  echo Untar $SOAPUI_ZIP_HOME/$SOAPUI_INSTALL_TAR to $SOAPUI_INSTALL_TMP
  tar -xf $SOAPUI_ZIP_HOME/$SOAPUI_INSTALL_TAR -C $SOAPUI_INSTALL_TMP
  echo Move $SOAPUI_INSTALL_TMP/$SOAPUI_INSTALL_NAME/* to $SOAPUI_HOME
  mv  $SOAPUI_INSTALL_TMP/$SOAPUI_INSTALL_NAME/* $SOAPUI_HOME
  echo Cleanup $INSTALL_TMP_DIR
  rm -rf $INSTALL_TMP_DIR
  echo Copy start script to user home
  mkdir -p ~/bin
  cp $SCRIPTPATH/soapui.sh ~/bin
else
  echo SoapUI already installed
fi