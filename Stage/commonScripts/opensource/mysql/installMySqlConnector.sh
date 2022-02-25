#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
MSC_TAR=$STAGE_HOME/installBinaries/OpenSource/MySql/mysql-connector-java-8.0.23.tar.gz
MYSQL_HOME=/app/opensource/mysql
CD=$(pwd)
echo Install MySQL Connector
if [ ! -f "${MSC_BIN}" ]; then
  echo . Untar $MSC_TAR 
  tar xzf $MSC_TAR -C $MYSQL_HOME
else 
  echo . MySQL Connector already installed!
fi
