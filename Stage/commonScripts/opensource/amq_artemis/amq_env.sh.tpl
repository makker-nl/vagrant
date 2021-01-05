#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
export AMQ_HOME=$OS_BASE/$AMQ_INSTALL_NAME
export AMQ_DATA_HOME=/app/work/artemis
export AMQ_BROKER_NAME=amqbroker