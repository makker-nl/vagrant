#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install helm.
# @author: Martien van den Akker, VirtualSciences.
# 
# Taken from: https://www.liquidweb.com/kb/how-to-install-python-3-on-centos-7/
#
PY3_BIN=/usr/bin/python3
#
if [ ! -f "$PY3_BIN" ]; then
  #
  # 1. Update the environment
  sudo dnf update -y
  # 2: Install Python 3
  sudo dnf install -y python3
else
  echo Python3 already available as: $PY3_BIN
fi
echo Get python3 version:
python3 --version