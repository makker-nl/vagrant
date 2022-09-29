#!/bin/bash
SCRIPTPATH=$(dirname $0)
HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
USER=$(oc whoami)
echo Docker login to OpenShift with user $USER on $HOST
docker login -u $USER -p $(oc whoami -t) $HOST
