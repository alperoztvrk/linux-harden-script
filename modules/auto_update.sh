#!/bin/bash

echo "Automated Security Updates has been started.."

if ! command -v unattended-upgrade &> /dev/null
then
    echo "unattended-upgrades is not installed, installing..."
    sudo apt-get update
    sudo apt-get install -y unattended-upgrades
fi

UNATTENDED_CONFIG="/etc/apt/apt.conf.d/20auto-upgrades"

sudo bash -c "cat > $UNATTENDED_CONFIG" <<EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOF

echo "Automated Security Updates is activated."
