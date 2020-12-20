#!/bin/bash
dt=`date +%Y-%m-%d-%H_%M_%S`
# This one is great when nothing has changed. Only 1 GET request is needed. Good for frequent (hourly) runs. Run this every other day.
/usr/bin/time /usr/bin/rclone sync -vv --exclude "/logs/" --dump headers --fast-list --size-only --log-file=/logdir/sync-log-daily-${dt}.log --transfers 2 --s3-chunk-size 16M /mnt/borgdirectory remote:bucket-name > /logdir/sync-time-daily-${dt}.out 2>&1
/usr/bin/mv /root/sync-* /mnt/hd1/logs
