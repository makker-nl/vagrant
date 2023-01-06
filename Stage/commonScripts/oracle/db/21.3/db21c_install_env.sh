#!/bin/bash
echo set Database 21c environment
export ORACLE_BASE=/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/database/dbhome_1
export SQLCL_HOME=$ORACLE_BASE/product/sqlcl
export SQLDEV_HOME=$ORACLE_BASE/product/sqldeveloper
export DATABASE_HOME=/data/oracle/oradata
export ORACLE_HOSTNAME=dbhost
export INVENTORY_DIRECTORY=/app/oracle/oraInventory
export DB_VER=21.3.0.0.0/x86_64
export DB_STAGE_HOME=$INSTALL_HOME/Oracle/DB/$DB_VER