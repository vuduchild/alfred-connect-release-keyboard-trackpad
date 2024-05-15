#!/bin/sh

bluetooth_device_mac=$1
remote_user=$2
remote_machine=$3
blueutil=/opt/homebrew/bin/blueutil

echo "Disconnecting device ${bluetooth_device_mac} locally"
${blueutil} --unpair ${bluetooth_device_mac} &

echo "Sshing to ${remote_user}@${remote_machine} to connect device $bluetooth_device_mac"
ssh "${remote_user}@${remote_machine}" "${blueutil} --pair ${bluetooth_device_mac} && sleep 1 && ${blueutil} --connect ${bluetooth_device_mac}"
