#!/bin/bash
SCRIPTPATH=$(dirname $0)
RHCRS_HOME=/app/redhat/codereadystudio-12.18
echo start RedHat CodeReadyStudio
$RHCRS_HOME/codereadystudio > $SCRIPTPATH/codereadystudio.out 2>&1 & 
