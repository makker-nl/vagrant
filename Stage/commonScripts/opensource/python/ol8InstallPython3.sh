#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install Python.
# @author: Martien van den Akker, Oracle Technology Consulting.
# 
# Taken from: https://docs.oracle.com/en/operating-systems/oracle-linux/8/python/python-InstallingPython.html
#
PY3_BIN=/usr/bin/python3
#
# 1. Update the environment
sudo dnf update -y
# 2: Install Python 3
sudo dnf module install -y python39
# 3: Set alternative
sudo alternatives --set python3 /usr/bin/python3.9
# 4: Show version
echo Get python3 version:
python3 --version