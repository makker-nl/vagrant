#!/bin/bash
echo Create folder for mountpoint /app
sudo mkdir -p /app
echo Create a Logical Volume group and Volume on sdb
sudo ssm create -s 511GB -n disk01 --fstype xfs -p pool01 /dev/sdb /app
sudo ssm list
sudo sh -c "echo \"/dev/mapper/pool01-disk01       /app                    xfs     defaults        0 0\" >> /etc/fstab"

