#!/bin/bash

echo "User and Group Security has been started..."

echo "Root users:"
getent group sudo | awk -F: '{print $4}' | tr ',' '\n'

echo -e "\nUnnecessary users (nologin shell):"
awk -F: '($7 == "/usr/sbin/nologin" || $7 == "/bin/false") {print $1}' /etc/passwd

PAM_PASSWD="/etc/pam.d/common-password"
if grep -q "pam_pwquality.so" $PAM_PASSWD; then
    sudo sed -i 's/\(pam_pwquality.so.*\)/\1 minlen=12 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1/' $PAM_PASSWD
    echo "PAM password policy has been updated (min 12 karakter, büyük, küçük, rakam, özel karakter zorunlu)."
else
    echo "PAM password policy has not been found, manuel control is reccomended."
fi

echo "User and Group Security has been completed."
