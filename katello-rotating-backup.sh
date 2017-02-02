#!/bin/bash

shopt -s nullglob # make `("$src_dir"*.gz/.snar)` works
src_dir="/katello-backups/full/" # must have ending slash /
inc_dir="/katello-backups/incremental" # incremental backup dir
d1_dir="/katello-backups/d1/" # delta dir 1
d2_dir="/katello-backups/d2/" # delta dir 2
d3_dir="/katello-backups/d3/" # delta dir 3

err_f="/home/ey7oedr/backup/satlbackup_error.log"

echo "Start $0 $(date)"

touch "$err_f" # >> appended

{

srcfiles=("$src_dir"*.gz)
incfiles=("$inc_dir"*.gz)
d1_files=("$d1_dir"*.gz)
d2_files=("$d2_dir"*.gz)
d3_files=("$d3_dir"*.gz)

echo "Running incremental katello-backup\n"
echo "This may take a while....\n"

katello-backup $inc_dir --incremental $src_dir

for ((i=0; i < ${#srcfiles[@]}; i+=1)); do
        rm -f "${d3_files[i]}";                        # remove oldest backup without prompt
        mv -f "${d2_files[i]}" "$d3_dir"  2>>"$err_f";
        mv -f "${d1_files[i]}" "$d2_dir"  2>>"$err_f";
        mv -f "${srcfiles[i]}" "$d1_dir"  2>>"$err_f"; # move srcfiles without prompt
        if [ $? -eq 0 ]; then
                if [ "$i" -eq 0 ]; then echo "$(date +"%m-%d-%Y %H:%M:%S")"; echo "The following files have been successfully rotated to $d1_dir"; echo; fi
                echo "$((i+1))." $srcfiles 'moved'; echo;
        else
                 echo "Error:  $(<"$err_f")" 2>>"$err_f"; break
        fi

done }

mv -f "${incfiles[i]}" "${src_dir[i]}"


echo "End $0 $(date)"


