#!/bin/bash
# The script is used to do easy logon to the OpenShift cluster using standard users where the standard user-passwords are in the minishift.properties file.
# Also the host is in there. 
#
SCRIPTPATH=$(dirname $0)

ENV=${1:-dev}

function prop {
    grep "${1}" $SCRIPTPATH/minishift.properties|cut -d'=' -f2
}
#
# Get User and Password
MSHFT_HOST=$(prop 'minishift.host')
MSHFT_USER=$1
MSHFT_PASSWORD=$(prop ${MSHFT_USER}'.password')
#
echo 
echo Logon to $MSHFT_HOST as MiniShift User $MSHFT_USER with $MSHFT_PASSWORD.
oc login $MSHFT_HOST -u $MSHFT_USER -p $MSHFT_PASSWORD
