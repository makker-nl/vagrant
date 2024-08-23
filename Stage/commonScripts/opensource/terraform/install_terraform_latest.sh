#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
# https://learn.hashicorp.com/tutorials/terraform/install-cli
#
TF_MIN_VERSION=1.3
TF_RELEASES_URL=https://releases.hashicorp.com/terraform
FILTER_LABELS='latest|rc|alpha|beta|debug'
# Get the Highst version >= $TF_LATEST_VERSION
TF_VERSION=$((echo "$TF_MIN_VERSION.9999"; curl -ks $TF_RELEASES_URL | egrep '<a href'  | cut -d'>' -f2 | cut -d'<' -f1 | cut -d'_' -f2 | egrep -v $FILTER_LABELS | egrep "([0-9]\.)+[0-9]") | sort --version-sort --field-separator=. | sed -e '1,/9999/d'  | tail -n 1  )
TF_ZIP=terraform_${TF_VERSION}_linux_amd64.zip
TF_URL="$TF_RELEASES_URL/$TF_VERSION/$TF_ZIP"
TF_INSTALL_HOME=$INSTALL_TMP_DIR/TF
TF_INSTALL_ZIP=$TF_INSTALL_HOME/$TF_ZIP
TF_BIN_HOME=$OS_BASE/terraform_$TF_VERSION
USR_BIN_HOME=/usr/local/bin
TF_CLI=terraform
TF_BIN=$TF_BIN_HOME/$TF_CLI
TF_USR_BIN=$USR_BIN_HOME/$TF_CLI

echo "Install Terraform"
echo "Checking Terraform binary: $TF_BIN"
if [ ! -f "$TF_BIN" ]; then
  echo "Create folder: $TF_INSTALL_HOME"
  mkdir -p $TF_INSTALL_HOME
  echo "Download $TF_URL to $TF_INSTALL_ZIP"
  curl $TF_URL -o $TF_INSTALL_ZIP
  echo "Unzip $TF_INSTALL_ZIP  to $TF_INSTALL_HOME"
  unzip -o $TF_INSTALL_ZIP -d $TF_INSTALL_HOME
  echo "Move terraform $TF_INSTALL_HOME/$TF_CLI to $TF_BIN_HOME"
  mkdir -p $TF_BIN_HOME
  sudo mv $TF_INSTALL_HOME/$TF_CLI $TF_BIN_HOME
  echo "Cleanup $INSTALL_TMP_DIR"
  rm -rf $INSTALL_TMP_DIR
  echo "Create symbolic link $TF_USR_BIN refering to $TF_BIN"
  sudo ln -s $TF_BIN $TF_USR_BIN
else
  echo "Terraform already installed."
fi
echo "Installed Terraform Version:"
$TF_CLI --version

echo "Install Terraform OCI Provider"
sudo yum-config-manager --enable ol8_developer
sudo dnf -y install terraform-provider-oci