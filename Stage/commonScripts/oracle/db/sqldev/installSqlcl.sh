#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
export ORACLE_BASE=/app/oracle
export SQLCL_HOME=$ORACLE_BASE/product/sqlcl
export SQLDEV_HOME=$ORACLE_BASE/product/sqldeveloper
#
SQLCL_ZIP_HOME=$INSTALL_HOME/DB/SQLDeveloper/SQLCL
SQLCL_INSTALL_HOME=$EXTRACT_HOME/DB/SQLCL
#SQLCL_INSTALL_ZIP=sqlcl-18.2.0.zip
SQLCL_INSTALL_ZIP=sqlcl-21.4.1.17.1458.zip
#
echo SQLCL_HOME=$SQLCL_HOME
#
if [ ! -d "$SQLCL_HOME" ]; then
  #Unzip SQLCL_
  if [ -f "$SQLCL_ZIP_HOME/$SQLCL_INSTALL_ZIP" ]; then    
    mkdir -p $SQLCL_INSTALL_HOME
    echo Unzip $SQLCL_ZIP_HOME/$SQLCL_INSTALL_ZIP to $SQLCL_HOME
    unzip $SQLCL_ZIP_HOME/$SQLCL_INSTALL_ZIP -d $SQLCL_INSTALL_HOME
    echo Move $SQLCL_INSTALL_HOME/sqlcl/* $SQLCL_HOME
    mkdir -p $SQLCL_HOME
    mv $SQLCL_INSTALL_HOME/sqlcl/* $SQLCL_HOME
    rm -rf $SQLCL_INSTALL_HOME/sqlcl
  else
    echo $SQLCL_ZIP_HOME/$SQLCL_INSTALL_ZIP does not exist
  fi
else
  echo sqlcl already unzipped
fi
