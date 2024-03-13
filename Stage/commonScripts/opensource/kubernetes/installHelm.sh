#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install helm.
# @author: Martien van den Akker, Oracle Consulting.
# 
# Taken from: https://helm.sh/docs/intro/install/
#
HELM_VER=$(curl -LsS -o /dev/null -w %{url_effective} https://github.com/kubernetes/helm/releases/latest | rev | cut -d'/' -f 1 | rev)
echo "Latest Helm version: $HELM_VER"
HELM_TAR_SHORT_NAME=helm-$HELM_VER-linux-amd64
HELM_TAR_NAME=$HELM_TAR_SHORT_NAME.tar.gz
HELM_URL=https://get.helm.sh/$HELM_TAR_NAME
DOWNLOAD_DIR=~/Downloads
HELM_TAR_PATH=$DOWNLOAD_DIR/$HELM_TAR_NAME
HELM_DIR=$DOWNLOAD_DIR/$HELM_TAR_SHORT_NAME
BIN_DIR=/usr/local/bin
HELM_BIN=helm
HELM_BIN_PATH=/usr/local/bin/$HELM_BIN
#
if [ -f "$HELM_BIN_PATH" ]; then
  HELM_CUR_VER=$($HELM_BIN version | cut -d',' -f 1 |cut -d':' -f 2 | tr -d '"')
  echo "$HELM_BIN already available. Current version is: $HELM_CUR_VER"
  if [ "$HELM_VER" = "$HELM_CUR_VER" ]; then
    echo "Current version ($HELM_CUR_VER) is the latest ($HELM_VER)."
  else
    HELM_BCK_PATH=${HELM_BIN_PATH}-${HELM_CUR_VER}
    echo "Current version ($HELM_CUR_VER) is not the latest ($HELM_VER). Backup $HELM_BIN_PATH to $HELM_BCK_PATH"
    sudo mv $HELM_BIN_PATH $HELM_BCK_PATH
  fi
else
  echo $HELM_BIN not available yet.
fi
#
if [ ! -f "$HELM_BIN_PATH" ]; then
 #
  # Download/Setup helm
  echo Download/Setup $HELM_BIN
  mkdir -p $HELM_DIR
  curl -L $HELM_URL -o $HELM_TAR_PATH
  tar -zxvf $HELM_TAR_PATH --directory $HELM_DIR
  sudo mv $HELM_DIR/linux-amd64/$HELM_BIN $HELM_BIN_PATH
  rm -rf $HELM_DIR
  rm -rf $HELM_TAR_PATH
else
  echo $HELM_BIN already available as: $HELM_BIN_PATH
fi
echo "Get $HELM_BIN version:"
$HELM_BIN version
