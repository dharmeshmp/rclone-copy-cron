#!/bin/sh

LOG=/var/log/copy.log

rclone copy ${RCLONE_SOURCE} ${RCLONE_DESTINATION} ${RCLONE_OPTIONS} > ${LOG} && printf "rclone-copy complete: ${RCLONE_SOURCE} to ${RCLONE_DESTINATION}\n" >> ${LOG}
cat ${LOG}