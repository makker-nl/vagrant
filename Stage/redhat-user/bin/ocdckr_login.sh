#!/bin/bash
# The script is used to do easy docker login to the OpenShift image registry on the OpenShift cluster currently logged on.
#
SCRIPTPATH=$(dirname $0)
#
HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
docker login -u $(oc whoami) -p $(oc whoami -t) $HOST
