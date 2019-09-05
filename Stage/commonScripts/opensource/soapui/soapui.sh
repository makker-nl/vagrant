#!/bin/bash
SCRIPTPATH=$(dirname $0)
SOAPUI_HOME=/app/opensource/SoapUI-5.5.0
echo start SoapUI
$SOAPUI_HOME/bin/soapui.sh > soapui.out 2>&1 & 
