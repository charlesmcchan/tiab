#!/bin/bash

# Disable NIC offloading
apk update
apk add ethtool
ethtool --offload eth0 tx off
ethtool --offload eth1 tx off

# Start ONOS
/root/onos/bin/onos-service
