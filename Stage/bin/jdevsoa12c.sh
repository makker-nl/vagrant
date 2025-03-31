#!/bin/bash
SCRIPTPATH=$(dirname $0)
. $SCRIPTPATH/jdevsoa12c_env.sh
echo start Jdeveloper SOA Quickstart 12cR2 
# 20230221, M. van den Akker: use the options -clean -initialize when encountering the following error in the .out file:
# Caused by: java.lang.NumberFormatException: For input string: "2.0"
# See for also: https://support.oracle.com/epmos/faces/DocumentDisplay?id=2426158.1 on the same problem with ODI.
#
#$JDEV_HOME/jdeveloper/jdev/bin/jdev -clean -initialize > $SCRIPTPATH/jdevsoa12c.out 2>&1 & 
$JDEV_HOME/jdeveloper/jdev/bin/jdev > $SCRIPTPATH/jdevsoa12c.out 2>&1 & 
