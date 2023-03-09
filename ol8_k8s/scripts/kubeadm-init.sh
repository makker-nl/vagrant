#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.11 --cri-socket /run/cri-dockerd.sock
# 
# Create kube config
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

