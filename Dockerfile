FROM rclone/rclone

# Install cron and necessary dependencies
RUN apk update && apk add --no-cache openrc tzdata

# Copy the copy.sh and setup scripts
COPY copy.sh /etc/copy.sh
COPY setup-cron.sh /etc/setup-cron.sh
RUN chmod +x /etc/copy.sh /etc/setup-cron.sh

# Set default timezone to UTC
ENV TIMEZONE=UTC
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

# Prepare log file
RUN printf "Init\n" > /var/log/copy.log

# Override the default entrypoint
ENTRYPOINT ["/etc/setup-cron.sh"]
