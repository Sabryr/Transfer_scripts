#!/bin/bash

#SBATCH --account=nn9999k --qos=preproc
#SBATCH --nodes=1 
#SBATCH --job-name=job_test
#SBATCH --ntasks-per-node=4
#SBATCH --time=00:20:10

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors

LOCK="/cluster/home/sabryr/jobs/Transfer_scripts/Transfer"
FILELIST="/cluster/home/sabryr/jobs/Transfer_scripts/files.list"
OUT_LOC="/cluster/home/sabryr/jobs/Transfer_scripts/to_be_sent"

/cluster/home/sabryr/jobs/Transfer_scripts/create_files.sh $FILELIST $OUT_LOC

rm $LOCK
