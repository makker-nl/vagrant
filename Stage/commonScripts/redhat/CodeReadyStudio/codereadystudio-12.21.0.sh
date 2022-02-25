#!/bin/bash
SCRIPTPATH=$(dirname $0)
RHCRS_VERSION=12.21.0
RHCRS_HOME=/app/redhat/codereadystudio-${RHCRS_VERSION}
echo start RedHat CodeReadyStudio ${RHCRS_VERSION} from ${RHCRS_HOME}
$RHCRS_HOME/codereadystudio > $SCRIPTPATH/codereadystudio-${RHCRS_VERSION}.out 2>&1 & 
