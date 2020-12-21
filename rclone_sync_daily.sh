#!/bin/bash
dt=`date +%Y-%m-%d-%H_%M_%S`
#Lock the file so only one of these scripts can run at once.
# This one is great when nothing has changed. Only 1 GET request is needed. Good for frequent (hourly) runs. Run this every other day.
/usr/bin/time /usr/bin/rclone sync -vv --exclude "/logs/" --dump headers --fast-list --size-only --log-file=/root/sync-log-daily-${dt}.log --transfers 2 --s3-chunk-size 16M /mnt/hd1 remote:mbecker-borg > /root/sync-time-daily-${dt}.out 2>&1
sleep 30
/usr/bin/find /root -name "sync-*" -type f -size +0 -printf "/usr/bin/mv '%p' /mnt/hd1/logs;" | bash
