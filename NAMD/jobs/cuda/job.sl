#!/bin/bash
# NAMD CUDA SubmitScript
##########################################################################
#SBATCH -J GROMACS_JOB
#SBATCH --time=01:00:00     # Walltime
#SBATCH -A uoa99999         # Project Account
#SBATCH --mem-per-cpu=2048  # memory/cpu (in MB)
#SBATCH --cpus-per-task=2   # 2 OpenMP Threads
#SBATCH --gres=gpu:2        # GPUs per node
##########################################################################
###  Load the Enviroment Modules for Gromacs 4.5.4
source /etc/profile
module load NAMD/2.9-sandybridge
##########################################################################
###  The files will be allocated in the shared FS ($SCRATCH_DIR)
cp -pr /share/test/NAMD/apoa1/* $SCRATCH_DIR
cd $SCRATCH_DIR
##########################################################################
###  Run the Parallel Program
export OMP_NUM_THREADS=1
srun namd2 apoa1.namd
##########################################################################
###  Transfering the results to the home directory ($HOME)
cp -pr $SCRATCH_DIR $HOME/OUT/namd
