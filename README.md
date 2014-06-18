getgateway
==========

Get the MAC address of the current local gateway, for use in location based scripts

The script even checks for VPN Device, named tun0. If this device is the current
default routing device, it will check for local interfaces (eth0, wlan0).
