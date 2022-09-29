#!/bin/bash
SCRIPTPATH=$(dirname $0)
ps -ef |grep $1 |grep -v grep| grep -v ps.sh
