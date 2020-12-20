#!/bin/bash
dt=`date +%Y-%m-%d-%H_%M_%S`
# This one also only makes one GET request. Could be an alternative or in addition to size-only. Run this every other day.
/usr/bin/time /usr/bin/rclone sync -vv --exclude "/logs/" --dump headers --fast-list --update --use-server-modtime --log-file=/logdir/sync-log-daily-${dt}.log --transfers 2 --s3-chunk-size 16M /mnt/borgdirectory remote:bucket-name > /logdir/sync-time-daily-${dt}.out 2>&1
/usr/bin/mv /logdir/sync-* /mnt/borgdirectory/logs
