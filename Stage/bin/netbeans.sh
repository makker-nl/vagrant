#!/bin/bash
SCRIPTPATH=$(dirname $0)
NBS_VERSION=23
OS_HOME=/app/opensource
NBS_HOME=$OS_HOME/netbeans-${NBS_VERSION}
echo start Apache Netbeans ${NBS_VERSION}
$NBS_HOME/bin/netbeans --jdkhome /app/oracle/product/jdk17 > $SCRIPTPATH/netbeans.out 2>&1 & 
