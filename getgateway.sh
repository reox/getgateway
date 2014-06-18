#!/bin/bash

# get current routing device
device=$(ip r | grep default | awk '{ print $NF }')
gateway="unknown"

if [ "$device" = "tun0" ]; then
    # we are on VPN, further checks needed...
    # list of interfaces that normaly hold the default route
    interfaces=("eth0" "wlan0")
    for interface in "${interfaces[@]}"
    do
        str=$(ip r | grep "dev $interface" | grep via | awk '{ print $3 }')
        if [ $? -eq 0 ]; then
            gateway=$(sudo arp $str | tail -n 1 | awk '{ print $3 }')
        fi
    done

else
    gateway=$(sudo arp $(ip r | grep default | egrep -o '[0-9]+.[0-9]+.[0-9]+.[0-9]+') | tail -n 1 | awk '{ print $3 }')
fi

echo -n $gateway
