#!/bin/sh

# Usage:
#   ./check_failed_logins.sh [THRESHOLD] [LOG_FILE]
#
# Parameters:
#   THRESHOLD – (optional) The number of failed login attempts allowed before rebooting (default: 10)
#   LOG_FILE  – (optional) Path to the log file to write actions to (default: /var/log/failed_login_monitor.log)

# === Parameters ===
THRESHOLD=${1:-10}
LOG_FILE=${2:-/var/log/failed_login_monitor.log}

# === Date formats ===
TODAY=$(date "+%b %e")  # e.g., "May 23"
NOW=$(date "+%Y-%m-%d %H:%M:%S")

# === Count failed logins for today ===
FAILS=$(grep "$TODAY" /var/log/auth.log | grep -i "failed" | wc -l)

# === Logging action ===
echo "$NOW - Failed login attempts today: $FAILS (Threshold: $THRESHOLD)" >> "$LOG_FILE"

# === Trigger reboot if necessary ===
if [ "$FAILS" -ge "$THRESHOLD" ]; then
    echo "$NOW - Threshold exceeded. Rebooting system." >> "$LOG_FILE"
    logger "Rebooting due to $FAILS failed login attempts (threshold: $THRESHOLD)"
    /sbin/shutdown -r now "Too many failed login attempts ($FAILS >= $THRESHOLD)"
    #echo "Reboot"
fi
