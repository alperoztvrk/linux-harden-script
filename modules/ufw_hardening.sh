#!/bin/bash

echo "UFW Firewall Hardening Started..."

if ! command -v ufw &> /dev/null
then
  echo "UFW is not installed, installing..."
  sudo apt-get update
  sudo apt-get install -y ufw
fi

sudo ufw --force reset

sudo ufw default deny incoming
sudo ufw default allow outgoing


sudo ufw allow 2222/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp


sudo ufw --force enable

echo "UFW Firewall Hardening Complated."
