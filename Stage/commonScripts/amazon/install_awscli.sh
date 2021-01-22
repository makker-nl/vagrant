#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../install_env.sh
#
# https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html#cliv2-linux-install
#
AWSCLI_ZIP=awscliv2.zip
AWSCLI_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
AWSCLI_INSTALL_HOME=$INSTALL_TMP_DIR/AWS_CLI
AWSCLI_INSTALL_ZIP=$AWSCLI_INSTALL_HOME/$AWSCLI_ZIP
AWSCLI_BIN=/usr/local/aws-cli/v2/current/dist/aws
echo "Install AWS CLI"
echo "Checking AWS CLI binary: "$AWSCLI_BIN
if [ ! -f "$AWSCLI_BIN" ]; then
echo "Create folder: "$AWSCLI_INSTALL_HOME
  mkdir -p $AWSCLI_INSTALL_HOME
  echo Download $AWSCLI_URL to $AWSCLI_INSTALL_ZIP
  curl $AWSCLI_URL -o $AWSCLI_INSTALL_ZIP
  echo Unzip $AWSCLI_INSTALL_ZIP  to $AWSCLI_INSTALL_HOME
  unzip -o $AWSCLI_INSTALL_ZIP -d $AWSCLI_INSTALL_HOME
  echo Install aws cli using $AWSCLI_INSTALL_HOME/aws/install
  sudo $AWSCLI_INSTALL_HOME/aws/install
  echo Cleanup $INSTALL_TMP_DIR
  rm -rf $INSTALL_TMP_DIR
else
  echo AWS CLI already installed.
fi
echo Installed AWS Version:
aws --version