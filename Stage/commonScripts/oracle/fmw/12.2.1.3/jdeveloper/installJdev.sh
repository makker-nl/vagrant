#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../install_env.sh
. $SCRIPTPATH/jdev12c_env.sh
#
FMW_VER=12.2.1.3
FMW_STAGE_HOME=$INSTALL_HOME/FMW/$FMW_VER
FMW_EXTRACT_HOME=$EXTRACT_HOME/FMW/$FMW_VER
#
JDEV_ZIP_HOME=$FMW_STAGE_HOME/JDev
JDEV_INSTALL_HOME=$FMW_EXTRACT_HOME/JDev
JDEV_INSTALL_JAR=jdev_suite_122130.jar
JDEV_INSTALL_RSP=jdev_suite_122130.rsp
JDEV_INSTALL_RSP_TPL=$JDEV_INSTALL_RSP.tpl
### Need to check the name of the zip file.
JDEV_INSTALL_ZIP1=V886439-01_1of2.zip
JDEV_INSTALL_ZIP2=V886439-01_2of2.zip
# Set ORACLE_HOME
export ORACLE_HOME=$JDEV_HOME
#
echo SCRIPTPATH: $SCRIPTPATH
echo JDEV_ZIP_HOME: $JDEV_ZIP_HOME
echo JDEV_INSTALL_HOME: $JDEV_INSTALL_HOME
echo JDEV_HOME: $JDEV_HOME
#
# Install BPM QS
if [ ! -d "$JDEV_HOME" ]; then
  #
  #Unzip JDeveloper
  if [ ! -f "$JDEV_INSTALL_HOME/$JDEV_INSTALL_JAR" ]; then
    if [[ -f "$JDEV_ZIP_HOME/$JDEV_INSTALL_ZIP1" && -f "$JDEV_ZIP_HOME/$JDEV_INSTALL_ZIP2" ]]; then
	  mkdir -p $JDEV_INSTALL_HOME
      echo Unzip $JDEV_ZIP_HOME/$JDEV_INSTALL_ZIP1 to $JDEV_INSTALL_HOME
      unzip -o $JDEV_ZIP_HOME/$JDEV_INSTALL_ZIP1 -d $JDEV_INSTALL_HOME
	  echo Unzip $JDEV_ZIP_HOME/$JDEV_INSTALL_ZIP2 to $JDEV_INSTALL_HOME
      unzip -o $JDEV_ZIP_HOME/$JDEV_INSTALL_ZIP2 -d $JDEV_INSTALL_HOME
    else
      echo $JDEV_ZIP_HOME/$JDEV_INSTALL_ZIP1 or $JDEV_ZIP_HOME/$JDEV_INSTALL_ZIP2 does not exist!
    fi  
  else
    echo $JDEV_INSTALL_JAR already unzipped
  fi
  if [ -f "$JDEV_INSTALL_HOME/$JDEV_INSTALL_JAR" ]; then
    echo Substitute $SCRIPTPATH/$JDEV_INSTALL_RSP_TPL to $SCRIPTPATH/$JDEV_INSTALL_RSP
    envsubst < $SCRIPTPATH/$JDEV_INSTALL_RSP_TPL > $SCRIPTPATH/$JDEV_INSTALL_RSP
    echo Install JDeveloper  12cR2
    $JAVA_HOME/bin/java -jar $JDEV_INSTALL_HOME/$JDEV_INSTALL_JAR -silent -responseFile $SCRIPTPATH/$JDEV_INSTALL_RSP  -invPtrLoc /etc/oraInst.loc
    echo copy $SCRIPTPATH/jdev.boot naar $JDEV_HOME/jdeveloper/jdev/bin
    mv $JDEV_HOME/jdeveloper/jdev/bin/jdev.boot $JDEV_HOME/jdeveloper/jdev/bin/jdev.boot.org
    cp $SCRIPTPATH/jdev.boot $JDEV_HOME/jdeveloper/jdev/bin/jdev.boot
    echo copy JDeveloper 12cR2 environment and start scripts to ~/bin
    mkdir -p ~/bin/
    cp $SCRIPTPATH/jdev12c_env.sh ~/bin/ 
    cp $SCRIPTPATH/jdev12c.sh ~/bin/
  else
    echo $JDEV_INSTALL_JAR not available!.
  fi
else
  if [ -d "$JDEV_HOME" ]; then
    echo JDeveloper 12cR2 already installed
  fi
fi
