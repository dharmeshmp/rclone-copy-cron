FROM rclone/rclone

# Install cron and necessary dependencies
RUN apk update && apk add --no-cache openrc

# Copy the copy.sh and setup scripts
COPY copy.sh /etc/copy.sh
COPY setup-cron.sh /etc/setup-cron.sh
RUN chmod +x /etc/copy.sh /etc/setup-cron.sh

# Prepare log file
RUN printf "Init\n" > /var/log/copy.log

# Override the default entrypoint
ENTRYPOINT ["/etc/setup-cron.sh"]

# CMD is unnecessary as ENTRYPOINT now handles startup
