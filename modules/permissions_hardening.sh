#!/bin/bash

LOG_FILE="logs/permissions.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

log() {
    echo "[$TIMESTAMP] $1" | tee -a "$LOG_FILE"
}

log "Permissions Hardening started..."

check_permissions() {
    FILE=$1
    EXPECTED_PERM=$2

    ACTUAL_PERM=$(stat -c "%a" "$FILE")
    if [ "$ACTUAL_PERM" -ne "$EXPECTED_PERM" ]; then
        chmod "$EXPECTED_PERM" "$FILE"
        log "$FILE permission changed to $EXPECTED_PERM"
    else
        log "$FILE permission approved ($EXPECTED_PERM)"
    fi
}

check_permissions /etc/passwd 644
check_permissions /etc/shadow 640
check_permissions /etc/gshadow 640
check_permissions /etc/group 644

log ""
log "World-writable searching files..."
find / -xdev -type f -perm -0002 -ls 2>/dev/null | tee world_writable_files.txt
log "World-writable files 'world_writable_files.txt' has been saved."

log "Permissions Hardening completed."
