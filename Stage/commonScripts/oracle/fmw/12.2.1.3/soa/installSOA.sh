#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../install_env.sh
. $SCRIPTPATH/../fmw12c_env.sh
#
FMW_ZIP_HOME=$INSTALL_BIN_HOME/FMW/$FMW_VER
FMW_EXTRACT_HOME=$EXTRACT_HOME/FMW/$FMW_VER
#
export SOA_ZIP_HOME=$FMW_ZIP_HOME/SOA
export SOA_INSTALL_HOME=$FMW_EXTRACT_HOME/SOA
export SOA_INSTALL_JAR=fmw_12.2.1.3.0_soa.jar
export SOA_INSTALL_RSP=fmw_12.2.1.3.0_soa.rsp
export SOA_INSTALL_RSP_TPL=$SOA_INSTALL_RSP.tpl
export SOA_INSTALL_ZIP=V886440-01.zip
#Set this variable value to the Installation Type selected. e.g. SOA Suite, BPM.
export SOABPM_INSTALL_TYPE=BPM
#
# SOA and BPM Suite 12c
if [[ -d "$FMW_HOME" && ! -d "$SOA_PROD_DIR" ]]; then
  #
  #Unzip SOA&BPM
  if [ ! -f "$SOA_INSTALL_HOME/$SOA_INSTALL_JAR" ]; then
    if [ -f "$SOA_ZIP_HOME/$SOA_INSTALL_ZIP" ]; then
      mkdir -p $SOA_INSTALL_HOME
      echo Unzip $SOA_ZIP_HOME/$SOA_INSTALL_ZIP to $SOA_INSTALL_HOME/$SOA_INSTALL_JAR
      unzip -o $SOA_ZIP_HOME/$SOA_INSTALL_ZIP -d $SOA_INSTALL_HOME
    else
      echo $SOA_ZIP_HOME/$SOA_INSTALL_ZIP does not exist!
    fi  
  else
    echo $SOA_INSTALL_JAR already unzipped
  fi
  if [ -f "$SOA_INSTALL_HOME/$SOA_INSTALL_JAR" ]; then
    echo Substitute $SOA_INSTALL_RSP_TPL to $SOA_INSTALL_RSP
    envsubst < $SCRIPTPATH/$SOA_INSTALL_RSP_TPL > $SCRIPTPATH/$SOA_INSTALL_RSP
    echo Install SOA and BPM Suite 12cR2 $FMW_VER
    $JAVA_HOME/bin/java -jar $SOA_INSTALL_HOME/$SOA_INSTALL_JAR -silent -responseFile $SCRIPTPATH//$SOA_INSTALL_RSP
  else
    echo $SOA_INSTALL_JAR not available!
  fi
else
  if [ ! -d "$FMW_HOME" ]; then
    echo $FMW_HOME not available: First install Fusion Middlware Infrastucture
  fi
  if [ -d "$SOA_PROD_DIR" ]; then
    echo $SOA_PROD_DIR available: Fusion Middleware 12c $FMW_VER SOA/BPM Suite already installed
  fi
fi