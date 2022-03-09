#!/bin/bash
echo set Database 12c environment
export ORACLE_BASE=/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/database/dbhome_1
export SQLCL_HOME=$ORACLE_BASE/product/sqlcl
export SQLDEV_HOME=$ORACLE_BASE/product/sqldeveloper
export DATABASE_HOME=/data/oracle/oradata
export INVENTORY_DIRECTORY=/app/oraInventory
#
export DB_HOST=darlin-vce.darwin-it.local
export DB_PORT=1521
export ORACLE_SID=orcl
export DB_CONNECT_STR=$DB_HOST:$DB_PORT:${ORACLE_SID}
export PATH=/usr/sbin:$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib;
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib;
export TMP=/tmp
export TMPDIR=$TMP
