#!/bin/bash
SCRIPTPATH=$(dirname $0)
. $SCRIPTPATH/jdevsoa12c_env.sh
echo start Jdeveloper SOA Quickstart 12cR2 
$JDEV_HOME/jdeveloper/jdev/bin/jdev  > $SCRIPTPATH/jdevsoa12c.out 2>&1 & 
