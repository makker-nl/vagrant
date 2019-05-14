#!/bin/bash
SCRIPTPATH=$(dirname $0)
. $SCRIPTPATH/jdev11g_env.sh
echo start Jdeveloper SOA 11gR1
$JDEV_HOME/jdeveloper/jdev/bin/jdev
