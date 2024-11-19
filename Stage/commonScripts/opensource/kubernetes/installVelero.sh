#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install velero CLI
# @author: Martien van den Akker, Oracle Consulting
# 
VELERO_REL_URL=https://github.com/vmware-tanzu/velero/releases
VELERO_VER=$(curl -LsS -o /dev/null -w %{url_effective} $VELERO_REL_URL/latest | rev | cut -d'/' -f 1 | rev)
echo "Latest VELERO version: $VELERO_VER"
VELERO_TAR_SHORT_NAME=velero-$VELERO_VER-linux-amd64
VELERO_TAR_NAME=$VELERO_TAR_SHORT_NAME.tar.gz
VELERO_URL=$VELERO_REL_URL/download/$VELERO_VER/$VELERO_TAR_NAME
DOWNLOAD_DIR=~/Downloads
VELERO_TAR_PATH=$DOWNLOAD_DIR/$VELERO_TAR_NAME
VELERO_DIR=$DOWNLOAD_DIR/$VELERO_TAR_SHORT_NAME
BIN_DIR=/usr/local/bin
VELERO_BIN=velero
VELERO_BIN_PATH=/usr/local/bin/$VELERO_BIN
#
if [ -f "$VELERO_BIN_PATH" ]; then
  VELERO_CUR_VER=$($VELERO_BIN version | grep "client version" | cut -d':' -f 2 | tr -d ' ')
  echo "$VELERO_BIN already available. Current version is: $VELERO_CUR_VER"
  if [ "$VELERO_VER" = "$VELERO_CUR_VER" ]; then
    echo "Current version ($VELERO_CUR_VER) is the latest ($VELERO_VER)."
  else
    VELERO_BCK_PATH=${VELERO_BIN_PATH}-${VELERO_CUR_VER}
    echo "Current version ($VELERO_CUR_VER) is not the latest ($VELERO_VER). Backup $VELERO_BIN_PATH to $VELERO_BCK_PATH"
    sudo mv $VELERO_BIN_PATH $VELERO_BCK_PATH
  fi
else
  echo $VELERO_BIN not available yet.
fi
#
if [ ! -f "$VELERO_BIN_PATH" ]; then
 #
  # Download/Setup VELERO
  echo Download/Setup $VELERO_BIN
  mkdir -p $VELERO_DIR
  echo "Download $VELERO_URL into $VELERO_TAR_PATH"
  curl -L $VELERO_URL -o $VELERO_TAR_PATH
  echo "Untar $VELERO_TAR_PATH into $VELERO_DIR"
  tar -zxvf $VELERO_TAR_PATH --directory $DOWNLOAD_DIR
  echo "List $VELERO_DIR: "
  ls  $VELERO_DIR
  echo "Move  $VELERO_DIR/$VELERO_BIN  to $VELERO_BIN_PATH"
  sudo mv $VELERO_DIR/$VELERO_BIN $VELERO_BIN_PATH
  echo "Remove downloads $VELERO_DIR and $VELERO_TAR_PATH"
  rm -rf $VELERO_DIR
  rm -rf $VELERO_TAR_PATH
else
  echo $VELERO_BIN already available as: $VELERO_BIN_PATH
fi
echo "Get $VELERO_BIN version:"
$VELERO_BIN version
