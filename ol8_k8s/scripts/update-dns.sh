#!/bin/bash
# Taken from https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/ubuntu/vagrant/setup-hosts.sh
echo Update DNS
sed -i -e 's/#DNS=/DNS=8.8.8.8/' /etc/systemd/resolved.conf
service systemd-resolved restart