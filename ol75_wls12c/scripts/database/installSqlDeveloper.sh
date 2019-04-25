#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../install_env.sh
. $SCRIPTPATH/db12c_env.sh
#
SQLDEV_ZIP_HOME=$STAGE_HOME/DBInstallation/SQLDeveloper
SQLDEV_INSTALL_HOME=$EXTRACT_HOME/DB/SQLDeveloper
SQLDEV_INSTALL_ZIP1=sqldeveloper-18.2.0.183.1748-no-jre.zip
#SQLDEV_INSTALL_ZIP1=sqldeveloper-18.1.0.095.1630-no-jre.zip
SQLDEV_INSTALL_FLDR=sqldeveloper
#
echo SQLDEV_HOME=$SQLDEV_HOME
#
if [ ! -d "$SQLDEV_HOME" ]; then
  #Unzip SQLDEV_
  if [ -f "$SQLDEV_ZIP_HOME/$SQLDEV_INSTALL_ZIP1" ]; then    
    mkdir -p $SQLDEV_INSTALL_HOME
    echo Unzip $SQLDEV_ZIP_HOME/$SQLDEV_INSTALL_ZIP1 to $SQLDEV_HOME
    unzip $SQLDEV_ZIP_HOME/$SQLDEV_INSTALL_ZIP1 -d $SQLDEV_INSTALL_HOME
    echo Move $SQLDEV_INSTALL_HOME/$SQLDEV_INSTALL_FLDR/* $SQLDEV_HOME
    mkdir -p $SQLDEV_HOME
    mv $SQLDEV_INSTALL_HOME/$SQLDEV_INSTALL_FLDR/* $SQLDEV_HOME
    rm -rf $SQLDEV_INSTALL_HOME/$SQLDEV_INSTALL_FLDR
  else
    echo $SQLDEV_ZIP_HOME/$SQLDEV_INSTALL_ZIP1 does not exist
  fi
else
  echo sqldeveloper already unzipped
fi
