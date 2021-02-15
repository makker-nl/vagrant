#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
# Install Tekton CLI.
# @author: Martien van den Akker, VirtualSciences.
# 
# Taken from: https://redhat-scholars.github.io/tekton-tutorial/tekton-tutorial/setup.html
#
TKN_CMD=tkn
#TKN_CLI_TGZ=tkn_0.12.0_Linux_x86_64.tar.gz
#TKN_CLI_URI="https://github.com/tektoncd/cli/releases/download/v0.12.0/${TKN_CLI_TGZ}"
TKN_CLI_TGZ=tkn-linux-amd64-0.13.1.tar.gz
TKN_CLI_URI="https://mirror.openshift.com/pub/openshift-v4/clients/pipeline/0.13.1/${TKN_CLI_TGZ}"
TKN_INSTALL_TMP=$INSTALL_TMP_DIR/tkn
TKN_BIN=/usr/local/bin/${TKN_CMD}
TNK_INSTALL_TMP=$AMQ_INSTALL_NAME
#
if [ ! -f "$TKN_BIN" ]; then
 #
  # Download/Setup Tekton cli
  echo Download/Setup  Tekton CLI
  echo . create folder $TKN_INSTALL_TMP
  sudo mkdir -p $TKN_INSTALL_TMP
  echo . Download ${TKN_CLI_URI} into $TKN_INSTALL_TMP/$TKN_CLI_TGZ 
  sudo curl -L "${TKN_CLI_URI}" -o $TKN_INSTALL_TMP/$TKN_CLI_TGZ 
  echo . untar $TKN_INSTALL_TMP/$TKN_CLI_TGZ 
  sudo tar -xf $TKN_INSTALL_TMP/$TKN_CLI_TGZ -C $TKN_INSTALL_TMP
  echo . move $TKN_INSTALL_TMP/${TKN_CMD} to $TKN_BIN
  sudo mv $TKN_INSTALL_TMP/${TKN_CMD} $TKN_BIN
  sudo chmod +x $TKN_BIN
  echo . cleanup folder $TKN_INSTALL_TMP 
  sudo rm -rf $TKN_INSTALL_TMP
else
  echo Tekton CLI already available as: $TKN_BIN
fi
echo Get Tekton version:
tkn version