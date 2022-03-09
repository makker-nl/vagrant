#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../install_env.sh
. $SCRIPTPATH/db12c_env.sh
#
SQLCL_ZIP_HOME=$STAGE_HOME/DBInstallation/SQLCL
SQLCL_INSTALL_HOME=$EXTRACT_HOME/DB/SQLCL
SQLCL_INSTALL_ZIP1=sqlcl-18.2.0.zip
#SQLCL_INSTALL_ZIP1=sqlcl-17.4.0.354.2224-no-jre.zip
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
