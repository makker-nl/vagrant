#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install Weblogic Image Tool.
# @author: Martien van den Akker, Oracle Consulting.
# 
# Taken from: https://oracle.github.io/weblogic-image-tool/userguide/setup/
#
REL_URL=https://github.com/oracle/weblogic-image-tool/releases
WIT_NAME=imagetool
WIT_DISP_NAME="Oracle Weblogic Image Tool"
WIT_ZIP_NAME=$WIT_NAME.zip
WIT_URL=https://github.com/oracle/weblogic-image-tool/releases/latest/download/$WIT_ZIP_NAME
DOWNLOAD_DIR=~/Downloads
WIT_ZIP_PATH=$DOWNLOAD_DIR/$WIT_ZIP_NAME
ORCL_PROD_HOME=/app/oracle/product
WIT_HOME=$ORCL_PROD_HOME/$WIT_NAME
WIT_BIN=$WIT_HOME/bin/imagetool.sh
export JAVA_HOME=$ORCL_PROD_HOME/jdk11
#
if [ -d "$WIT_HOME" ]; then
  WIT_LATEST_VER=$(curl -s $REL_URL | grep "releases/tag" | head -n1); WIT_LATEST_VER=${WIT_LATEST_VER#*'a href='}
  WIT_LATEST_VER=$(echo $WIT_LATEST_VER |cut -d'"' -f2 | rev | cut -d"/" -f1 | rev | cut -d"-" -f2)
  echo "Latest release $WIT_DISP_NAME: $WIT_LATEST_VER"
  WIT_CUR_VER=$($WIT_BIN --version | cut -d':' -f 2 )
  echo "$WIT_HOME already available with version $WIT_CUR_VER."
  if [ "$WIT_LATEST_VER" = "$WIT_CUR_VER" ]; then
    echo "Current version ($WIT_CUR_VER) is the latest ($WIT_LATEST_VER)."
  else
    echo "Current version ($WIT_CUR_VER) is not the latest ($WIT_LATEST_VER)."
    WIT_BCK_PATH=${WIT_HOME}-${WIT_CUR_VER}
    echo "Backup $WIT_HOME to $WIT_BCK_PATH"
    sudo mv $WIT_HOME $WIT_BCK_PATH
  fi
else
  echo "$WIT_HOME not available yet."
fi
#
if [ ! -d "$WIT_HOME" ]; then
  echo "Download and install $WIT_DISP_NAME"
  # Download/Setup helm
  echo "Download/Setup $WIT_ZIP_NAME"
  curl -m 120 -fL $WIT_URL -o $DOWNLOAD_DIR/$WIT_ZIP_NAME
  echo "Unzip $WIT_ZIP_NAME to $ORCL_PROD_HOME"
  unzip $WIT_ZIP_PATH -d $ORCL_PROD_HOME
  echo "Delete $WIT_ZIP_PATH"
  rm $WIT_ZIP_PATH
else
  echo $WIT_DISP_NAME already available as: $WIT_BIN
fi
echo "Get $WIT_BIN version:"
$WIT_BIN --version