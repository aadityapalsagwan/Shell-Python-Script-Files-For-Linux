#!/bin/bash

#############################################################

# File Name : install-docker.sh

#

# Purpose:

# Install Docker Engine on Ubuntu Linux

#

# This script performs:

# 1. System Update

# 2. Remove Old Docker Packages

# 3. Add Docker Official Repository

# 4. Install Docker Engine

# 5. Install Docker CLI

# 6. Install Containerd

# 7. Install Docker Compose Plugin

# 8. Enable Docker Service

# 9. Verify Installation

#

# Supported OS:

# Ubuntu 22.04 / Ubuntu 24.04

#############################################################

set -euxo pipefail

echo "====================================="
echo "Docker Installation Started"
echo "====================================="

#############################################################

# STEP 1 : Update System Packages

#############################################################

sudo apt update -y

#############################################################

# STEP 2 : Remove Old Docker Packages

#############################################################

for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
sudo apt remove -y $pkg || true
done

#############################################################

# STEP 3 : Install Required Packages

#############################################################

sudo apt install -y 
ca-certificates 
curl 
gnupg

#############################################################

# STEP 4 : Create Docker Keyring Directory

#############################################################

sudo install -m 0755 -d /etc/apt/keyrings

#############################################################

# STEP 5 : Add Docker GPG Key

#############################################################

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | 
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

#############################################################

# STEP 6 : Add Docker Repository

#############################################################

echo 
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] 
https://download.docker.com/linux/ubuntu 
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | 
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#############################################################

# STEP 7 : Update Repository Cache

#############################################################

sudo apt update -y

#############################################################

# STEP 8 : Install Docker Components

#############################################################

sudo apt install -y 
docker-ce 
docker-ce-cli 
containerd.io 
docker-buildx-plugin 
docker-compose-plugin

#############################################################

# STEP 9 : Enable Docker Service

#############################################################

sudo systemctl enable docker

sudo systemctl start docker

#############################################################

# STEP 10 : Add Current User To Docker Group

#############################################################

sudo usermod -aG docker $USER

#############################################################

# STEP 11 : Verify Installation

#############################################################

echo ""
echo "====================================="
echo "Docker Version"
echo "====================================="

docker --version

echo ""
echo "====================================="
echo "Docker Compose Version"
echo "====================================="

docker compose version

echo ""
echo "====================================="
echo "Docker Service Status"
echo "====================================="

sudo systemctl status docker --no-pager

echo ""
echo "====================================="
echo "Docker Installed Successfully"
echo "Logout/Login required for"
echo "Docker group permissions."
echo "====================================="
