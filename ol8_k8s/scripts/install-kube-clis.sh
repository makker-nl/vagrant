#!/bin/bash
# Taken from https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
#
SCRIPTPATH=$(dirname $0)
#
echo Add Kubernetes repo
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

echo Set SELinux to permissive
# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

echo Install kubelet, kubeadm and kubectl
sudo dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

echo Enable kubelet service.
sudo systemctl enable --now kubelet