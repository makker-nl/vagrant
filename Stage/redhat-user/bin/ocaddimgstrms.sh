#!/bin/bash
SCRIPTPATH=$(dirname $0)
#PROJECT=openshift
PROJECT=martien-van-den-akker-dev
JBFUSEURL=https://raw.githubusercontent.com/jboss-fuse/application-templates
BASEURL=$JBFUSEURL/application-templates-2.1.0.fuse-770012-redhat-00004
SBBASEURL=$JBFUSEURL/application-templates-2.1.0.fuse-sb2-770017-redhat-00001
FIS_OUT=occreatefis.out
FUSE77_PROJECT=s2i-fuse77-spring-boot-camel
FUSE77_SB2_PROJECT=s2i-fuse77-spring-boot-2-camel
#
OCTPL_OUT=octemplates.out
#
echo Login as admin
~/bin/ocloginadm.sh
#
echo Switch to  project $PROJECT
oc project $PROJECT
#
echo Install Fuse on OpenShift image streams
echo \(Ignore Already Exist errors, if they occur, the image streams will be replaced.\)
oc create -n $PROJECT -f ${BASEURL}/fis-image-streams.json 2>&1 | tee $SCRIPTPATH/$FIS_OUT
# If you get errors like:
# Error from server (AlreadyExists): imagestreams.image.openshift.io "fis-java-openshift" already exists
# ...
# Then force-fully replace:
if grep -q "\(AlreadyExists\)" $SCRIPTPATH/$FIS_OUT; then
  echo
  echo Streams already exist, so replace.
  oc replace --force -n $PROJECT -f ${BASEURL}/fis-image-streams.json
fi
#
echo
echo Output installed templates to $SCRIPTPATH/$OCTPL_OUT
oc get template -n $PROJECT 2>&1 > $SCRIPTPATH/$OCTPL_OUT
echo Install Fuse 77 QuickStart templates, if not exist already
if ! grep -q "$FUSE77_PROJECT" $SCRIPTPATH/$OCTPL_OUT; then
  echo Install Fuse 77 QuickStart templates
  for template in eap-camel-amq-template.json \
    eap-camel-cdi-template.json \
    eap-camel-cxf-jaxrs-template.json \
    eap-camel-cxf-jaxws-template.json \
    eap-camel-jpa-template.json \
    karaf-camel-amq-template.json \
    karaf-camel-log-template.json \
    karaf-camel-rest-sql-template.json \
    karaf-cxf-rest-template.json \
    spring-boot-camel-amq-template.json \
    spring-boot-camel-config-template.json \
    spring-boot-camel-drools-template.json \
    spring-boot-camel-infinispan-template.json \
    spring-boot-camel-rest-sql-template.json \
    spring-boot-camel-rest-3scale-template.json \
    spring-boot-camel-template.json \
    spring-boot-camel-xa-template.json \
    spring-boot-camel-xml-template.json \
    spring-boot-cxf-jaxrs-template.json \
    spring-boot-cxf-jaxws-template.json ;
    do
      oc create -n $PROJECT -f \
      $BASEURL/quickstarts/${template}
    done
else
  echo Fuse 77 QuickStart templates apparently already exist.
fi
#
echo
echo Install Fuse 77 SpringBoot 2 QuickStart templates, if not exist already
if ! grep -q "$FUSE77_SB2_PROJECT" $SCRIPTPATH/$OCTPL_OUT; then
  echo Install Fuse SpringBoot 2 QuickStart templates
  for template in spring-boot-2-camel-amq-template.json \
    spring-boot-2-camel-config-template.json \
    spring-boot-2-camel-drools-template.json \
    spring-boot-2-camel-infinispan-template.json \
    spring-boot-2-camel-rest-3scale-template.json \
    spring-boot-2-camel-rest-sql-template.json \
    spring-boot-2-camel-template.json \
    spring-boot-2-camel-xa-template.json \
    spring-boot-2-camel-xml-template.json \
    spring-boot-2-cxf-jaxrs-template.json \
    spring-boot-2-cxf-jaxws-template.json \
    spring-boot-2-cxf-jaxrs-xml-template.json \
    spring-boot-2-cxf-jaxws-xml-template.json ;
    do oc create -n  $PROJECT -f \
      $SBBASEURL/quickstarts/${template}
    done
else
  echo Fuse 77 SpringBoot 2 QuickStart templates apparently already exist.
fi
#
echo
echo Install apicurito, if not exist already
if ! grep -q "apicurito" $SCRIPTPATH/$OCTPL_OUT; then
  echo Install Apicurito
  oc create -n  $PROJECT -f $BASEURL/fuse-apicurito.yml
else
  echo Apicurito apparently already exists.
fi
echo
echo Installed Templates in project $PROJECT:
oc get template -n $PROJECT 