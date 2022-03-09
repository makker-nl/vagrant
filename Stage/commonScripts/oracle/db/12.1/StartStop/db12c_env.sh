#!/bin/bash
echo set Database 12c environment
export ORACLE_BASE=/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/database/dbhome_1
export TNS_ADMIN=$ORACLE_HOME/network/admin
export SQLCL_HOME=$ORACLE_BASE/product/sqlcl
export SQLDEV_HOME=$ORACLE_BASE/product/sqldeveloper
export JAVA_HOME=$ORACLE_BASE/product/jdk
export DATABASE_HOME=/data/oracle/oradata
export ORACLE_SID=orcl
export PATH=/usr/sbin:$ORACLE_HOME/bin:$SQLCL_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib;
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib;
export TMP=/tmp
export TMPDIR=$TMP
