#!/bin/bash
#############################################################################
# Restart nodemanager admin service
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 2.1, 2016-06-27
#
#############################################################################
#
SCRIPTPATH=$(dirname $0)
. $SCRIPTPATH/fmw12c_env.sh
echo
echo Restart Nodemanager Admin Service
sudo service nodemanager_admin restart
echo
echo Check if nodemanager is started...
PS_ID=`ps -ef|grep weblogic.NodeManager |grep -v grep |awk 'END{print NR}'`

if [ $PS_ID -gt 0 ]
then echo "Nodemanager is RUNNING."
else echo "Nodemanager is NOT RUNNING yet. Please retry"
fi
