#!/bin/bash

echo "SSH Hardening started..."

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak.$(date +%Y%m%d_%H%M%S)

sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

systemctl restart ssh

echo "SSH Hardening completed."
