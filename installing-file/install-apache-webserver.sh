#!/bin/bash

# Check Operating System
if grep -qi "ubuntu" /etc/os-release; then
    OS="ubuntu"

elif grep -qi "debian" /etc/os-release; then
    OS="debian"

elif grep -qiE "centos|rhel|red hat" /etc/os-release; then
    OS="redhat"

else
    echo "Unsupported Operating System"
    exit 1
fi

# Install Apache based on OS
if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
    echo "Detected OS: $OS"

    sudo apt update
    sudo apt install -y apache2

    sudo systemctl enable apache2
    sudo systemctl start apache2

    SERVICE="apache2"

elif [ "$OS" = "redhat" ]; then
    echo "Detected OS: RedHat/CentOS"

    sudo yum install -y httpd

    sudo systemctl enable httpd
    sudo systemctl start httpd

    SERVICE="httpd"
fi

# Verify Apache Service
if systemctl is-active --quiet $SERVICE; then
    echo "$SERVICE is running successfully."
else
    echo "Failed to start $SERVICE."
fi