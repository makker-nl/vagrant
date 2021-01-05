#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
RHCRS_JAR_HOME=$STAGE_HOME/installBinaries/RedHat
RHCRS_PREV_VERSION=12.16
RHCRS_INSTALL_JAR=codereadystudio-12.17.0.GA-installer-standalone.jar
RHCRS_HOME=$RH_BASE/codereadystudio
RHCRS_PREV_VER_HOME=$RH_BASE/codereadystudio-$RHCRS_PREV_VERSION
# Set Java Home to Oracle JDK 8
JAVA_HOME=/etc/alternatives/java_sdk
#
echo "Checking CodeReady Home: "$RHCRS_HOME
if [ -f "$RHCRS_HOME/codereadystudio" ]; then
  echo Move already installed CodeReadyStudio to $RHCRS_PREV_VER_HOME
  mv $RHCRS_HOME $RHCRS_PREV_VER_HOME
else
  echo CodeReadyStudio not  installed yet.
fi
if [ ! -f "$RHCRS_HOME/codereadystudio" ]; then
 #
  # Install CodeReadyStudio
  echo Install CodeReadyStudio
  $JAVA_HOME/bin/java -jar $RHCRS_JAR_HOME/$RHCRS_INSTALL_JAR $SCRIPTPATH/InstallConfigRecord.xml
  echo Copy start script to user home
  mkdir -p ~/bin
  cp $SCRIPTPATH/codereadystudio.sh ~/bin
else
  echo CodeReadyStudio already installed
fi