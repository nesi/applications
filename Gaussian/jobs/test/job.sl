#!/bin/bash
# Gaussian SubmitScript
# Optimized for run parallel job of 8 Cores @ NeSI 
######################################################
#SBATCH -J Gaussian
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --cpus-per-task=8   # 8 OpenMP Threads
#SBATCH --mem-per-cpu=8132  # memory/cpu (in MB)
######################################################
###  Load the Environment Modules for Gaussian
source /etc/profile.d/modules.sh
module load Gaussian/D.01
######################################################
###  Transferring the data to the local disk  ($SCRATCH_DIR)
cd $SCRATCH_DIR
cp /share/test/Gaussian/test0324.com .
export GAUSS_SCRDIR=$SCRATCH_DIR
######################################################
###  Run the Parallel Program
srun g09 < ./test0324.com > test0324.out
######################################################
###  Transferring the results to the project directory
cp -pr $SCRATCH_DIR $PROJECT/OUT/gaussian/
