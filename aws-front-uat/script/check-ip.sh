#!/bin/bash

# Set the IP addresses to ping
IP_ADDRESSES=("192.168.20.17" "192.168.20.100" "192.168.20.1")

# Set the delay between pings in seconds
DELAY=60

# Set the Line Notify access token and group ID
LINE_TOKEN="<YOUR_LINE_NOTIFY_TOKEN>"
LINE_GROUP="<YOUR_LINE_GROUP_ID>"

# Initialize the status for each IP address as "unknown"
declare -A STATUS
for ip in "${IP_ADDRESSES[@]}"; do
    STATUS["$ip"]="unknown"
done

# Loop indefinitely
while true; do
    # Ping each IP address and update its status
    for ip in "${IP_ADDRESSES[@]}"; do
        ping -c 1 "$ip" > /dev/null
        if [ $? -eq 0 ]; then
            # If ping succeeded, update the status to "up"
            if [ "${STATUS[$ip]}" != "up" ]; then
                STATUS["$ip"]="up"
                # Send a Line Notify message to the group
                curl -X POST -H "Authorization: Bearer ${tokenLineAF}" -F "message=$ip is up at $(date +'%Y-%m-%d %H:%M:%S')" -F "notification_disabled=true" "https://notify-api.line.me/api/notify" > /dev/null
            fi
        else
            # If ping timed out, update the status to "down" and send a notification if necessary
            if [ "${STATUS[$ip]}" != "down" ]; then
                STATUS["$ip"]="down"
                # Send a Line Notify message to the group 
                curl -X POST -H "Authorization: Bearer ${tokenLineAF}" -F "message=$ip is down at $(date +'%Y-%m-%d %H:%M:%S')" -F "notification_disabled=true" "https://notify-api.line.me/api/notify" > /dev/null
            fi
        fi
    done
    # Wait for the specified delay
    sleep $DELAY
done