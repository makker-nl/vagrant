#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install regctl.
# @author: Martien van den Akker, Oracle Consulting
# 
# Taken from: https://github.com/regclient/regclient/blob/main/docs/install.md
#
REGCTL_REL_URL=https://github.com/regclient/regclient/releases
REGCTL_VER=$(curl -LsS -o /dev/null -w %{url_effective} $REGCTL_REL_URL/latest | rev | cut -d'/' -f 1 | rev)
REGCTL_URL="https://github.com/regclient/regclient/releases/latest/download/regctl-linux-amd64"
DOWNLOAD_DIR=~/Downloads
BIN_DIR=/usr/local/bin
REGCTL_BIN=regctl
REGCTL_DWNL_BIN=$DOWNLOAD_DIR/$REGCTL_BIN 
REGCTL_BIN_PATH=/usr/local/bin/$REGCTL_BIN 
#
if [ -f "$REGCTL_BIN_PATH" ]; then
  REGCTL_CUR_VER=$($REGCTL_BIN version | grep VCSTag | cut -d':' -f 2 | tr -d ' ')
  echo "$REGCTL_BIN already available. Current version is: $REGCTL_CUR_VER"
  if [ "$REGCTL_VER" = "$REGCTL_CUR_VER" ]; then
    echo "Current version ($REGCTL_CUR_VER) is the latest ($REGCTL_VER)."
  else
    REGCTL_BCK_PATH=${REGCTL_BIN_PATH}-${REGCTL_CUR_VER}
    echo "Current version ($REGCTL_CUR_VER) is not the latest ($REGCTL_VER). Backup $REGCTL_BIN_PATH to $REGCTL_BCK_PATH"
    sudo mv $REGCTL_BIN_PATH $REGCTL_BCK_PATH
  fi
else
  echo $REGCTL_BIN not available yet.
fi
#
if [ ! -f "$REGCTL_BIN_PATH" ]; then
 #
  # Download/Setup regctl
  echo Download/Setup $REGCTL_BIN
  sudo curl -L $REGCTL_URL -o $REGCTL_DWNL_BIN
  sudo install -o root -g root -m 0755 $REGCTL_DWNL_BIN $REGCTL_BIN_PATH
else
  echo $REGCTL_BIN already available as: $REGCTL_BIN_PATH
fi
echo Get $REGCTL_BIN version:
$REGCTL_BIN version
