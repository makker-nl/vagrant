#!/bin/bash
SCRIPTPATH=$(dirname $0)
. $SCRIPTPATH/db12c_env.sh
echo start SQLDeveloper
$SQLDEV_HOME/sqldeveloper.sh
