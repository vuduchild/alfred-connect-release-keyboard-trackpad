#!/bin/sh

bluetooth_device_mac=$1
remote_user=$2
remote_machine=$3
homebrew_path=/opt/homebrew/bin
blueutil="${homebrew_path}/blueutil"
gtimeout="${homebrew_path}/gtimeout"

echo "Disconnecting device ${bluetooth_device_mac} locally"
# --is-connected returns 1 if connected and 0 if not. Yes, I know. WTF
${blueutil} --is-connected ${bluetooth_device_mac} && ${blueutil} --unpair ${bluetooth_device_mac}

echo "Sshing to ${remote_user}@${remote_machine} to connect device $bluetooth_device_mac"
ssh "${remote_user}@${remote_machine}" "${blueutil} --is-connected ${bluetooth_device_mac} || ${gtimeout} 4 ${blueutil} --pair ${bluetooth_device_mac} && sleep 1 && ${gtimeout} 4 ${blueutil} --connect ${bluetooth_device_mac}"
