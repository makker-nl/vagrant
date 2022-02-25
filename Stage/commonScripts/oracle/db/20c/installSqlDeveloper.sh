#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../install_env.sh
. $SCRIPTPATH/db20c_install_env.sh
#
SQLDEV_ZIP_HOME=$STAGE_HOME/installBinaries/Oracle/DB/20c
SQLDEV_INSTALL_HOME=$EXTRACT_HOME/DB/20c/SQLDeveloper
SQLDEV_INSTALL_ZIP=sqldeveloper-20.4.1.407.0006-no-jre.zip
SQLDEV_INSTALL_FLDR=sqldeveloper
#
echo SQLDEV_HOME=$SQLDEV_HOME
#
if [ ! -d "$SQLDEV_HOME" ]; then
  #Unzip SQLDEV_
  if [ -f "$SQLDEV_ZIP_HOME/$SQLDEV_INSTALL_ZIP" ]; then    
    mkdir -p $SQLDEV_INSTALL_HOME
    echo Unzip $SQLDEV_ZIP_HOME/$SQLDEV_INSTALL_ZIP to $SQLDEV_HOME
    unzip $SQLDEV_ZIP_HOME/$SQLDEV_INSTALL_ZIP -d $SQLDEV_INSTALL_HOME
    echo Move $SQLDEV_INSTALL_HOME/$SQLDEV_INSTALL_FLDR/* $SQLDEV_HOME
    mkdir -p $SQLDEV_HOME
    mv $SQLDEV_INSTALL_HOME/$SQLDEV_INSTALL_FLDR/* $SQLDEV_HOME
    rm -rf $SQLDEV_INSTALL_HOME/$SQLDEV_INSTALL_FLDR
    #StartSop scripts
    echo Copy start scripts
    cp $SCRIPTPATH/StartStop/db21c_env.sh $SCRIPTPATH/StartStop/sqldev.sh ~/bin
    echo Add SQLDeveloper to menu
    sudo cp $SCRIPTPATH/StartStop/sqldev.desktop /usr/share/applications
  else
    echo $SQLDEV_ZIP_HOME/$SQLDEV_INSTALL_ZIP1 does not exist
  fi
else
  echo sqldeveloper already unzipped
fi
