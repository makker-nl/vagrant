#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../install_env.sh
. $SCRIPTPATH/jdev11g_env.sh
#
FMW_VER=11.1.1.9
FMW_EXTRACT_HOME=$EXTRACT_HOME/FMW/$FMW_VER
#
JDEV_INSTALL_HOME=$INSTALL_HOME/FMW/$FMW_VER
JDEV_INSTALL_JAR=jdevstudio11119install.jar
JDEV_SILENT_XML=silent.xml
JDEV_SILENT_XML_TPL=$JDEV_SILENT_XML.tpl
# Set ORACLE_HOME
export ORACLE_HOME=$JDEV_HOME
#
echo SCRIPTPATH: $SCRIPTPATH
echo JDEV_ZIP_HOME: $JDEV_ZIP_HOME
echo JDEV_INSTALL_HOME: $JDEV_INSTALL_HOME
echo JDEV_HOME: $JDEV_HOME
#
# Install Jdeveloper
if [ ! -d "$JDEV_HOME" ]; then
  #
  if [ -f "$JDEV_INSTALL_HOME/$JDEV_INSTALL_JAR" ]; then  
    echo Substitute $SCRIPTPATH/$JDEV_SILENT_XML_TPL to $SCRIPTPATH/$JDEV_SILENT_XML
    envsubst < $SCRIPTPATH/$JDEV_SILENT_XML_TPL > $SCRIPTPATH/$JDEV_SILENT_XML
    echo Install JDeveloper 11g
    $JAVA_HOME/bin/java -jar $JDEV_INSTALL_HOME/$JDEV_INSTALL_JAR -mode=silent -silent_xml=$SCRIPTPATH/$JDEV_SILENT_XML
  else
    echo $JDEV_INSTALL_HOME/$JDEV_INSTALL_JAR not available!.
  fi
else
  echo JDeveloper 11gR1 already installed
fi
