#!/bin/sh
SCRIPTPATH=$(dirname $0)
echo Install gcc, gdb
sudo dnf -y install gcc gdb
