#!/bin/bash
#############################################################################
# Modify FMW Domain to match new cloned VM.
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 1.0, 2020-05-19
#
#############################################################################
#
SCRIPTPATH=$(dirname $0)
. $SCRIPTPATH/fmw12c_env.sh
echo
echo Modify Domain with wlst script.
wlst.sh $SCRIPTPATH/modifyDomain.py -loadProperties fmw.properties
