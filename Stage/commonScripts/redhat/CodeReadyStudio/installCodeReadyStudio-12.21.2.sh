#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
export RHCRS_VERSION=12.21.2
$SCRIPTPATH/installCodeReadyStudio-gen.sh $RHCRS_VERSION