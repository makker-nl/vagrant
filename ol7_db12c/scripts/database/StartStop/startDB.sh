#!/bin/bash
. db12c_env.sh
#
lsnr_num=`ps -ef|grep tnslsnr |grep -v grep |awk 'END{print NR}'`

if [ $lsnr_num -gt 0 ]
then echo "Database Listener Already RUNNING."
else echo "Starting Infrastructure Database Listener..."
$ORACLE_HOME/bin/lsnrctl start
fi

db_num=`ps -ef|grep pmon |grep -v grep |awk 'END{print NR}'`

if [ $db_num -gt 0 ]
then echo "Database Already RUNNING."
else echo "Starting Oracle Database ..."
$ORACLE_HOME/bin/sqlplus "/ as sysdba" <<EOF
#connect sys/welcome1 as sysdba
startup;
exit;
EOF
#
# With use of a plugable database the following line needs to be added after the startup command
# startup pluggable database pdborcl; 
#
sleep 10
echo "Database Services Successfully Started. "
#
fi
