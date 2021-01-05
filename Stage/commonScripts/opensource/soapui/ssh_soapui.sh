#!/bin/bash
SCRIPTPATH=$(dirname $0)
export JAVA_HOME=/app/oracle/product/jdk8
export PATH=$JAVA_HOME/bin:$PATH
SOAPUI_VER=5.5.0
SOAPUI_HOME=/app/opensource/SoapUI-${SOAPUI_VER}
echo Start SoapUI ${SOAPUI_VER}
$SOAPUI_HOME/bin/soapui.sh &
