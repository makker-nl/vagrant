#!/bin/bash
# Taken from https://kubernetes.io/docs/setup/production-environment/container-runtimes/
echo Forwarding IPv4 and letting iptables see bridged traffic
echo Adapt /etc/modules-load.d/k8s.conf
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

echo Add modules overlay and br_netfilter
sudo modprobe overlay
sudo modprobe br_netfilter

echo Add bridged networking properties to /etc/sysctl.d/k8s.conf
# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

echo Apply sysctl params without reboot
sudo sysctl --system

echo Verify if br_netfilter and overlay are running
lsmod | grep br_netfilter
lsmod | grep overlay

echo Verify that the net.bridge.bridge-nf-call-iptables, net.bridge.bridge-nf-call-ip6tables, net.ipv4.ip_forward system variables are set to 1
sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward
