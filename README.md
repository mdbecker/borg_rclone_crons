# borg_rclone_crons
Cronjobs for syncing borg backups with s3 deep archive

## Ideas for improvements
Per the borg [docs](https://borgbackup.readthedocs.io/en/stable/faq.html#can-i-copy-or-synchronize-my-repo-to-another-location), the current approach has a major flaw. If the borg backup becomes corrupt, that corruptions will be duplicated to the rcloned copy. Some ideas for addressing this limitation:
* Create a second borg backup using rclone mount. The rclone borg backup will be distinct from the hdd backed copy. If the hdd version becomes corrupt the rclone copy will not be impacted.
* Enable [bucket versioning](https://docs.aws.amazon.com/AmazonS3/latest/dev/ObjectVersioning.html?ref_=pe_411040_118635630) with lifecycle management. The AWS docs suggest you can do this using a noncurrent expiration policy. The downside of this approach is that if your last borg backup is older than your expiration policy, you will only have the last version, which could be corrupt. This could be mitigated by running `borg check` on a regular basis (for example at least half the bucket retention priod). This way you could be sure you have at least one consistent version of your data in the bucket. The only way you could end up with an unusable s3 bucket is if you haven't run either a borg backup or check in > the retention period and if your last backup is corrupt. Many things would have to go wrong for this to be true but it's not impossible.