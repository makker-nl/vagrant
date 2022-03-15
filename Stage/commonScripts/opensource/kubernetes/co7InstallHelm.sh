#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install helm.
# @author: Martien van den Akker, VirtualSciences.
# 
# Taken from: https://helm.sh/docs/intro/install/
#
HELM_VER=$(curl -sSL https://github.com/kubernetes/helm/releases | sed -n '/Latest<\/span><\/a>/,$p' | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1)
HELM_URL=https://get.helm.sh/helm-$HELM_VER-linux-amd64.tar.gz
HELM_TAR=~/Downloads/helm-$HELM_VER-linux-amd64.tar.gz
HELM_DIR=~/Downloads/helm-$HELM_VER-linux-amd64
HELM_BIN=/usr/local/bin/helm
#
echo Latest version helm: $HELM_VER
#
if [ ! -f "$HELM_BIN" ]; then
 #
  # Download/Setup helm
  echo Download/Setup helm
  mkdir -p $HELM_DIR
  curl -L $HELM_URL -o $HELM_TAR
  tar -zxvf $HELM_TAR --directory $HELM_DIR
  sudo mv $HELM_DIR/linux-amd64/helm /usr/local/bin/helm
  rm -rf $HELM_DIR
  rm -rf $HELM_TAR
else
  echo helm already available as: $HELM_BIN
fi
echo Get helm version:
helm version