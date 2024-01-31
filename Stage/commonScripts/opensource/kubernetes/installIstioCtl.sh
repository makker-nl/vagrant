#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install istioctl.
# @author: Martien van den Akker, VirtualSciences.
# 
# Taken from: https://istio.io/latest/docs/setup/getting-started/#download
#
ISTIO_REL_URL=https://github.com/istio/istio/releases
ISTIO_VER=$(curl -LsS -o /dev/null -w %{url_effective} $ISTIO_REL_URL/latest | rev | cut -d'/' -f 1 | rev)
echo "Latest Istio version: $ISTIO_VER"
ISTIO_TAR_SHORT_NAME=istioctl-$ISTIO_VER-linux-amd64
ISTIO_TAR_NAME=$ISTIO_TAR_SHORT_NAME.tar.gz
ISTIOCTL_URL=$ISTIO_REL_URL/download/$ISTIO_VER/$ISTIO_TAR_NAME
DOWNLOAD_DIR=~/Downloads
ISTIOCTL_TAR_PATH=$DOWNLOAD_DIR/$ISTIO_TAR_NAME
ISTIOCTL_DIR=$DOWNLOAD_DIR/$ISTIO_TAR_SHORT_NAME
BIN_DIR=/usr/local/bin
ISTIOCTL_BIN=istioctl
ISTIOCTL_BIN_PATH=/usr/local/bin/$ISTIOCTL_BIN
#
if [ -f "$ISTIOCTL_BIN_PATH" ]; then
  ISTIOCTL_CUR_VER=$($ISTIOCTL_BIN version | grep "client version" | cut -d':' -f 2 | tr -d ' ')
  echo "$ISTIOCTL_BIN already available. Current version is: $ISTIOCTL_CUR_VER"
  if [ "$ISTIO_VER" = "$ISTIOCTL_CUR_VER" ]; then
    echo "Current version ($ISTIOCTL_CUR_VER) is the latest ($ISTIO_VER)."
  else
    ISTIOCTL_BCK_PATH=${ISTIOCTL_BIN_PATH}-${ISTIOCTL_CUR_VER}
    echo "Current version ($ISTIOCTL_CUR_VER) is not the latest ($ISTIO_VER). Backup $ISTIOCTL_BIN_PATH to $ISTIOCTL_BCK_PATH"
    sudo mv $ISTIOCTL_BIN_PATH $ISTIOCTL_BCK_PATH
  fi
else
  echo $ISTIOCTL_BIN not available yet.
fi
#
if [ ! -f "$ISTIOCTL_BIN_PATH" ]; then
 #
  # Download/Setup istioctl
  echo Download/Setup $ISTIOCTL_BIN
  mkdir -p $ISTIOCTL_DIR
  curl -L $ISTIOCTL_URL -o $ISTIOCTL_TAR_PATH
  tar -zxvf $ISTIOCTL_TAR_PATH --directory $ISTIOCTL_DIR
  sudo mv $ISTIOCTL_DIR/$ISTIOCTL_BIN $ISTIOCTL_BIN_PATH
  rm -rf $ISTIOCTL_DIR
  rm -rf $ISTIOCTL_TAR_PATH
else
  echo $ISTIOCTL_BIN already available as: $ISTIOCTL_BIN_PATH
fi
echo "Get $ISTIOCTL_BIN version:"
$ISTIOCTL_BIN version