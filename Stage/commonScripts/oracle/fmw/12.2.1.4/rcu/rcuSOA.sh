#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../install_env.sh
. $SCRIPTPATH/../fmw12c_env.sh
. $SCRIPTPATH/../../../db/12.1/db12c_env.sh
#
echo Run rcu for SOA Infrastucture
export FMW_EXTRACT_HOME=$EXTRACT_HOME/FMW/$FMW_VER
export RCU_INSTALL_HOME=$FMW_EXTRACT_HOME/RCU
export RCU_SOA_RSP=rcuSOA.rsp
export RCU_SOA_RSP_TPL=$RCU_SOA_RSP.tpl
export RCU_SOA_PWD=rcuSOAPasswords.txt
#export RCU_SOA_PWD=rcuSOAPasswords-same.txt
#
export DB_SCHEMA_PREFIX=DEV
# DB_PROFILE: SMALL/MED/LARGE
export DB_PROFILE=SMALL
#
echo Substitute $RCU_SOA_RSP_TPL to $RCU_SOA_RSP
envsubst < $SCRIPTPATH/$RCU_SOA_RSP_TPL > $SCRIPTPATH/$RCU_SOA_RSP
$FMW_HOME/oracle_common/bin/rcu -silent -responseFile $SCRIPTPATH/$RCU_SOA_RSP -f < $SCRIPTPATH/$RCU_SOA_PWD
