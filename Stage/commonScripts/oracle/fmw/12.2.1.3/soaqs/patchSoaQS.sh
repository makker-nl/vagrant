#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../install_env.sh
. $SCRIPTPATH/jdevsoa12c_env.sh
#
FMW_EXTRACT_HOME=$EXTRACT_HOME/FMW/$FMW_VER
#
SOA_ZIP_HOME=$FMW_STAGE_HOME/SOA
### Need to check the name of the zip file.
SOA_BP_ZIP=p28300397_122130_Generic.zip
SOA_BP_NAME=28300397
# Set ORACLE_HOME
export ORACLE_HOME=$JDEV_HOME
#OPatch folder
PATCH_NAME=$SOA_BP_NAME
OPATCH_HOME=$ORACLE_HOME/OPatch
PATCHES_HOME=$OPATCH_HOME/patches
PATCH_HOME=$PATCHES_HOME/$PATCH_NAME
#
# Install SOA QS
if [ -d "$JDEV_HOME" ]; then
  #
  #Unzip Patch
  if [ -f "$SOA_ZIP_HOME/$SOA_BP_ZIP" ]; then
	  mkdir -p $PATCHES_HOME
    echo Unzip $SOA_ZIP_HOME/$SOA_BP_ZIP to $PATCHES_HOME
    unzip -o $SOA_ZIP_HOME/$SOA_BP_ZIP -d $PATCHES_HOME
    echo .. Apply patch $PATCH_NAME
	  cd $PATCH_HOME
    $OPATCH_HOME/opatch apply -silent
    echo .. Check apply of $PATCH_NAME
    $OPATCH_HOME/opatch lsinventory|grep $PATCH_NAME
    cd $SCRIPTPATH
  else
    echo $SOA_ZIP_HOME/$SOA_BP_ZIP not available!.
  fi
else
  echo JDeveloper SOA QuickStart 12cR2 not installed yet!!!
fi
