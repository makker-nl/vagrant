#!/bin/bash
#############################################################################
# Clone multiple Git repositories for gem. Rotterdam - OIC
#
# @author Martien van den Akker, Oracle Consulting
# @version 1.0, 2023-02-28 - Move working copy/clone locations to user props.
#
#############################################################################
SCRIPTPATH=$(dirname $0)
#
# Global variables
PULL=false
RESET=false
DEVEL=false
DEVEL_BRANCH=develop
#
# Function to get properties
GIT_USER_PROPS=gitUser.properties
#
function prop {
    grep "${1}" $SCRIPTPATH/$GIT_USER_PROPS|cut -d'=' -f2
}
#
# Global variables that depend on user properties.
WC_HOME=$(prop 'wc.home')
GIT_URL_MAKKER=$(prop 'git.url_makker')
WC_MAKKER=$WC_HOME/$(prop 'wc.makker')
GIT_URL_POLITIELAB=$(prop 'git.url_politielab')
WC_POLITIELAB=$WC_HOME/$(prop 'wc.politielab')

#
#
# Check and interpret the provided commandline parameters.
check_params () {
  for i in $@
  do 
    if [[ "$i" == "pull" ]]; then
      echo "Set PULL = true"
      PULL=true
    elif [[ "$i" == "reset" ]]; then
      while true; do
        read -p "Do you wish to reset all the repos? " yn
        case $yn in
          [Yy]* ) echo "Set RESET = true"; RESET=true; break;;
          [Nn]* ) exit;;
          * ) echo "Please answer yes or no.";;
        esac
      done
    elif [[ "$i" == "devel" ]]; then
      DEVEL=true
    fi
  done
}
#
# Do a Git pull for provided working copy repository.
pull() {
  WC_REPO=$1
  echo "Trying to pull $WC_REPO."
  git -C $WC_REPO pull --rebase
}
#
# Checkout provided branch for working copy repository.
checkout_branch() {
  WC_REPO=$1
  BRANCH=$2
  echo Checkout Branch $BRANCH
  git -C $WC_REPO checkout -b $BRANCH
  git -C $WC_REPO branch --set-upstream-to=origin/$BRANCH $BRANCH
  pull $WC_REPO
}
#
# Perform a clone Git Remote Repository and/or reset and/or pull for working copy repository.
clone () {
  GIT_URL=$1
  WC_LOC=$2
  REPO=$3
  WC_REPO=$WC_LOC/$REPO
  GIT_REPO=$GIT_URL/$REPO.git
  echo Check working copy $WC_REPO
  if [[ ! -d "$WC_REPO" ]]
  then
    echo "Clone repo $GIT_REPO into $WC_REPO"
    git clone $GIT_REPO $WC_REPO
  else
    echo "Repo $WC_REPO already exists!"
    if [[ "$RESET" == "true" ]]; then
      echo "Trying to reset it."
      git -C $WC_REPO reset --hard HEAD
    else
      echo "Skip reset."
    fi
    if [[ "$PULL" == "true" ]]; then
      pull $WC_REPO
    else
      echo "Skip pull."
    fi
    if [[ "$DEVEL" == "true" ]]; then
      checkout_branch $WC_REPO $DEVEL_BRANCH
    else
      echo "Skip checkout $DEVEL_BRANCH branch."
    fi
  fi
}
#
# Clone makker Git Repos.
clone_makker () {
  clone $GIT_URL_MAKKER $WC_MAKKER "ansible"
  clone $GIT_URL_MAKKER $WC_MAKKER "blog"
  clone $GIT_URL_MAKKER $WC_MAKKER "Dotacc"
  # clone $GIT_URL_MAKKER $WC_MAKKER "FuseSoapAmqMicrocksDemo"
  # clone $GIT_URL_MAKKER $WC_MAKKER "FuseTools"
  clone $GIT_URL_MAKKER $WC_MAKKER "Kubernetes"
  clone $GIT_URL_MAKKER $WC_MAKKER "makker-nl.github.io"
  clone $GIT_URL_MAKKER $WC_MAKKER "ooplsql"
  clone $GIT_URL_MAKKER $WC_MAKKER "scriptsandsnippets"
  clone $GIT_URL_MAKKER $WC_MAKKER "udemy-cpp"
  clone $GIT_URL_MAKKER $WC_MAKKER "vagrant"
  clone $GIT_URL_MAKKER $WC_MAKKER "vagrant-ol-kubernetes"
  clone $GIT_URL_MAKKER $WC_MAKKER "WeblogicScripts"
  clone $GIT_URL_MAKKER $WC_MAKKER "WindowsInstallScripts"
}
#
# Clone politielab Git Repos.
clone_politielab () {
  clone $GIT_URL_POLITIELAB $WC_POLITIELAB "shared-repo"
}

main () {
  echo "Working copy home: $WC_HOME"
  echo "Git URL Makker: $GIT_URL_MAKKER"
  echo "Working copy Makker: $WC_MAKKER"
  check_params "$@"
  #clone_makker
  clone_politielab
}
main "$@"
