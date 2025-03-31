#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install Python.
# @author: Martien van den Akker, Oracle Technology Consulting.
# 
# Taken from: https://docs.oracle.com/en/operating-systems/oracle-linux/9/python/python-InstallingPython.html
#
PY3_BIN=/usr/bin/python3
function main(){
  #
  # 1. Update the environment
  sudo dnf update -y
  # 2: Install Python 3
  sudo dnf install python3.12 python3-pip
  # 3: Set alternative
  sudo alternatives --set python3 /usr/bin/python3.12
  sudo alternatives --set python /usr/bin/python3.12
  # sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.12 0
  # sudo update-alternatives --install /usr/bin/python python3 /usr/bin/python3.12 0
  # 4: Show version
  echo Get python3 version:
  python3 --version
}

main "$@"