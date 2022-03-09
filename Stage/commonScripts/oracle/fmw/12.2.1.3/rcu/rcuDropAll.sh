#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../install_env.sh
. $SCRIPTPATH/fmw12c_env.sh
. $SCRIPTPATH/../database/db12c_env.sh
#
echo Run rcu for FMW Infrastucture
export RCU_DROP_ALL_RSP=rcuDropAll.rsp
export RCU_DROP_ALL_RSP_TPL=$RCU_DROP_ALL_RSP.tpl
export RCU_ALL_PWD=rcuAllPasswords.txt
#
export DB_SCHEMA_PREFIX=DEV
#
echo Substitute $RCU_DROP_ALL_RSP_TPL to $RCU_DROP_ALL_RSP
envsubst < $RCU_DROP_ALL_RSP_TPL > $RCU_DROP_ALL_RSP
#export RCU_ALL_PWD=rcuSOAPasswords-same.txt
$FMW_HOME/oracle_common/bin/rcu -silent -responseFile $RCU_DROP_ALL_RSP -f < $RCU_ALL_PWD
