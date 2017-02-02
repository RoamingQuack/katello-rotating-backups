# katello-rotating-backups
Rotating incremental backup script for Katello &amp; RedHat Satellite 6.2+

Run manually or add to cron

* A full backup of Katello or Satellite 6.2 must be performed and located in $src_dir before running this script. 

* Retains the last 3 backups.

* Incremental backups will take Katello/Satellite offline until process is completed
