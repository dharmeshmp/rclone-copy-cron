#!/bin/sh

LOG=/var/log/copy.log

# Check if BACKUP_CRON is set
if [ -z "$BACKUP_CRON" ]; then
    printf "Error: BACKUP_CRON environment variable must be set.\n" >> $LOG
    exit 1
fi

# Set the cron job to redirect both stdout and stderr to the log file
echo "$BACKUP_CRON /etc/copy.sh" >> /var/spool/cron/crontabs/root
printf "Cron job set with BACKUP_CRON: $BACKUP_CRON\n" >> $LOG

# Start cron in the foreground with logging to stdout
crond -f -l 8 -L /dev/stdout