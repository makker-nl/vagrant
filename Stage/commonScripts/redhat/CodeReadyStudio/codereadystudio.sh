#!/bin/bash
SCRIPTPATH=$(dirname $0)
RHCRS_HOME=/app/redhat/codereadystudio
echo start RedHat CodeReadyStudio
$RHCRS_HOME/codereadystudio > codereadystudio.out 2>&1 & 
