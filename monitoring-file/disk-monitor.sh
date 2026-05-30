#!/bin/bash

#############################################################

# File Name : disk-monitor.sh

#

# Purpose:

# Monitor Disk Utilization

#

# Author: Aaditya Pal

#############################################################

set -e

THRESHOLD=80

echo "====================================="
echo "Disk Monitoring Report"
echo "====================================="

df -h

echo ""

df -hP | awk 'NR>1 {print $1, $5, $6}' | while read output;
do
USAGE=$(echo $output | awk '{print $2}' | cut -d'%' -f1)
PARTITION=$(echo $output | awk '{print $3}')

```
if [ "$USAGE" -ge "$THRESHOLD" ]; then
    echo "WARNING: Partition $PARTITION is ${USAGE}% full"
fi
```

done

echo ""
echo "Disk Check Completed"
