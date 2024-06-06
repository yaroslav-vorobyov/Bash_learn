#!/usr/bin/env bash
# 
# Script for updating machine-id
# Works on Ubuntu (Guest VM)
# 
# softlink at /var/lib... :
# /var/lib/dbus/machine-id -> /etc/machine-id
# 
# https://superuser.com/questions/655670/two-virtualbox-vms-running-in-parallel-assigned-same-ip

sudo rm -f /etc/machine-id
sudo dbus-uuidgen --ensure=/etc/machine-id
