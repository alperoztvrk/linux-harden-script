#!/bin/bash

CONFIG_FILE="config.json"
LOG_FILE="logs/harden.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

log() {
    echo "[$TIMESTAMP] $1" | tee -a "$LOG_FILE"
}

run_module() {
    MODULE_NAME=$1
    SCRIPT_PATH="modules/${MODULE_NAME}_hardening.sh"
    if jq -e ".${MODULE_NAME}" "$CONFIG_FILE" > /dev/null; then
        log "Starting $MODULE_NAME module..."
        if bash "$SCRIPT_PATH"; then
            log "$MODULE_NAME module completed successfully."
        else
            log "$MODULE_NAME module finished with errors."
        fi
    else
        log "$MODULE_NAME module not found in config."
    fi
}

# Script Start
log "Linux Hardening Script Started"

MODULES=("ssh" "ufw" "fail2ban" "permissions" "service")

for MODULE in "${MODULES[@]}"; do
    run_module "$MODULE"
done

log "All modules completed."
