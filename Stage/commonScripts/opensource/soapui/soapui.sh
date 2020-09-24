#!/bin/bash
SCRIPTPATH=$(dirname $0)
SOAPUI_VER=5.5.0
SOAPUI_HOME=/app/opensource/SoapUI-${SOAPUI_VER}
echo Start SoapUI ${SOAPUI_VER}
$SOAPUI_HOME/bin/soapui.sh > $SCRIPTPATH/SoapUI-${SOAPUI_VER}.out 2>&1 & 
