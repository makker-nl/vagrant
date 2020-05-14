#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../install_env.sh
. $SCRIPTPATH/../fmw12c_env.sh
#
FMW_ZIP_HOME=$INSTALL_BIN_HOME/FMW/$FMW_VER
FMW_EXTRACT_HOME=$EXTRACT_HOME/FMW/$FMW_VER
#
export OHS_ZIP_HOME=$FMW_ZIP_HOME/OHS
export OHS_INSTALL_HOME=$FMW_EXTRACT_HOME/OHS
export OHS_INSTALL_BIN=fmw_12.2.1.3.0_ohs_linux64.bin
export OHS_INSTALL_RSP=fmw_12.2.1.3.0_ohs.rsp
export OHS_INSTALL_RSP_TPL=$OHS_INSTALL_RSP.tpl
export OHS_INSTALL_ZIP=V886427-01.zip
#
# Oracle Webtier 12c
if [[ -d "$FMW_HOME" && ! -d "$OHS_PROD_DIR/bin" ]]; then
  #
  #Unzip hs
  if [ ! -f "$OHS_INSTALL_HOME/$OHS_INSTALL_BIN" ]; then
    if [ -f "$OHS_ZIP_HOME/$OHS_INSTALL_ZIP" ]; then
      if [ ! -d "$OHS_INSTALL_HOME" ]; then
        echo Create folder "$OHS_INSTALL_HOME"
        mkdir -p "$OHS_INSTALL_HOME"
      fi
      echo Unzip $OHS_ZIP_HOME/$OHS_INSTALL_ZIP to $OHS_INSTALL_HOME/$OHS_INSTALL_BIN
      unzip -o $OHS_ZIP_HOME/$OHS_INSTALL_ZIP -d $OHS_INSTALL_HOME
    else
      echo $OHS_INSTALL_HOME/$OHS_INSTALL_ZIP does not exist!
    fi  
  else
    echo $OHS_INSTALL_BIN already unzipped
  fi
  if [ -f "$OHS_INSTALL_HOME/$OHS_INSTALL_BIN" ]; then
    echo Substitute $OHS_INSTALL_RSP_TPL to $OHS_INSTALL_RSP
    envsubst < $SCRIPTPATH/$OHS_INSTALL_RSP_TPL > $SCRIPTPATH/$OHS_INSTALL_RSP
    echo Install Oracle HTTP Server $FMW_VER
    $OHS_INSTALL_HOME/$OHS_INSTALL_BIN -silent -responseFile $SCRIPTPATH/$OHS_INSTALL_RSP
  else
    echo $OHS_INSTALL_BIN not available!
  fi
else
  if [ ! -d "$FMW_HOME" ]; then
    echo $FMW_HOME not available: First install Fusion Middleware Infrastucture
  fi
  if [ -d "$OHS_PROD_DIR/bin" ]; then
    echo $OHS_PROD_DIR/bin available: Fusion Middleware 12c $FMW_VER Oracle HTTP Server already installed
  fi
fi