#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
RHCRS_JAR_HOME=$STAGE_HOME/installBinaries/RedHat
RHCRS_INSTALL_JAR=codereadystudio-12.16.0.GA-installer-standalone.jar
RHCRS_HOME=$RH_BASE/codereadystudio
#
echo "Checking CodeReady Home: "$RHCRS_HOME
if [ ! -f "$RHCRS_HOME/codereadystudio" ]; then
 #
  # Install CodeReadyStudio
  echo Install CodeReadyStudio
  java -jar $RHCRS_JAR_HOME/$RHCRS_INSTALL_JAR $SCRIPTPATH/InstallConfigRecord.xml

else
  echo CodeReadyStudio already installed
fi