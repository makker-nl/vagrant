#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
OCICLI_MAIN_INSTALL=$SCRIPTPATH/install_ocicli_main.sh
echo Install OCI cli with default settings
#bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
curl "https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh" >> $OCICLI_MAIN_INSTALL
chmod +x $OCICLI_MAIN_INSTALL
$OCICLI_MAIN_INSTALL --accept-all-defaults