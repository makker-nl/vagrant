#!/bin/bash
SCRIPTPATH=$(dirname $0)
echo Start SoapUI ${SOAPUI_VER}
nohup ssh redhat@localhost -p 2222 /home/redhat/bin/ssh_soapui.sh > $SCRIPTPATH/soapui.out 2>&1 &