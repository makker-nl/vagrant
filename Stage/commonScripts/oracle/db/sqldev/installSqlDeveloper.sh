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
#SQLDEV_INSTALL_ZIP=sqldeveloper-21.4.3.063.0100-no-jre.zip
#SQLDEV_INSTALL_ZIP=sqldeveloper-22.2.1.234.1810-no-jre.zip
SQLDEV_BASE_NAME=sqldeveloper-*
SQLDEV_INSTALL_ZIP=$(find $SQLDEV_ZIP_HOME -type f -name $SQLDEV_BASE_NAME | awk -F"/" '{print $NF}' | sort -r | head -1)
#SQLDEV_INSTALL_FLDR=sqldeveloper
#
echo SQLDEV_HOME=$SQLDEV_HOME
#
if [ ! -d "$SQLDEV_HOME" ]; then
  if [[ -z "$SQLDEV_INSTALL_ZIP" ]]; then
    echo There is no $SQLDEV_BASE_NAME*.zip file in $SQLDEV_ZIP_HOME.
  else 
    mkdir -p $SQLDEV_INSTALL_HOME
    echo Unzip $SQLDEV_ZIP_HOME/$SQLDEV_INSTALL_ZIP to $SQLDEV_INSTALL_HOME
    unzip $SQLDEV_ZIP_HOME/$SQLDEV_INSTALL_ZIP -d $SQLDEV_INSTALL_HOME
    SQLDEV_INSTALL_NAME=$(find $SQLDEV_INSTALL_HOME/* -maxdepth 0 -type d  | awk -F"/" '{print $NF}' | sort -r | head -1)
    echo Move $SQLDEV_INSTALL_HOME/$SQLDEV_INSTALL_NAME/* $SQLDEV_HOME
    mkdir -p $SQLDEV_HOME
    mv $SQLDEV_INSTALL_HOME/$SQLDEV_INSTALL_NAME/* $SQLDEV_HOME
    rm -rf $SQLDEV_INSTALL_HOME/$SQLDEV_INSTALL_NAME
  fi
else
  echo sqldeveloper already unzipped
fi
