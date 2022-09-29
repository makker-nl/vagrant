#!/bin/bash
SCRIPTPATH=$(dirname $0)
ENV=$1
MVN_HOME_CNF=/opt/maven/conf
MVN_USER_CNF=~/.m2
MVN_SET_XML=settings.xml
MVN_LCL_REPO=$MVN_USER_CNF/repository
MVN_USER_SET_XML=user-settings.xml
MVN_GLOB_SET_XML=global-settings.xml
MVN_USER_SET=$MVN_USER_CNF/$MVN_SET_XML
MVN_GLOB_SET=$MVN_HOME_CNF/$MVN_SET_XML
# VS Settings
ENV_VS="VS"
MVN_VS_HOME=~/git/VS/redhat-fuse/application-development/developer-config/maven
MVN_VS_USER_SET=$MVN_VS_HOME/$MVN_USER_SET_XML
MVN_VS_GLOB_SET=$MVN_VS_HOME/$MVN_GLOB_SET_XML
MVN_VS_LCL_REPO=$MVN_USER_CNF/repository-vs
# NS Settings
ENV_NS="NS"
MVN_NS_HOME=~/git/NS/CORTEX/cci/cci-config-dev/maven
MVN_NS_USER_SET=$MVN_NS_HOME/$MVN_USER_SET_XML
MVN_NS_GLOB_SET=$MVN_NS_HOME/$MVN_GLOB_SET_XML
MVN_NS_LCL_REPO=$MVN_USER_CNF/repository-ns
#
remove_links () {
  echo Remove link to user maven settings $MVN_USER_SET
  rm $MVN_USER_SET
  echo Remove link to global maven settings $MVN_GLOB_SET
  sudo rm $MVN_GLOB_SET
  echo Remove link to local repo $MVN_LCL_REPO
  sudo rm $MVN_LCL_REPO
}
#
create_links() {
  MVN_ENV_USER_SET=$1 
  MVN_ENV_GLOB_SET=$2
  MVN_ENV_LCL_REPO=$3
  echo Create link $MVN_USER_SET to user maven settings $MVN_ENV_USER_SET
  ln -s $MVN_ENV_USER_SET $MVN_USER_SET
  echo Create link $MVN_GLOB_SET to global maven settings $MVN_ENV_GLOB_SET
  sudo ln -s $MVN_ENV_GLOB_SET $MVN_GLOB_SET
  echo Create link $MVN_LCL_REPO to local repository $MVN_ENV_LCL_REPO
  mkdir -p $MVN_ENV_LCL_REPO
  sudo ln -s $MVN_ENV_LCL_REPO $MVN_LCL_REPO
}

echo Switch Maven settings to $ENV
if [ $ENV = $ENV_VS ]; then
  echo Switch to $ENV_VS
  remove_links
  create_links "$MVN_VS_USER_SET" "$MVN_VS_GLOB_SET" "$MVN_VS_LCL_REPO"
elif [ $ENV = $ENV_NS ]; then
  echo Switch to $ENV_NS
  remove_links
  create_links "$MVN_NS_USER_SET" "$MVN_NS_GLOB_SET" "$MVN_NS_LCL_REPO"
else
  echo Unknown environment $ENV
fi

