#!/bin/bash
echo set Fusion MiddleWare 12cR2 environment
export DOMAIN_NAME=fmw12c_domain
export ORACLE_BASE=/app/oracle
export INVENTORY_DIRECTORY=/app/oraInventory
export FMW_HOME=$ORACLE_BASE/product/middleware/FMW12213
export JAVA_HOME=$ORACLE_BASE/product/jdk
export SHARED_CONFIG_DIR=/app/oracle/config