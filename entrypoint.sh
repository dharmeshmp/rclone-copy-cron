#!/bin/sh

LOG=/var/log/copy.log

# Set the timezone
if [ -n "$TIMEZONE" ]; then
    printf "Setting timezone to $TIMEZONE\n" >> $LOG
    ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone
else
    printf "Warning: TIMEZONE environment variable not set. Using default (UTC).\n" >> $LOG
fi

# Check if required variables are set
if [ -z "$RCLONE_SOURCE" ] || [ -z "$RCLONE_DESTINATION" ]; then
    echo "Error: RCLONE_SOURCE and RCLONE_DESTINATION must be set."
    exit 1
fi


# If BACKUP_CRON is not set, run the backup immediately and exit
if [ -z "$BACKUP_CRON" ]; then
    echo "BACKUP_CRON is not set. Starting immediate backup..."
    rclone copy $RCLONE_SOURCE $RCLONE_DESTINATION $RCLONE_OPTIONS
    echo "Backup completed. Exiting..."
    exit 0
fi

# If BACKUP_CRON is set, set up cron
echo "BACKUP_CRON is set. Scheduling the backup with cron..."

# Set the cron job to redirect both stdout and stderr to the log file
echo "$BACKUP_CRON /etc/copy.sh" >> /var/spool/cron/crontabs/root
printf "Cron job set with BACKUP_CRON: $BACKUP_CRON\n" >> $LOG

# Start cron in the foreground with logging to stdout
crond -f -l 8 -L /dev/stdout
