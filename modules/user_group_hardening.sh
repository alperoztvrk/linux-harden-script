#!/bin/bash

echo "User and Group Security has been started..."

# 1. Root yetkisi olan kullanıcıları listele (sudo erişimi olanlar)
echo "Root users:"
getent group sudo | awk -F: '{print $4}' | tr ',' '\n'

# 2. Gereksiz kullanıcıları tespit için örnek: shell'i /usr/sbin/nologin veya /bin/false olan kullanıcılar
echo -e "\nUnnecessary users (nologin shell):"
awk -F: '($7 == "/usr/sbin/nologin" || $7 == "/bin/false") {print $1}' /etc/passwd

# 3. Root kullanıcısının şifresini zorla değiştirme (opsiyonel, yorum satırı kaldırıp kullanabilirsin)
# echo "root:sifre123" | sudo chpasswd

# 4. Parola minimum uzunluğu ve karmaşıklığı için PAM ayarları (örnek)
PAM_PASSWD="/etc/pam.d/common-password"
if grep -q "pam_pwquality.so" $PAM_PASSWD; then
    sudo sed -i 's/\(pam_pwquality.so.*\)/\1 minlen=12 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1/' $PAM_PASSWD
    echo "PAM password policy has been updated (min 12 karakter, büyük, küçük, rakam, özel karakter zorunlu)."
else
    echo "PAM password policy has not been found, manuel control is reccomended."
fi

echo "User and Group Security has been completed."
