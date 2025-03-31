#!/bin/bash
SCRIPTPATH=$(dirname $0)

function install_base_packages(){
  echo "Installing packages required by the software"
  sudo dnf -y upgrade
  sudo dnf -y install  libstdc* gcc-c++* ksh libaio-devel* dos2unix 
  #
  # Install Haveged
  echo "Install Haveged"
  sudo dnf makecache
  sudo dnf -q -y install haveged
}

#
function add_limits_for_oracle(){
  echo 'Adding entries into /etc/security/limits.conf for oracle user'
  if grep -Fq oracle /etc/security/limits.conf
  then
      echo 'WARNING: Skipping, please verify!'
  else
      echo 'Adding'
      sudo sh -c "sed -i '/End of file/i # Oracle account settings\noracle soft core unlimited\noracle hard core unlimited\noracle soft data unlimited\noracle hard data unlimited\noracle soft memlock 3500000\noracle hard memlock 3500000\noracle soft nofile 1048576\noracle hard nofile 1048576\noracle soft rss unlimited\noracle hard rss unlimited\noracle soft stack unlimited\noracle hard stack unlimited\noracle soft cpu unlimited\noracle hard cpu unlimited\noracle soft nproc unlimited\noracle hard nproc unlimited\n' /etc/security/limits.conf"
  fi
}

function allow_password_auth(){
  echo 'Allow PasswordAuthhentication'
  sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.org
  sudo sed -i 's/PasswordAuthentication no/#PasswordAuthentication no/g' /etc/ssh/sshd_config
  sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
  sudo service sshd restart
}

function main(){
  install_base_packages
  add_limits_for_oracle
  allow_password_auth
}

main "$@"