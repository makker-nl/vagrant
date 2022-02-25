#!/bin/bash
SCRIPTPATH=$(dirname $0)
PID=`ps -ef |grep $1 |grep -v grep|awk '{print $2}'`
echo Kill process $1 with id $PID
kill -9 $PID
