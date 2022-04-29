#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../install_env.sh
#
export ORACLE_BASE=/app/oracle
export SQLCL_HOME=$ORACLE_BASE/product/sqlcl
export SQLDEV_HOME=$ORACLE_BASE/product/sqldeveloper
#
SQLDEV_ZIP_HOME=$INSTALL_HOME/Oracle/DB/SQLDeveloper
SQLDEV_INSTALL_HOME=$EXTRACT_HOME/Oracle/DB/SQLDeveloper
#SQLDEV_INSTALL_ZIP=sqldeveloper-18.2.0.183.1748-no-jre.zip
#SQLDEV_INSTALL_ZIP=sqldeveloper-19.4.0.354.1759-no-jre.zip
SQLDEV_INSTALL_ZIP=sqldeveloper-21.4.3.063.0100-no-jre.zip
SQLDEV_INSTALL_FLDR=sqldeveloper
#
echo SQLDEV_HOME=$SQLDEV_HOME
#
if [ ! -d "$SQLDEV_HOME" ]; then
  #Unzip SQLDEV_
  if [ -f "$SQLDEV_ZIP_HOME/$SQLDEV_INSTALL_ZIP" ]; then    
    mkdir -p $SQLDEV_INSTALL_HOME
    echo Unzip $SQLDEV_ZIP_HOME/$SQLDEV_INSTALL_ZIP to $SQLDEV_HOME
    unzip $SQLDEV_ZIP_HOME/$SQLDEV_INSTALL_ZIP -d $SQLDEV_INSTALL_HOME
    echo Move $SQLDEV_INSTALL_HOME/$SQLDEV_INSTALL_FLDR/* $SQLDEV_HOME
    mkdir -p $SQLDEV_HOME
    mv $SQLDEV_INSTALL_HOME/$SQLDEV_INSTALL_FLDR/* $SQLDEV_HOME
    rm -rf $SQLDEV_INSTALL_HOME/$SQLDEV_INSTALL_FLDR
  else
    echo $SQLDEV_ZIP_HOME/$SQLDEV_INSTALL_ZIP does not exist
  fi
else
  echo sqldeveloper already unzipped
fi
