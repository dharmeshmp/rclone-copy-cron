FROM rclone/rclone

# Install cron and necessary dependencies
RUN apk update && apk add --no-cache openrc tzdata

# Copy the copy.sh and setup scripts
COPY copy.sh /etc/copy.sh
COPY entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/copy.sh /etc/entrypoint.sh

# Set default timezone to UTC
ENV TIMEZONE=UTC
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

# Prepare log file
RUN printf "Init\n" > /var/log/copy.log

# Override the default entrypoint
ENTRYPOINT ["/etc/entrypoint.sh"]
