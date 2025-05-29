#!/bin/bash

echo "Permissions Hardening started..."

# Kritik dosyaların izinlerini kontrol et
declare -A critical_files=(
    ["/etc/passwd"]="644"
    ["/etc/shadow"]="640"
    ["/etc/group"]="644"
    ["/etc/gshadow"]="640"
)

for file in "${!critical_files[@]}"; do
    if [ -e "$file" ]; then
        current_perm=$(stat -c "%a" "$file")
        expected_perm=${critical_files[$file]}
        if [ "$current_perm" != "$expected_perm" ]; then
            echo "$file permission denied ($current_perm), $expected_perm setting up..."
            chmod "$expected_perm" "$file"
        else
            echo "$file permission approved ($current_perm)"
        fi
    else
        echo "$file is not available!"
    fi
done

# World-writable dosyaları bul
echo -e "\nWorld-writable searching files..."
find / -xdev -type f -perm -0002 -ls 2>/dev/null | tee ~/world_writable_files.txt

echo "World-writable files 'world_writable_files.txt' has been saved."

echo "Permissions Hardening completed."
