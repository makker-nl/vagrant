#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../../install_env.sh
. $SCRIPTPATH/../fmw12c_env.sh
#
export MFT_ZIP_HOME=$FMW_ZIP_HOME/MFT
export MFT_INSTALL_HOME=$FMW_EXTRACT_HOME/MFT
export MFT_INSTALL_JAR=fmw_12.2.1.4.0_mft.jar
export MFT_INSTALL_RSP=fmw_12.2.1.4.0_mft.rsp
export MFT_INSTALL_RSP_TPL=$MFT_INSTALL_RSP.tpl
export MFT_INSTALL_ZIP=V983388-01.zip
#
# Managed File Transfer 12c
if [[ -d "$FMW_HOME" && ! -d "$MFT_PROD_DIR" ]]; then
  #
  #Unzip SOA&BPM
  if [ ! -f "$MFT_INSTALL_HOME/$MFT_INSTALL_JAR" ]; then
    if [ -f "$MFT_ZIP_HOME/$MFT_INSTALL_ZIP" ]; then
      mkdir -p $MFT_INSTALL_HOME
      echo Unzip $MFT_ZIP_HOME/$MFT_INSTALL_ZIP to $MFT_INSTALL_HOME/$MFT_INSTALL_JAR
      unzip -o $MFT_ZIP_HOME/$MFT_INSTALL_ZIP -d $MFT_INSTALL_HOME
    else
      echo $MFT_ZIP_HOME/$MFT_INSTALL_ZIP does not exist!
    fi  
  else
    echo $MFT_INSTALL_JAR already unzipped
  fi
  if [ -f "$MFT_INSTALL_HOME/$MFT_INSTALL_JAR" ]; then
    echo Substitute $MFT_INSTALL_RSP_TPL to $MFT_INSTALL_RSP
    envsubst < $SCRIPTPATH/$MFT_INSTALL_RSP_TPL > $SCRIPTPATH/$MFT_INSTALL_RSP
    echo Install Managed File Transfer 12cR2 $FMW_VER
    $JAVA_HOME/bin/java -jar $MFT_INSTALL_HOME/$MFT_INSTALL_JAR -silent -responseFile $SCRIPTPATH//$MFT_INSTALL_RSP
  else
    echo $MFT_INSTALL_JAR not available!
  fi
else
  if [ ! -d "$FMW_HOME" ]; then
    echo $FMW_HOME not available: First install Fusion Middlware Infrastucture
  fi
  if [ -d "$MFT_PROD_DIR" ]; then
    echo $MFT_PROD_DIR available: Fusion Middleware 12c $FMW_VER Managed File Transfer already installed
  fi
fi