#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/amq_env.sh
#
AMQ_BROKER_HOME=$AMQ_DATA_HOME/$AMQ_BROKER_NAME
echo "Stop AMQ Broker from: "$AMQ_BROKER_HOME
$AMQ_BROKER_HOME/bin/artemis-service stop