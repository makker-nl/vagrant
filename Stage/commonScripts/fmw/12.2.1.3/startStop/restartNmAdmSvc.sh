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