#!/bin/bash
#SCRIPTPATH=$(dirname $0)
SCRIPT_HOME=$1
#
echo _______________________________________________________________________________
echo Prepare CentOS Linux
$SCRIPT_HOME/0.PrepOEL.sh
echo _______________________________________________________________________________
echo 1. Create Filesystem Disk 2
$SCRIPT_HOME/1.FileSystem.sh
echo _______________________________________________________________________________
echo 2. Create User 
echo . Create RedHat User
$SCRIPT_HOME/2.MakeRedHatUser.sh