#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
CD=$PWD
#
. $SCRIPTPATH/amq_env.sh
#
function prop {
    grep "${1}" $SCRIPTPATH/amq-broker.properties|cut -d'=' -f2
}
#
AMQ_BROKER_HOME=$AMQ_DATA_HOME/$AMQ_BROKER_NAME
echo "Checking AMQ Broker Home: "$AMQ_BROKER_HOME
if [ ! -d "$AMQ_BROKER_HOME" ]; then
  #
  AMQ_USER=$(prop 'amq.user') 
  AMQ_PASSWORD=$(prop 'amq.password') 
  AMQ_LOGON_PROFILE=$(prop 'amq.logon_profile') 
  # Create Active MQ Broker
  echo . Create AMQ Data Home: $AMQ_DATA_HOME, user: $AMQ_USER, password $AMQ_PASSWORD, Logon profile: --$AMQ_LOGON_PROFILE
  mkdir -p $AMQ_DATA_HOME
  cd $AMQ_DATA_HOME
  echo . Create AMQ Broker
  ${AMQ_HOME}/bin/artemis create $AMQ_BROKER_NAME --user $AMQ_USER --password $AMQ_PASSWORD --$AMQ_LOGON_PROFILE
  echo cd back to $CD
  cd $CD
  echo . Copy env script and startscript to ~/bin/artemis
  cp $SCRIPTPATH/amq_env.sh ~/bin
  cp $SCRIPTPATH/startAMQBroker.sh ~/bin  
  cp $SCRIPTPATH/stopAMQBroker.sh ~/bin
else
  echo AMQ Broker already created at: $AMQ_BROKER_HOME
fi