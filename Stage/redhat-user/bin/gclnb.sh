#!/bin/bash
SCRIPTPATH=$(dirname $0)
BRANCH=$1
REPO=$2
echo Clone branch $BRANCH from repo $REPO
git clone --single-branch --branch $BRANCH $REPO
