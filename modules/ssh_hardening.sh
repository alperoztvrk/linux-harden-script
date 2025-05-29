#!/bin/bash

echo "SSH Hardening started..."

# SSH config dosyasının yedeğini al
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak.$(date +%Y%m%d_%H%M%S)

# Root login'i devre dışı bırak
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

# Şifreli girişleri devre dışı bırakmak istersen:
# sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

# SSH servisini yeniden başlat
systemctl restart ssh

echo "SSH Hardening completed."
