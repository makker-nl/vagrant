#!/bin/bash
SCRIPTPATH=$(dirname $0)
. $SCRIPTPATH/db18c_env.sh
echo start SQLDeveloper
$SQLDEV_HOME/sqldeveloper.sh
