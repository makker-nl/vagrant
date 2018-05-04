#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/db12c_install_env.sh
#
SQLCL_STAGE_HOME=/media/sf_Stage/DBInstallation
SQLCL_ZIP_HOME=$SQLCL_STAGE_HOME/Zipped/SQLCL
SQLCL_INSTALL_HOME=$SQLCL_STAGE_HOME/Extracted/SQLCL
SQLCL_INSTALL_ZIP1=sqlcl-17.4.0.354.2224-no-jre.zip
#
echo SQLCL_HOME=$SQLCL_HOME
#
if [ ! -d "$SQLCL_HOME" ]; then
  #Unzip SQLCL_
  if [ -f "$SQLCL_ZIP_HOME/$SQLCL_INSTALL_ZIP1" ]; then    
    mkdir -p $SQLCL_INSTALL_HOME
    echo Unzip $SQLCL_ZIP_HOME/$SQLCL_INSTALL_ZIP1 to $SQLCL_HOME
    unzip $SQLCL_ZIP_HOME/$SQLCL_INSTALL_ZIP1 -d $SQLCL_INSTALL_HOME
    echo Move $SQLCL_INSTALL_HOME/sqlcl/* $SQLCL_HOME
    mkdir -p $SQLCL_HOME
    mv $SQLCL_INSTALL_HOME/sqlcl/* $SQLCL_HOME
    rm -rf $SQLCL_INSTALL_HOME/sqlcl
  else
    echo $SQLCL_ZIP_HOME/$SQLCL_INSTALL_ZIP1 does not exist
  fi
else
  echo sqlcl already unzipped
fi
