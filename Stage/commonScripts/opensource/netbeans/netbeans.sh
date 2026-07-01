#!/bin/bash
SCRIPTPATH=$(dirname $0)
JAVA_HOME=/app/oracle/product/jdk25
PATH=${JAVA_HOME}/bin:${PATH}
NBS_VERSION=30
OS_HOME=/app/opensource
NBS_HOME=$OS_HOME/netbeans-${NBS_VERSION}
echo Start Apache Netbeans ${NBS_VERSION}
$NBS_HOME/bin/netbeans --jdkhome ${JAVA_HOME} > $SCRIPTPATH/netbeans.out 2>&1 & 
