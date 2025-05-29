#!/bin/bash

echo "Fail2Ban Hardening Started."

if ! command -v fail2ban-client &> /dev/null
then
   echo "Fail2Ban is not installed, installing..."
   sudo apt-get update
   sudo apt-get install -y fail2ban
fi

sudo systemctl enable fail2ban
sudo systemctl start fail2ban

JAIL_LOCAL="/etc/fail2ban/jail.local"

if [ ! -f "$JAIL_LOCAL" ]; then
    echo"[sshd]" | sudo tee $JAIL_LOCAL > /dev/null
    echo"enabled = true" | sudo tee -a $JAIL_LOCAL > /dev/null
    echo"port = 2222" | sudo tee -a $JAIL_LOCAL > /dev/null
    echo"logpath = /var/log/auth.log" | sudo tee -a $JAIL_LOCAL > /dev/null
    echo"maxretry = 5" | sudo tee -a $JAIL_LOCAL > /dev/null
fi

sudo systemctl restart fail2ban

echo "Fail2Ban Hardening Completed."
