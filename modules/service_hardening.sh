#!/bin/bash

echo "Service Hardening started..."

echo -e "\nActive running services:"
systemctl list-units --type=service --state=running

POTENTIAL_RISKS=(telnet rsh vsftpd nfs avahi-daemon cups rpcbind)

echo -e "\nPotantial dangerous services:"
for service in "${POTENTIAL_RISKS[@]}"; do
    if systemctl is-active --quiet "$service"; then
        echo "$service activated! Disabled..."
        systemctl stop "$service"
        systemctl disable "$service"
    else
        echo "$service is not running."
    fi
done

echo -e "\nService Hardening completed."
