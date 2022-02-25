#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
RHCRS_JAR_HOME=$STAGE_HOME/installBinaries/RedHat
export RHCRS_VERSION=12.19.1
export RHCRS_START_SCRIPT=codereadystudio-${RHCRS_VERSION}.sh
export RHCRS_START_LN=codereadystudio.sh
RHCRS_INSTALL_JAR=codereadystudio-${RHCRS_VERSION}.GA-installer-standalone.jar
export RHCRS_HOME=$RH_BASE/codereadystudio-${RHCRS_VERSION}
RHCRS_CFG=InstallConfigRecord.xml
RHCRS_CFG_TPL=$RHCRS_CFG.tpl

# Set Java Home to Oracle JDK 8
JAVA_HOME=/etc/alternatives/java_sdk
#
echo "Checking CodeReady Home: "$RHCRS_HOME
if [ ! -f "$RHCRS_HOME/codereadystudio" ]; then
  echo Substitute $SCRIPTPATH/$RHCRS_CFG_TPL to $SCRIPTPATH/$RHCRS_CFG
  envsubst < $SCRIPTPATH/$RHCRS_CFG_TPL > $SCRIPTPATH/$RHCRS_CFG
  #
  # Install CodeReadyStudio
  echo Install CodeReadyStudio ${RHCRS_VERSION}
  $JAVA_HOME/bin/java -jar $RHCRS_JAR_HOME/$RHCRS_INSTALL_JAR $SCRIPTPATH/$RHCRS_CFG
  echo Copy start script to user home
  mkdir -p ~/bin
  cp $SCRIPTPATH/$RHCRS_START_SCRIPT ~/bin
  echo Create or replace sym link $RHCRS_START_LN to $RHCRS_START_SCRIPT in ~/bin 
  rm ~/bin/$RHCRS_START_LN
  ln -s ~/bin/$RHCRS_START_SCRIPT ~/bin/$RHCRS_START_LN
else
  echo CodeReadyStudio ${RHCRS_VERSION} already installed
fi