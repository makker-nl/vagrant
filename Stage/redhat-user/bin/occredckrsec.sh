#!/bin/bash
CUSTOMER_PORTAL_USERNAME=$1
CUSTOMER_PORTAL_PASSWORD=$2
EMAIL_ADDRESS=$3
PULL_SECRET_NAME=dockersecret
echo Create secret $PULL_SECRET_NAME for the Red Hat Docker Registry 
oc create secret docker-registry ${PULL_SECRET_NAME} \
  --docker-server=registry.redhat.io \
  --docker-username=${CUSTOMER_PORTAL_USERNAME} \
  --docker-password=${CUSTOMER_PORTAL_PASSWORD} \
  --docker-email=${EMAIL_ADDRESS}
echo Create a secrets link for pulling images for pods to the default service account.
oc secrets link default $PULL_SECRET_NAME  --for=pull
echo Make secret mountable inside pods for pushing and pulling build images
oc secrets link builder $PULL_SECRET_NAME 
