#!/bin/bash

#############################################################

# File Name : common.sh

#

# Purpose:

# Common Kubernetes Setup for ALL Nodes

#

# Supported Nodes:

# - Control Plane (Master Node)

# - Worker Node

#

# This script performs:

# 1. Disable Swap

# 2. Configure Kernel Modules

# 3. Configure Network Parameters

# 4. Install CRI-O Runtime

# 5. Install kubeadm

# 6. Install kubelet

# 7. Install kubectl

# 8. Configure Node IP

#

# Supported OS:

# Ubuntu 22.04 / Ubuntu 24.04

#############################################################

set -euxo pipefail

#############################################################

# Kubernetes Version Configuration

#############################################################

KUBERNETES_VERSION="v1.30"
CRIO_VERSION="v1.30"
KUBERNETES_INSTALL_VERSION="1.30.0-1.1"

echo "================================================="
echo "Starting Kubernetes Common Configuration"
echo "================================================="

#############################################################

# STEP 1 : Disable Swap

#############################################################

# Kubernetes requires swap to be disabled.

sudo swapoff -a

# Keep swap disabled after reboot.

(crontab -l 2>/dev/null; echo "@reboot /sbin/swapoff -a") | crontab - || true

#############################################################

# STEP 2 : Update Operating System

#############################################################

sudo apt update -y

#############################################################

# STEP 3 : Load Required Kernel Modules

#############################################################

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

#############################################################

# STEP 4 : Configure Network Parameters

#############################################################

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
net.ipv4.ip_forward=1
EOF

# Apply changes immediately.

sudo sysctl --system

#############################################################

# STEP 5 : Install Required Packages

#############################################################

sudo apt install -y 
apt-transport-https 
ca-certificates 
curl 
gpg 
software-properties-common

#############################################################

# STEP 6 : Create Keyrings Directory

#############################################################

sudo mkdir -p /etc/apt/keyrings

#############################################################

# STEP 7 : Install CRI-O Container Runtime

#############################################################

echo "Installing CRI-O Runtime..."

curl -fsSL 
https://pkgs.k8s.io/addons:/cri-o:/stable:/${CRIO_VERSION}/deb/Release.key 
| sudo gpg --dearmor -o /etc/apt/keyrings/cri-o-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/cri-o-apt-keyring.gpg] https://pkgs.k8s.io/addons:/cri-o:/stable:/${CRIO_VERSION}/deb/ /" 
| sudo tee /etc/apt/sources.list.d/cri-o.list

sudo apt update -y

sudo apt install -y cri-o

sudo systemctl daemon-reload

sudo systemctl enable crio --now

sudo systemctl start crio

echo "CRI-O Installed Successfully"

#############################################################

# STEP 8 : Install Kubernetes Components

#############################################################

echo "Installing kubeadm, kubelet and kubectl..."

curl -fsSL 
https://pkgs.k8s.io/core:/stable:/${KUBERNETES_VERSION}/deb/Release.key 
| sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${KUBERNETES_VERSION}/deb/ /" 
| sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update -y

sudo apt install -y 
kubelet="${KUBERNETES_INSTALL_VERSION}" 
kubectl="${KUBERNETES_INSTALL_VERSION}" 
kubeadm="${KUBERNETES_INSTALL_VERSION}"

#############################################################

# STEP 9 : Prevent Automatic Upgrades

#############################################################

sudo apt-mark hold kubelet kubeadm kubectl

#############################################################

# STEP 10 : Install jq Utility

#############################################################

sudo apt install -y jq

#############################################################

# STEP 11 : Configure Node IP

#############################################################

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo "Detected Node IP: ${LOCAL_IP}"

cat <<EOF | sudo tee /etc/default/kubelet
KUBELET_EXTRA_ARGS=--node-ip=${LOCAL_IP}
EOF

#############################################################

# STEP 12 : Restart kubelet

#############################################################

sudo systemctl daemon-reload

sudo systemctl restart kubelet

#############################################################

# STEP 13 : Verify Installation

#############################################################

echo ""
echo "=========== VERSION CHECK ==========="

kubeadm version

kubectl version --client

crio --version

echo ""
echo "====================================="
echo "Common Kubernetes Setup Completed"
echo "This node is now ready for cluster join."
echo "====================================="
