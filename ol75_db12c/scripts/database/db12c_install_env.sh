#!/bin/bash
echo set Database 12c environment
export ORACLE_BASE=/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/database/dbhome_1
export SQLCL_HOME=$ORACLE_BASE/product/sqlcl
export SQLDEV_HOME=$ORACLE_BASE/product/sqldeveloper
export DATABASE_HOME=/data/oracle/oradata
export ORACLE_HOSTNAME=dbhost
export INVENTORY_DIRECTORY=/app/oraInventory
