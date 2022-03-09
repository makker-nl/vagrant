#!/bin/bash
. db12c_env.sh

echo "Stopping Oracle Database and Listener ..."
$ORACLE_HOME/bin/sqlplus "/ as sysdba" <<EOF
#connect sys/welcome1 as sysdba
shutdown immediate
EOF
#
$ORACLE_HOME/bin/lsnrctl stop
sleep 10;
lsnr_num=`ps -ef|grep tnslsnr |grep -v grep |awk 'END{print NR}'`

if [ $lsnr_num -gt 0 ]
then kill -9 `ps -deafw | grep "$ORACLE_HOME" | grep -v grep |  awk '{print $2}' | paste -s -d" " -`
fi
