#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../../install_env.sh
. $SCRIPTPATH/db21c_install_env.sh
#
DB_ZIP_HOME=$DB_STAGE_HOME
DB_INSTALL_HOME=$ORACLE_HOME
DB_INSTALL_RSP=db21c_software.rsp
DB_INSTALL_RSP_TPL=$DB_INSTALL_RSP.tpl
DB_INSTALL_ZIP1=V1011496-01.zip
#
STARTSTOP_HOME=$SCRIPTPATH/StartStop
#
function prop {
    grep "${1}" $SCRIPTPATH/oracle.properties|cut -d'=' -f2
}

#
echo Install required packages
sudo dnf -y install bc libstdc* gcc-c++* ksh libaio-devel* binutils  glibc libaio libgcc libstdc++ make sysstat libnsl
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
  #Unzip DB
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
    echo $DB_ZIP_HOME/$DB_INSTALL_ZIP1 unzipped into $DB_INSTALL_HOME
  fi
  if [ -f "$DB_INSTALL_HOME/runInstaller" ]; then
    Install Database
    echo Install Database 
    echo Substitute $SCRIPTPATH/$DB_INSTALL_RSP_TPL to $SCRIPTPATH/$DB_INSTALL_RSP
    envsubst < $SCRIPTPATH/$DB_INSTALL_RSP_TPL > $SCRIPTPATH/$DB_INSTALL_RSP
    echo Starting the Oracle Installer with command line: $DB_INSTALL_HOME/database/runInstaller -silent -responseFile $SCRIPTPATH/$DB_INSTALL_RSP
    $DB_INSTALL_HOME/runInstaller -silent -ignorePrereq -responseFile $SCRIPTPATH/$DB_INSTALL_RSP > $SCRIPTPATH/runInstaller.out
    #
    tail -f $SCRIPTPATH/runInstaller.out | while read LOGLINE
    do
      echo ${LOGLINE}
      [[ "${LOGLINE}" == *"Successfully Setup Software"* ]] && pkill -P $$ tail
    done
    echo "Finished installing Oracle Database 18c software" 
    #
    echo "Call the root scripts..."
    sudo $INVENTORY_DIRECTORY/orainstRoot.sh
    sudo $ORACLE_HOME/root.sh
    echo "Now run the Database Configuration Assistent."
    $ORACLE_HOME/bin/dbca -silent -createDatabase -templateName General_Purpose.dbc  \
      -gdbname $(prop 'global.db.name') \
      -sid $(prop 'sid') \
      -responseFile NO_VALUE \
      -characterSet AL32UTF8 \
      -totalMemory $(prop 'memory.total') \
      -emConfiguration LOCAL \
      -SysPassword $(prop 'sys.password') \
      -SystemPassword $(prop 'system.password') \
      -databaseConfigType SINGLE \
      -databaseType MULTIPURPOSE \
      -datafileDestination  $ORACLE_BASE/oradata/$(prop 'sid')
    #  
    echo Copy listener.ora and tnsnames.ora to $ORACLE_HOME/network/admin
    cp $SCRIPTPATH/*.ora $ORACLE_HOME/network/admin/
  else
    echo $DB_INSTALL_HOME/database/runInstaller does not exist.
  fi
 else
   echo Database already installed
 fi
echo Copy StartStop scripts to ~/bin
mkdir -p ~/bin
cp $STARTSTOP_HOME/* ~/bin