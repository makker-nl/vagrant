#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/fmw12c_env.sh
echo
echo Modify Nodemanager: $NODEMGR_HOME
wlst.sh $SCRIPTPATH/modifyNodeManager.py -loadProperties $SCRIPTPATH/fmw.properties
