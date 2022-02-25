#!/bin/bash
export ORACLE_BASE=/app/oracle
export JDEV_HOME=$ORACLE_BASE/product/jdeveloper/12214_SOAQS
echo start Jdeveloper SOA Quickstart 12cR2 
nohup ssh redhat@localhost -p 2222 $JDEV_HOME/jdeveloper/jdev/bin/jdev > jdevsoa12c.out 2>&1 &
