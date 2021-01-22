#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
# https://learn.hashicorp.com/tutorials/terraform/install-cli
#
TF_ZIP=terraform_0.14.5_linux_amd64.zip
TF_URL="https://releases.hashicorp.com/terraform/0.14.5/${TF_ZIP}"
TF_INSTALL_HOME=$INSTALL_TMP_DIR/TF
TF_INSTALL_ZIP=$TF_INSTALL_HOME/$TF_ZIP
USR_BIN_HOME=/usr/local/bin
TF_CLI=terraform
TF_BIN=$USR_BIN_HOME/$TF_CLI
#
echo "Install Terraform"
echo "Checking Terraform binary: "$TF_BIN
if [ ! -f "$TF_BIN" ]; then
echo "Create folder: "$TF_INSTALL_HOME
  mkdir -p $TF_INSTALL_HOME
  echo Download $TF_URL to $TF_INSTALL_ZIP
  curl $TF_URL -o $TF_INSTALL_ZIP
  echo Unzip $TF_INSTALL_ZIP  to $TF_INSTALL_HOME
  unzip -o $TF_INSTALL_ZIP -d $TF_INSTALL_HOME
  echo Move terraform $TF_INSTALL_HOME/$TF_CLI to $USR_BIN_HOME
  sudo mv $TF_INSTALL_HOME/$TF_CLI $USR_BIN_HOME
  echo Cleanup $INSTALL_TMP_DIR
  rm -rf $INSTALL_TMP_DIR
else
  echo Terraform already installed.
fi
echo Installed Terraform Version:
$TF_CLI --version