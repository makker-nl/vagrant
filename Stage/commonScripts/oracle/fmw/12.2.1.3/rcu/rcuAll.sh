#!/bin/bash
. $PWD/fmw12c_env.sh
. $PWD/db12c_env.sh
#
echo Run rcu for FMW Infrastucture
export RCU_ALL_RSP=rcuAll.rsp
export RCU_ALL_RSP_TPL=$RCU_ALL_RSP.tpl
export RCU_ALL_PWD=rcuAllPasswords.txt
#
export DB_SCHEMA_PREFIX=DEV
# DB_PROFILE: SMALL/MED/LARGE
export DB_PROFILE=SMALL
#
echo Substitute $RCU_ALL_RSP_TPL to $RCU_ALL_RSP
envsubst < $RCU_ALL_RSP_TPL > $RCU_ALL_RSP
#export RCU_ALL_PWD=rcuSOAPasswords-same.txt
$FMW_HOME/oracle_common/bin/rcu -silent -responseFile $RCU_ALL_RSP -f < $RCU_ALL_PWD
