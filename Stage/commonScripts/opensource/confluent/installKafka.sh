#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#FKA_
KAFKA_ZIP_HOME=$INSTALL_HOME/OpenSource/Kafka
KAFKA_INSTALL_HOME=$INSTALL_TMP_DIR/OpenSource/Kafka
KAFKA_INSTALL_ZIP=confluent-oss-5.0.0-2.11.zip
KAFKA_INSTALL_ZIP_DIR=$KAFKA_INSTALL_HOME/confluent-5.0.0
KAFKA_HOME=$OS_BASE/confluent
#
echo "Install Kafka/Confluent 5.0.0"
echo "Checking Kafka/confluent Home: "$KAFKA_HOME
if [ ! -f "$KAFKA_HOME/bin/confluent" ]; then
 #
  #Unzip KAFKA_
  if [ -f "$KAFKA_ZIP_HOME/$KAFKA_INSTALL_ZIP" ]; then
    echo Unzip $KAFKA_ZIP_HOME/$KAFKA_INSTALL_ZIP  to $KAFKA_INSTALL_HOME
    mkdir -p $KAFKA_INSTALL_HOME
    unzip -o $KAFKA_ZIP_HOME/$KAFKA_INSTALL_ZIP -d $KAFKA_INSTALL_HOME
    echo Move zip subfolder $KAFKA_INSTALL_ZIP_DIR to $KAFKA_HOME
    mkdir -p $KAFKA_HOME
    mv $KAFKA_INSTALL_ZIP_DIR/* $KAFKA_HOME
    echo Cleanup $INSTALL_TMP_DIR
    rm -rf $INSTALL_TMP_DIR
  else
    echo Kafka ZIP File $KAFKA_ZIP_HOME/$KAFKA_INSTALL_ZIP does not exist!
  fi  
else
  echo Kafka already installed
fi