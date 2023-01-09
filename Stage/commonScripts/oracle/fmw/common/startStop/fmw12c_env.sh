#!/bin/bash
echo set Fusion MiddleWare 12cR2 environment
export ORACLE_BASE=/app/oracle
export FMW_HOME=$ORACLE_BASE/product/middleware/FMW12213
export WL_HOME=${FMW_HOME}/wlserver
export SHARED_CONFIG_DIR=/app/oracle/config
export DOMAIN_NAME=soa12c_domain
export DOMAIN_HOME=$SHARED_CONFIG_DIR/domains/$DOMAIN_NAME
export APPLICATIONS_HOME=$SHARED_CONFIG_DIR/applications/$DOMAIN_NAME
export NODEMGR_HOME=$DOMAIN_HOME/nodemanager
export SCR_DIR=$ORACLE_BASE/scripts
#
if [ -f "$WL_HOME/server/bin/setWLSEnv.sh" ]; then
  echo call setWLSEnv.sh
  . $WL_HOME/server/bin/setWLSEnv.sh
  export PATH=$FMW_HOME/oracle_common/common/bin:$WL_HOME/common/bin/:$WL_HOME/server/bin:$PATH
else
  echo Weblogic 12c Env not available.
fi