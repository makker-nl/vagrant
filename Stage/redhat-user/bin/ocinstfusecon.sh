#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
function prop {
    grep "${1}" $SCRIPTPATH/minishift.properties|cut -d'=' -f2
}
#PROJECT=openshift
PROJECT=martien-van-den-akker-dev
JBFUSEURL=https://raw.githubusercontent.com/jboss-fuse/application-templates
BASEURL=$JBFUSEURL/application-templates-2.1.0.fuse-770012-redhat-00004
OS_DIR=~/bin/openshift
#
APP_NAME=fuse-console
FPROJECT=fuse
DOMAIN_NAME=$(prop 'minishift.ip').nip.io
#
OCCREFPRJ_OUT=occrefuseproj.out
OCTPL_OUT=octemplates.out
#
echo Login as admin
~/bin/ocloginadm.sh
#
echo Switch to  project $PROJECT
oc project $PROJECT
#
echo Get the service signing certificate authority secret
mkdir -p $OS_DIR
oc get secrets/service-serving-cert-signer-signing-key -n openshift-service-cert-signer -o "jsonpath={.data['tls\.crt']}" | base64 --decode > $OS_DIR/ca.crt
oc get secrets/service-serving-cert-signer-signing-key -n openshift-service-cert-signer -o "jsonpath={.data['tls\.key']}" | base64 --decode > $OS_DIR/ca.key
#
echo The next steps will be used to generate a client side certificate that will be used by the Fuse console
echo . Generate a private key
openssl genrsa -out $OS_DIR/server.key 2048
#
echo . Create a configuration for new certificate generation
echo . . Note: the CN name needs to match the service name of the Fuse console
cat <<EOT >> $OS_DIR/csr.conf
  [ req ]
  default_bits = 2048
  prompt = no
  default_md = sha256
  distinguished_name = dn

  [ dn ]
  CN = fuse-console.fuse.svc

  [ v3_ext ]
  authorityKeyIdentifier=keyid,issuer:always
  keyUsage=keyEncipherment,dataEncipherment,digitalSignature
  extendedKeyUsage=serverAuth,clientAuth
EOT
echo . Generate a new certificate and sign it
openssl req -new -key $OS_DIR/server.key -out $OS_DIR/server.csr -config $OS_DIR/csr.conf
openssl x509 -req -in $OS_DIR/server.csr -CA $OS_DIR/ca.crt -CAkey $OS_DIR/ca.key -CAcreateserial -out $OS_DIR/server.crt -days 10000 -extensions v3_ext -extfile $OS_DIR/csr.conf
#
echo Application name of the Fuse console: $APP_NAME
echo OpenShift namespace under which to deploy the Fuse console: $FPROJECT
echo Domain name of OpenShift \(minishift\) deployment: $DOMAIN_NAME
echo Set the cluster admin role and the cluster mode template
oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:openshift-infra:template-instance-controller
#
echo Check if the Fuse console image can be imported successfully
oc import-image fuse7/fuse-console:1.6 --from=registry.redhat.io/fuse7/fuse-console:1.6 --confirm
#
echo
echo Now log into OpenShift as developer
~/bin/oclogin.sh developer
#
echo Create Fuse Console project \'$FPROJECT\' into which the console will be deployed
oc new-project $FPROJECT 2>&1 | tee $SCRIPTPATH/$OCCREFPRJ_OUT
if grep -q "\(AlreadyExists\)" $SCRIPTPATH/$OCCREFPRJ_OUT; then
  echo
  echo Project $FPROJECT already exists, so just make sure it is the default.
  oc project $FPROJECT
fi
$
echo Create TLS secret using the generated certificates
oc create secret tls $APP_NAME-tls-proxying --cert $OS_DIR/server.crt --key $OS_DIR/server.key
$
echo Create the Fuse console on OpenShift
oc new-app -n $FPROJECT -f $BASEURL/fuse-console-namespace-os4.json -p ROUTE_HOSTNAME=$APP_NAME.$DOMAIN_NAME -p APP_NAME=$APP_NAME
echo Set the OpenShift version to 3 on the deployment config
oc set env deploymentconfig/$APP_NAME OPENSHIFT_CLUSTER_VERSION=3