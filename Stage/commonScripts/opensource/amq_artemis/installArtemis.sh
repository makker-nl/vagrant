#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
export AMQ_INSTALL_NAME=apache-artemis-2.15.0
AMQ_ENV=$SCRIPTPATH/amq_env.sh
AMQ_ENV_TPL=$AMQ_ENV.tpl
envsubst < $AMQ_ENV_TPL > $AMQ_ENV
. $AMQ_ENV
#
AMQ_ZIP_HOME=$STAGE_HOME/installBinaries/OpenSource/AMQ_Artemis
AMQ_INSTALL_TMP=$INSTALL_TMP_DIR/$AMQ_INSTALL_NAME
AMQ_INSTALL_TAR=apache-artemis-2.15.0-bin.tar.gz
AMQ_SUB_DIR=$AMQ_INSTALL_NAME
#
echo "Checking AMQ Artemis Home: "$AMQ_HOME
if [ ! -d "$AMQ_HOME" ]; then
  #
  # Install Apache Active MQ Artemis
  echo Install Apache Active MQ Artemis
  echo create folder $AMQ_INSTALL_TMP
  mkdir -p $AMQ_INSTALL_TMP
  echo create AMQ_HOME $AMQ_HOME
  mkdir -p $AMQ_HOME
  echo Untar $AMQ_ZIP_HOME/$AMQ_INSTALL_TAR to $AMQ_INSTALL_TMP
  tar -xf $AMQ_ZIP_HOME/$AMQ_INSTALL_TAR -C $AMQ_INSTALL_TMP
  echo Move $AMQ_INSTALL_TMP/$AMQ_SUB_DIR/* to $AMQ_HOME
  mv  $AMQ_INSTALL_TMP/$AMQ_SUB_DIR/* $AMQ_HOME
  echo Cleanup $INSTALL_TMP_DIR
  rm -rf $INSTALL_TMP_DIR
  echo Copy Start-Stop scripts
  cp $SCRIPTPATH/startAMQBroker.sh ~/bin
  cp $SCRIPTPATH/stopAMQBroker.sh ~/bin
else
  echo Apache Active MQ Artemis already installed
fi