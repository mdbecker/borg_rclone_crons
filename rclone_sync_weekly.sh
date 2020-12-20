#!/bin/bash
dt=`date +%Y-%m-%d-%H_%M_%S`
# This one makes one request per file not efficient but more accurate. Run this weekly.
/usr/bin/time /usr/bin/rclone sync -vv --exclude "/logs/" --dump headers --fast-list --checksum --log-file=/logdir/sync-log-weekly-${dt}.log --transfers 2 --s3-chunk-size 16M /mnt/borgdirectory remote:bucket-name > /logdir/sync-time-weekly-${dt}.out 2>&1
/usr/bin/mv /logdir/sync-* /mnt/borgdirectory/logs
