#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../startStop/fmw12c_env.sh
#
PROPS=$SCRIPTPATH/fmw_mft.properties
#
function prop {
    grep "${1}" $PROPS|cut -d'=' -f2
}
#
NODEMGR_HOME=$(prop 'nodeMgr1Home')
echo
echo Modify Nodemanager: $NODEMGR_HOME
wlst.sh $SCRIPTPATH/modifyNodeManager.py -loadProperties $PROPS
