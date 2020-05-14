#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../install_env.sh
. $SCRIPTPATH/../fmw12c_env.sh
#
FMW_ZIP_HOME=$INSTALL_BIN_HOME/FMW/$FMW_VER
FMW_EXTRACT_HOME=$EXTRACT_HOME/FMW/$FMW_VER
#
export OSB_ZIP_HOME=$FMW_ZIP_HOME/OSB
export OSB_INSTALL_HOME=$FMW_EXTRACT_HOME/OSB
export OSB_INSTALL_JAR=fmw_12.2.1.3.0_osb.jar
export OSB_INSTALL_RSP=fmw_12.2.1.3.0_osb.rsp
export OSB_INSTALL_RSP_TPL=$OSB_INSTALL_RSP.tpl
export OSB_INSTALL_ZIP=V886445-01.zip
#
# ServiceBus 12c
if [[ -d "$FMW_HOME" && ! -d "$OSB_PROD_DIR/bin" ]]; then
  #
  #Unzip ServiceBus
  if [ ! -f "$OSB_INSTALL_HOME/$OSB_INSTALL_JAR" ]; then
    if [ -f "$OSB_ZIP_HOME/$OSB_INSTALL_ZIP" ]; then
      mkdir -p $OSB_INSTALL_HOME
      echo Unzip $OSB_ZIP_HOME/$OSB_INSTALL_ZIP to $OSB_INSTALL_HOME/$OSB_INSTALL_JAR
      unzip -o $OSB_ZIP_HOME/$OSB_INSTALL_ZIP -d $OSB_INSTALL_HOME
    else
      echo $OSB_INSTALL_HOME/$OSB_INSTALL_ZIP does not exist!
    fi  
  else
    echo $OSB_INSTALL_JAR already unzipped
  fi
  if [ -f "$OSB_INSTALL_HOME/$OSB_INSTALL_JAR" ]; then
    echo Substitute $OSB_INSTALL_RSP_TPL to $OSB_INSTALL_RSP
    envsubst < $SCRIPTPATH/$OSB_INSTALL_RSP_TPL > $SCRIPTPATH/$OSB_INSTALL_RSP
    echo Install ServiceBus 12cR2 $FMW_VER
    $JAVA_HOME/bin/java -jar $OSB_INSTALL_HOME/$OSB_INSTALL_JAR -silent -responseFile $SCRIPTPATH/$OSB_INSTALL_RSP
  else
    echo $OSB_INSTALL_JAR not available!
  fi
else
  if [ ! -d "$FMW_HOME" ]; then
    echo $FMW_HOME not available: First install Fusion Middlware Infrastucture
  fi
  if [ -d "$OSB_PROD_DIR/bin" ]; then
    echo $OSB_PROD_DIR/bin available: Fusion Middleware 12c $FMW_VER ServiceBus already installed
  fi
fi