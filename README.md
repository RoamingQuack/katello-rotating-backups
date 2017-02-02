# katello-rotating-backups
Rotating incremental backup script for Katello &amp; RedHat Satellite 6.2+

Run manually or add to cron

* A full backup of Katello or Satellite 6.2 must be performed and placed in the appropriate directory before running this script. 

* This will retain the last 3 backups.

* Incremental backups will take katello offline until process is completed
