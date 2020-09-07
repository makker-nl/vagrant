#!/bin/bash
SCRIPTPATH=$(dirname $0)
ECLIPSE_HOME=/app/opensource/Eclipse-2020-06/eclipse/
echo start Eclipse
$ECLIPSE_HOME/eclipse > eclipse.out 2>&1 & 
