#!/bin/bash
dt=`date +%Y-%m-%d-%H_%M_%S`
# This should only copy files modified in the max-time doesn't require any queries to s3 if nothing has changed. Could be combined with the above options to further limit s3 queries? Copies new files over even if it isn't needed. This could be great if the max-age is the same as the cronjob period. There's a race condition here though so we'll need one of the other commands to pick-up anything that was missed. Run this hourly.
/usr/bin/time /usr/bin/rclone copy -vv --exclude "/logs/" --dump headers --fast-list --no-traverse --max-age 65m --checksum --log-file=/logdir/sync-log-hourly-${dt}.log --transfers 2 --s3-chunk-size 16M /mnt/borgdirectory remote:bucket-name > /logdir/sync-time-hourly-${dt}.out 2>&1
/usr/bin/mv /logdir/sync-* /logarchive
