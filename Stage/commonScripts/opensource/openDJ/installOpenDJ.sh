#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
OPENDJ_ZIP_HOME=$INSTALL_HOME/OpenSource/OpenDJ
OPENDJ_INSTALL_HOME=$INSTALL_TMP_DIR/OpenSource/OpenDJ
OPENDJ_VER=4.4.11
OPENDJ_INSTALL_ZIP=opendj-$OPENDJ_VER.zip
OPENDJ_INSTALL_ZIP_DIR=$OPENDJ_INSTALL_HOME/opendj
OPENDJ_HOME=$OS_BASE/opendj
#
echo "Install OpenDJ ${OPENDJ_VER}"
echo "Checking OpenDJ Home: "$OPENDJ_HOME
if [ ! -f "$OPENDJ_HOME/bin/start-ds" ]; then
 #
  #Unzip OpenDJ
  if [ -f "$OPENDJ_ZIP_HOME/$OPENDJ_INSTALL_ZIP" ]; then
    echo Unzip $OPENDJ_ZIP_HOME/$OPENDJ_INSTALL_ZIP  to $OPENDJ_INSTALL_HOME
    mkdir -p $OPENDJ_INSTALL_HOME
    unzip -o $OPENDJ_ZIP_HOME/$OPENDJ_INSTALL_ZIP -d $OPENDJ_INSTALL_HOME
    echo Move zip subfolder $OPENDJ_INSTALL_ZIP_DIR to $OPENDJ_HOME
    mkdir -p $OPENDJ_HOME
    mv $OPENDJ_INSTALL_ZIP_DIR/* $OPENDJ_HOME
    echo Cleanup $INSTALL_TMP_DIR
    rm -rf $INSTALL_TMP_DIR
  else
    echo OpenDJ ZIP File $OPENDJ_ZIP_HOME/$OPENDJ_INSTALL_ZIP does not exist!
  fi  
else
  echo OpenDJ ${$OPENDJ_VER} already installed
fi