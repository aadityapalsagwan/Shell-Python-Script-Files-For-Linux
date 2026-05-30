#!/bin/bash

#############################################################

# File Name : master.sh

#

# Purpose:

# Kubernetes Control Plane (Master Node) Setup

#

# Run this script ONLY on the Master Node.

#

# Prerequisite:

# common.sh must be executed successfully first.

#

# This script performs:

# 1. Pull Kubernetes Images

# 2. Initialize Control Plane

# 3. Configure kubectl

# 4. Install Calico Network Plugin

# 5. Generate Worker Join Command

#

# Supported OS:

# Ubuntu 22.04 / Ubuntu 24.04

#############################################################

set -euxo pipefail

#############################################################

# Configuration Section

#############################################################

# Set to "true" if API server should be accessible

# using public IP.

#

# Recommended:

# AWS Private VPC = false

# Internet Facing Cluster = true

PUBLIC_IP_ACCESS="false"

# Default Calico Pod CIDR

POD_CIDR="192.168.0.0/16"

# Get hostname

NODE_NAME=$(hostname -s)

#############################################################

# Pull Required Kubernetes Images

#############################################################

echo "Pulling Kubernetes Images..."

sudo kubeadm config images pull

#############################################################

# Initialize Kubernetes Cluster

#############################################################

echo "Initializing Kubernetes Control Plane..."

if [[ "$PUBLIC_IP_ACCESS" == "false" ]]; then

```
MASTER_PRIVATE_IP=$(hostname -I | awk '{print $1}')

echo "Using Private IP: $MASTER_PRIVATE_IP"

sudo kubeadm init \
    --apiserver-advertise-address="$MASTER_PRIVATE_IP" \
    --apiserver-cert-extra-sans="$MASTER_PRIVATE_IP" \
    --pod-network-cidr="$POD_CIDR" \
    --node-name="$NODE_NAME" \
    --ignore-preflight-errors=Swap
```

elif [[ "$PUBLIC_IP_ACCESS" == "true" ]]; then

```
MASTER_PUBLIC_IP=$(curl -s ifconfig.me)

echo "Using Public IP: $MASTER_PUBLIC_IP"

sudo kubeadm init \
    --control-plane-endpoint="$MASTER_PUBLIC_IP" \
    --apiserver-cert-extra-sans="$MASTER_PUBLIC_IP" \
    --pod-network-cidr="$POD_CIDR" \
    --node-name="$NODE_NAME" \
    --ignore-preflight-errors=Swap
```

else

```
echo "Invalid PUBLIC_IP_ACCESS value."

exit 1
```

fi

#############################################################

# Configure kubectl For Current User

#############################################################

echo "Configuring kubectl..."

mkdir -p "$HOME/.kube"

sudo cp -f /etc/kubernetes/admin.conf "$HOME/.kube/config"

sudo chown "$(id -u)":"$(id -g)" "$HOME/.kube/config"

#############################################################

# Verify Cluster Status

#############################################################

echo "Checking Cluster Nodes..."

kubectl get nodes || true

#############################################################

# Install Calico CNI Plugin

#############################################################

echo "Installing Calico Network Plugin..."

kubectl apply -f 
https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/calico.yaml

#############################################################

# Wait For Calico Pods

#############################################################

echo "Waiting 30 seconds for networking components..."

sleep 30

#############################################################

# Display Cluster Information

#############################################################

echo ""
echo "========================================="
echo "Cluster Information"
echo "========================================="

kubectl get nodes

echo ""
kubectl get pods -A

#############################################################

# Generate Worker Join Command

#############################################################

echo ""
echo "========================================="
echo "Worker Node Join Command"
echo "========================================="
echo ""

kubeadm token create --print-join-command

echo ""
echo "========================================="
echo "Master Node Setup Completed Successfully"
echo "========================================="
