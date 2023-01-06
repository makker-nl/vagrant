#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../../install_env.sh
. $SCRIPTPATH/../fmw12c_env.sh
. ~/bin/db21c_env.sh
#
echo Run rcu for SOA Infrastucture
export FMW_EXTRACT_HOME=$EXTRACT_HOME/FMW/$FMW_VER
export RCU_INSTALL_HOME=$FMW_EXTRACT_HOME/RCU
export RCU_MFT_RSP=rcuMFT.rsp
export RCU_MFT_RSP_TPL=$RCU_MFT_RSP.tpl
export RCU_MFT_PWD=rcuMFTPasswords.txt
#export RCU_MFT_PWD=rcuMFTPasswords-same.txt
#
export DB_SCHEMA_PREFIX=DEV
# DB_PROFILE: SMALL/MED/LARGE
export DB_PROFILE=SMALL
#
echo Substitute $RCU_MFT_RSP_TPL to $RCU_MFT_RSP
envsubst < $SCRIPTPATH/$RCU_MFT_RSP_TPL > $SCRIPTPATH/$RCU_MFT_RSP
$FMW_HOME/oracle_common/bin/rcu -silent -responseFile $SCRIPTPATH/$RCU_MFT_RSP -f < $SCRIPTPATH/$RCU_MFT_PWD
