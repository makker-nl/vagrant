#!/bin/bash
SCRIPTPATH=$(dirname $0)
ECLIPSE_HOME=/app/opensource/Eclipse-2022-06/eclipse/
echo start Eclipse
$ECLIPSE_HOME/eclipse > $SCRIPTPATH/eclipse.out 2>&1 & 
