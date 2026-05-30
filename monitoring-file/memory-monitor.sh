#!/bin/bash

#############################################################

# File Name : memory-monitor.sh

#

# Purpose:

# Monitor Memory Utilization

#

# Author: Aaditya Pal

#############################################################

set -e

echo "====================================="
echo "Memory Monitoring Report"
echo "====================================="

free -h

echo ""

TOTAL=$(free -m | awk '/Mem:/ {print $2}')
USED=$(free -m | awk '/Mem:/ {print $3}')

PERCENT=$((USED * 100 / TOTAL))

echo "Memory Usage: ${PERCENT}%"

echo ""

if [ "$PERCENT" -ge 80 ]; then
echo "WARNING: High Memory Utilization Detected!"
else
echo "Memory Utilization Normal"
fi

echo ""

echo "Top 5 Memory Consuming Processes"

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6
