#!/bin/bash

#SBATCH --account=nn9999k --qos=preproc
#SBATCH --nodes=1 
#SBATCH --job-name=job_test
#SBATCH --ntasks-per-node=4
#SBATCH --time=00:00:10

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors

echo "Done "$HOSTNAME
df -h 
env | grep SLURM
rm  /cluster/home/sabryr/jobs/tmp/Trnsfer
