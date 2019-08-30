#!/bin/bash
#sabryr 30-09-2018
# To transfer file as they are created.
#
# Howto: when the script is started it will look for 
# files (full path) in a file sepcified by $FILELIST
# to be transferd to the location specify by COPYTO.
# To stop the script the LOCK file should be deleted
# This could be done as the final step in the job

LOCK="/cluster/home/sabryr/jobs/Transfer_scripts/Transfer"
COPYTO="/tos-project4/SCRATCH/sabryr/files/"
FILELIST="/cluster/home/sabryr/jobs/Transfer_scripts/files.list"
LOG=$(date +"%Y%m%d_%H%M%S").log

if [ -f $LOCK ]
then
 echo "Found  $LOCK, may be  there is an unfinished transfer, if not delete this and try again"
else
	sbatch transfer_to_nird.slurm &
	echo "Creating $LOCK"
	echo $(date) > $LOCK
	is_list_not_empty=true
	#echo "echo $(ls -lh $LOCK)  is_list_not_empty=$is_list_not_empty"
	while  [ -f $LOCK ] || [ "$is_list_not_empty" = "true" ]
	do
		is_list_not_empty=false
		#echo "echo $(ls -lh $LOCK)  is_list_not_empty=$is_list_not_empty"
		if [ -f $FILELIST ]
		then
			for file in $(grep -v "#" $FILELIST);
			do 
	 			if [ -f $file ]
				then
				        sha1sum $file  >> $LOG
					echo "Tranfering $file to $COPYTO" >>  $LOG
					rsync -av $file $COPYTO
					rm $file
					is_list_not_empty=true
				fi
        		done
        	fi
	
		sleep 5
        	printf "."
	done
	rsync -av $LOG	$COPYTO
fi
