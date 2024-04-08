#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
SOAPUI_REL_URL=https://www.soapui.org/downloads/latest-release/
export SOAPUI_VER=$(curl -LsS  -w %{url_effective} $SOAPUI_REL_URL|grep 'Latest SoapUI Open Source Downloads'| grep '(Version' | cut -d'(' -f 2 | cut -d')' -f 1 | cut -d' ' -f 2)
SOAPUI_TAR_SHORT_NAME=SoapUI-$SOAPUI_VER-linux-bin
SOAPUI_TAR_NAME=$SOAPUI_TAR_SHORT_NAME.tar.gz
SOAPUI_URL=https://dl.eviware.com/soapuios/$SOAPUI_VER/$SOAPUI_TAR_NAME
SOAPUI_INSTALL_TMP=$INSTALL_TMP_DIR/soapui
SOAPUI_TAR_PATH=$SOAPUI_INSTALL_TMP/$SOAPUI_TAR_NAME
SOAPUI_INSTALL_NAME=SoapUI-${SOAPUI_VER}
SOAPUI_HOME=$OS_BASE/$SOAPUI_INSTALL_NAME
SOAPUI_LINK=~/bin/soapui.sh
#
echo "Checking SoapUI Home: "$SOAPUI_HOME
if [ ! -f "$SOAPUI_HOME/bin/soapui.sh" ]; then
  #
  # Download SoapUI
  echo create folder $SOAPUI_INSTALL_TMP
  mkdir -p $SOAPUI_INSTALL_TMP
  echo Download SoapUI $SOAPUI_VER from $SOAPUI_URL into  $SOAPUI_TAR_PATH
  curl -L $SOAPUI_URL -o $SOAPUI_TAR_PATH
  #
  # Install SoapUI
  echo Install SoapUI 
  echo create SOAPUI_HOME $SOAPUI_HOME
  mkdir -p $SOAPUI_HOME
  echo Untar $SOAPUI_INSTALL_TMP/$SOAPUI_TAR_NAME to $SOAPUI_INSTALL_TMP
  tar -xf $SOAPUI_INSTALL_TMP/$SOAPUI_TAR_NAME -C $SOAPUI_INSTALL_TMP
  echo Move $SOAPUI_INSTALL_TMP/$SOAPUI_INSTALL_NAME/* to $SOAPUI_HOME
  mv  $SOAPUI_INSTALL_TMP/$SOAPUI_INSTALL_NAME/* $SOAPUI_HOME
  echo Cleanup $INSTALL_TMP_DIR
  rm -rf $INSTALL_TMP_DIR
  
  echo Create link to SoapUI start script into user home
  mkdir -p ~/bin
  if [ -f "$SOAPUI_LINK" ]; then
    echo Link/file $SOAPUI_LINK already exists. So, remove it.
    rm -rf $SOAPUI_LINK
  fi
  ln -s $SOAPUI_HOME/bin/soapui.sh $SOAPUI_LINK
  echo Add to SoapUI to desktop
  cp $SCRIPTPATH/soapui.ico $SOAPUI_HOME
  envsubst < $SCRIPTPATH/soapui.desktop.tpl > $MENU_ENTRIES/soapui.desktop
else
  echo SoapUI already installed
fi