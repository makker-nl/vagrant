#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
. $SCRIPTPATH/db12c_env.sh
#
db_num=`ps -ef|grep pmon |grep -v grep |awk 'END{print NR}'`

if [ $db_num -gt 0 ]
then 
  echo "Database Already RUNNING."
  $ORACLE_HOME/bin/sqlplus "/ as sysdba" <<EOF
shutdown immediate;
prompt create new initorcl.ora.
create pfile from spfile;
exit;
EOF
  #
  # With use of a plugable database the following line needs to be added after the startup command
  # startup pluggable database pdborcl; 
  #
  sleep 10
  echo "Database Services Successfully Stopped. "
else
  echo "Database Not yet RUNNING."
  $ORACLE_HOME/bin/sqlplus "/ as sysdba" <<EOF
prompt create new initorcl.ora.
create pfile from spfile;
exit;
EOF
  sleep 10
fi
#
echo Copy initorcl.ora.small to $ORACLE_HOME/dbs/initorcl.ora, with backup to $ORACLE_HOME/dbs/initorcl.ora.org
mv $ORACLE_HOME/dbs/initorcl.ora $ORACLE_HOME/dbs/initorcl.ora.org
cp $SCRIPTPATH/initorcl.ora.small $ORACLE_HOME/dbs/initorcl.ora
#
echo "Starting Oracle Database again..."
$ORACLE_HOME/bin/sqlplus "/ as sysdba" <<EOF
create spfile from pfile;
startup;
exit;
EOF
  #
  # With use of a plugable database the following line needs to be added after the startup command
  # startup pluggable database pdborcl; 
  #
