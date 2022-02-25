#!/bin/bash
# The script is used to do easy logon to the OpenShift cluster using standard users where the standard user-passwords are in the minishift.properties file.
# Also the host is in there. 
#
SCRIPTPATH=$(dirname $0)

OC_ENV=${OC_ENV:-minishift}

function prop {
    grep "${1}" $SCRIPTPATH/${OC_ENV}.properties|cut -d'=' -f2
}
#
# Get User and Password
OSHFT_HOST=$(prop ${OC_ENV}'.host')
OSHFT_PASSWORD=$(prop ${OSHFT_USER}'.password')
OSHFT_TOKEN=$(prop ${OSHFT_USER}'.token')
OSHFT_USER=$(prop ${1}'.user')
# Check if user found in properties found. If not then use $1
if [ "$OSHFT_USER" = "" ] 
then
  OSHFT_USER=${1};
fi
#
if [ "$OSHFT_USER" = "minishift" ] 
then
  echo 
  echo Logon to $OSHFT_HOST as $OC_ENV-user $OSHFT_USER. #with $OSHFT_PASSWORD.
  oc login $OSHFT_HOST -u $OSHFT_USER -p $OSHFT_PASSWORD
else
  echo 
  echo Logon to $OSHFT_HOST as $OC_ENV-user $OSHFT_USER. #with $OSHFT_PASSWORD, token: $OSHFT_TOKEN
  oc login --token=$OSHFT_TOKEN --server=$OSHFT_HOST
fi