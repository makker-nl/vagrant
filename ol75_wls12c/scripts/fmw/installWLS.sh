#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../install_env.sh
. $SCRIPTPATH/fmw12c_env.sh
#
FMW_EXTRACT_HOME=$EXTRACT_HOME/FMW/$FMW_VER
#
export WLS_ZIP_HOME=$FMW_STAGE_HOME/WLS
export WLS_INSTALL_HOME=$FMW_EXTRACT_HOME/WLS
export WLS_INSTALL_JAR=fmw_12.2.1.3.0_wls.jar
export WLS_INSTALL_RSP=fmw_12.2.1.3.0_wls.rsp
export WLS_INSTALL_RSP_TPL=$WLS_INSTALL_RSP.tpl
export WLS_INSTALL_ZIP=V886423-01.zip
#
# weblogicServer
if [ ! -d "$FMW_HOME" ]; then
  #Unzip WLS
  if [ ! -f "$WLS_INSTALL_HOME/$WLS_INSTALL_JAR" ]; then
    if [ -f "$WLS_ZIP_HOME/$WLS_INSTALL_ZIP" ]; then
      mkdir -p $WLS_INSTALL_HOME
      echo Unzip $WLS_ZIP_HOME/$WLS_INSTALL_ZIP to $WLS_INSTALL_HOME/$WLS_INSTALL_JAR
      unzip $WLS_ZIP_HOME/$WLS_INSTALL_ZIP -d $WLS_INSTALL_HOME
    else
      echo $WLS_ZIP_HOME/$WLS_INSTALL_ZIP does not exist
    fi  
  else
    echo $WLS_INSTALL_JAR already unzipped.
  fi
  if [ -f "$WLS_INSTALL_HOME/$WLS_INSTALL_JAR" ]; then
    echo Substitute $SCRIPTPATH/$WLS_INSTALL_RSP_TPL to $SCRIPTPATH/$WLS_INSTALL_RSP
    envsubst < $SCRIPTPATH/$WLS_INSTALL_RSP_TPL > $SCRIPTPATH/$WLS_INSTALL_RSP
    echo Install Fusion Middleware Infrastucture 12cR2
    $JAVA_HOME/bin/java -jar $WLS_INSTALL_HOME/$WLS_INSTALL_JAR  -silent -responseFile $SCRIPTPATH/$WLS_INSTALL_RSP
  else    
	echo $WLS_INSTALL_JAR not available!
  fi  
else
  echo $FMW_HOME available: Fusion Middleware 12c Infrastucture already installed.
fi