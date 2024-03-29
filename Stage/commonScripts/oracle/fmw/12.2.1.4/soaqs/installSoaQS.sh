#!/bin/bash
SCRIPTPATH=$(dirname $0)
SCR_USER=`whoami`
#
. $SCRIPTPATH/../../../../install_env.sh
. $SCRIPTPATH/../fmw12c_env.sh
. $SCRIPTPATH/jdevsoa12c_env.sh
#
FMW_ZIP_HOME=$INSTALL_BIN_HOME/Oracle/FMW/$FMW_VER
FMW_EXTRACT_HOME=$EXTRACT_HOME/Oracle/FMW/$FMW_VER
FMW_SUB_VER=$FMW_VER.0
#
JDEV_ZIP_HOME=$FMW_ZIP_HOME/SOA_QS
JDEV_INSTALL_HOME=$FMW_EXTRACT_HOME/SOA_QS
JDEV_INSTALL_JAR=fmw_${FMW_SUB_VER}_soa_quickstart.jar
JDEV_INSTALL_RSP=fmw_${FMW_SUB_VER}_soa_quickstart.rsp
JDEV_INSTALL_RSP_TPL=$JDEV_INSTALL_RSP.tpl
### Need to check the name of the zip file.
JDEV_INSTALL_ZIP1=V983385-01_1of2.zip
JDEV_INSTALL_ZIP2=V983385-01_2of2.zip
#
JDEV_USR_HOME=~/.jdeveloper/$FMW_SUB_VER
JDEV_PROD_CONF=product.conf
JDEV_PROD_CONF_TPL=$JDEV_PROD_CONF.tpl
# Set ORACLE_HOME
export ORACLE_HOME=$JDEV_HOME
#
echo SCRIPTPATH: $SCRIPTPATH
echo JDEV_ZIP_HOME: $JDEV_ZIP_HOME
echo JDEV_INSTALL_HOME: $JDEV_INSTALL_HOME
echo JDEV_HOME: $JDEV_HOME
#
# Install SOA QS
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
    echo Install JDeveloper SOA QuickStart 12cR2
    if [ ! -f "/etc/oraInst.loc" ]; then
      echo Create group oinstall, if not existing already.
      sudo /usr/sbin/groupadd -g 2100 oinstall
      sudo usermod redhat -G oinstall
      echo Create oraInst.loc and grant to $SCR_USER:oinstall
      sudo sh -c "echo \"inventory_loc=/app/oracle/oraInventory\" > /etc/oraInst.loc"
      sudo sh -c "echo \"inst_group=oinstall\" >> /etc/oraInst.loc"
      sudo chown $SCR_USER:oinstall /etc/oraInst.loc
    fi
    $JAVA_HOME/bin/java -jar $JDEV_INSTALL_HOME/$JDEV_INSTALL_JAR -silent -responseFile $SCRIPTPATH/$JDEV_INSTALL_RSP  -invPtrLoc /etc/oraInst.loc
    echo copy $SCRIPTPATH/jdev.boot to $JDEV_HOME/jdeveloper/jdev/bin
    mv $JDEV_HOME/jdeveloper/jdev/bin/jdev.boot $JDEV_HOME/jdeveloper/jdev/bin/jdev.boot.org
    cp $SCRIPTPATH/jdev.boot $JDEV_HOME/jdeveloper/jdev/bin/jdev.boot
    echo copy $SCRIPTPATH/ide.conf to $JDEV_HOME/jdeveloper/ide/bin
    mv $JDEV_HOME/jdeveloper/ide/bin/ide.conf $JDEV_HOME/jdeveloper/jdev/bin/ide.conf.org
    cp $SCRIPTPATH/ide.conf $JDEV_HOME/jdeveloper/ide/bin/ide.conf
    #
    echo copy $SCRIPTPATH/$JDEV_PROD_CONF to $JDEV_USR_HOME/$JDEV_PROD_CONF
    envsubst < $SCRIPTPATH/$JDEV_PROD_CONF_TPL > $SCRIPTPATH/$JDEV_PROD_CONF
    mkdir -p $JDEV_USR_HOME
    if [ -f $JDEV_USR_HOME/$JDEV_PROD_CONF ]; then
      mv $JDEV_USR_HOME/$JDEV_PROD_CONF $JDEV_USR_HOME/$JDEV_PROD_CONF.org
    fi
    cp $SCRIPTPATH/$JDEV_PROD_CONF $JDEV_USR_HOME/$JDEV_PROD_CONF
    #
    echo copy JDeveloper SOA QuickStart 12cR2 environment and start scripts to ~/bin
    mkdir -p ~/bin/
    cp $SCRIPTPATH/jdevsoa12c_env.sh ~/bin/ 
    cp $SCRIPTPATH/jdevsoa12c.sh ~/bin/
    cp $SCRIPTPATH/jdevsoa12c.desktop ~/.local/share/applications
  else
    echo $JDEV_INSTALL_JAR not available!.
  fi
else
  if [ -d "$JDEV_HOME" ]; then
    echo JDeveloper SOA QuickStart 12cR2 already installed
  fi
fi
