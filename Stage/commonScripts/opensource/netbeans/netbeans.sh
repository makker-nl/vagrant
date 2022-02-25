#!/bin/bash
SCRIPTPATH=$(dirname $0)
NBS_HOME=/app/opensource/netbeans/bin/
echo start Apache Netbeans 11
$NBS_HOME/netbeans > $SCRIPTPATH/netbeans.out 2>&1 & 
