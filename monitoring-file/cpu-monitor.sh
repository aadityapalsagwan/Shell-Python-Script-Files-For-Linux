#!/bin/bash

#############################################################

# File Name : cpu-monitor.sh

#

# Purpose:

# Monitor CPU Utilization

#

# Author: Aaditya Pal

#############################################################

set -e

echo "====================================="
echo "CPU Monitoring Report"
echo "====================================="

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

echo "CPU Usage: ${CPU_USAGE}%"

echo ""

if (( $(echo "$CPU_USAGE > 80" | bc -l) )); then
echo "WARNING: High CPU Utilization Detected!"
else
echo "CPU Utilization Normal"
fi

echo ""
echo "Top 5 CPU Consuming Processes"

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
