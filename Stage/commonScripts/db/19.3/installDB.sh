#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../install_env.sh
. $SCRIPTPATH/db18c_install_env.sh
#
DB_ZIP_HOME=$DB_STAGE_HOME
DB_INSTALL_HOME=$ORACLE_HOME
DB_INSTALL_RSP=db18c_software.rsp
DB_INSTALL_RSP_TPL=$DB_INSTALL_RSP.tpl
DB_INSTALL_ZIP1=V978967-01.zip
#
STARTSTOP_HOME=$SCRIPTPATH/StartStop
#
echo ORACLE_HOME=$ORACLE_HOME
if [ ! -d "$INVENTORY_DIRECTORY" ]; then
  echo Create Inventory directory: $INVENTORY_DIRECTORY
  sudo mkdir -p $INVENTORY_DIRECTORY
  sudo chown -R oracle:oinstall $INVENTORY_DIRECTORY
  sudo chmod -R 775 $INVENTORY_DIRECTORY
else
  echo Inventory directory: $INVENTORY_DIRECTORY exists.
fi
#
if [ ! -f "$ORACLE_HOME/bin/oraping" ]; then
  #Unzip DB12
  echo check $DB_INSTALL_HOME/runInstaller
  if [ ! -f "$DB_INSTALL_HOME/runInstaller" ]; then
    if [[ -f "$DB_ZIP_HOME/$DB_INSTALL_ZIP1" ]]; then
      mkdir -p $DB_INSTALL_HOME
      echo Unzip $DB_ZIP_HOME/$DB_INSTALL_ZIP1 to $DB_INSTALL_HOME
      unzip $DB_ZIP_HOME/$DB_INSTALL_ZIP1 -d $DB_INSTALL_HOME
       
    else
      echo $DB_ZIP_HOME/$DB_INSTALL_ZIP1 does not exist
    fi  
  else
    echo $DB_INSTALL_HOME/database/runInstaller unzipped.
  fi
  if [ -f "$DB_INSTALL_HOME/runInstaller" ]; then
    # Install Database
    echo Install Database 
    echo Substitute $SCRIPTPATH/$DB_INSTALL_RSP_TPL to $SCRIPTPATH/$DB_INSTALL_RSP
    envsubst < $SCRIPTPATH/$DB_INSTALL_RSP_TPL > $SCRIPTPATH/$DB_INSTALL_RSP
    echo Starting the Oracle Installer with command line: $DB_INSTALL_HOME/database/runInstaller -silent -responseFile $SCRIPTPATH/$DB_INSTALL_RSP
    $DB_INSTALL_HOME/runInstaller -silent -ignorePrereq -responseFile $SCRIPTPATH/$DB_INSTALL_RSP > $SCRIPTPATH/runInstaller.out
    tail -f $SCRIPTPATH/runInstaller.out | while read LOGLINE
    do
       echo ${LOGLINE}
       [[ "${LOGLINE}" == *"Successfully Setup Software"* ]] && pkill -P $$ tail
    done
    echo "Finished installing Oracle Database 18c software" 
    #
    sudo $INVENTORY_DIRECTORY/orainstRoot.sh
    sudo $ORACLE_HOME/root.sh
    $ORACLE_HOME/bin/dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbname orcl -sid orcl -responseFile NO_VALUE -characterSet AL32UTF8 -memoryPercentage 30 -emConfiguration LOCAL -SysPassword welcome1 -SystemPassword welcome1 
    echo listener.ora and tnsnames.ora
    cp $SCRIPTPATH/*.ora $ORACLE_HOME/network/admin/
    #echo try to do configTOolCommands
    #$ORACLE_HOME/cfgtoollogs/configToolAllCommands RESPONSE_FILE=$DB_RSP
  else
    echo $DB_INSTALL_HOME/database/runInstaller does not exist.
  fi
  #rm -rf $INSTALL_TMP_DIR
else
  echo Database already installed
fi
echo Copy StartStop scripts to ~/bin
mkdir -p ~/bin
cp $STARTSTOP_HOME/* ~/bin