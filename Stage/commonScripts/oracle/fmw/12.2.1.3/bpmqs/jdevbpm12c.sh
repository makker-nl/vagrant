#!/bin/bash
SCRIPTPATH=$(dirname $0)
. $SCRIPTPATH/jdevbpm12c_env.sh
echo start Jdeveloper BPM Quickstart 12cR2 
$JDEV_HOME/jdeveloper/jdev/bin/jdev  > $SCRIPTPATH/jdevbpm12c.out 2>&1 & 
