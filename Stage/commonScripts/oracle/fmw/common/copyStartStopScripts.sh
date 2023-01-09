#!/bin/bash
#######################
#
# Copy FMW 12c StartStop Scripts
# @author: 2023-01-09, Martien van den Akker, Oracle Nederland B.V.
#
#######################
SCRIPTPATH=$(dirname $0)
. $SCRIPTPATH/../../../install_env.sh
. $SCRIPTPATH/startStop/fmw12c_env.sh
echo Fusion Middleware 12cR2 Configuration - Copy Start Stop Scripts
cp -R $SCRIPTPATH/startStop/* $SCR_DIR