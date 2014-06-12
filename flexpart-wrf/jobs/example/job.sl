#!/bin/bash
# FLEXPART-WRF SubmitScript
# Optimized for run on NeSI Pan Cluster
######################################################
#SBATCH -J FLEXPART-WRF
#SBATCH -A nesi99999           # Project Account
#SBATCH --time=00:10:00        # Walltime
#SBATCH --mem-per-cpu=1024     # memory/cpu (in MB)
######################################################
###  Load the Environment
source /etc/profile.d/modules.sh
module load flexpart-wrf/2006-westmere
######################################################
###  The files will be allocated in the shared FS 
cd /share/src/flexpart-wrf/run.example2
######################################################
###  Run the Parallel Program
srun flexpart_wrf
