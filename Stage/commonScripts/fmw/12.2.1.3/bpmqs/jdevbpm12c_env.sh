#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
echo set Jdeveloper BPM Quickstart 12cR2 environment
export ORACLE_BASE=/app/oracle
export JAVA_HOME=$ORACLE_BASE/product/jdk8
export JDEV_HOME=$ORACLE_BASE/product/jdeveloper/12213_BPMQS
export JDEV_USER_HOME_SOA=/home/oracle/JDeveloper/SOA
export JDEV_USER_DIR_SOA=/home/oracle/JDeveloper/SOA