#!/bin/bash
# Abaqus SubmitScript
# Optimized for run parallel job 
######################################################
#SBATCH -J Abaqus_TEST
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=08:00:00     # Walltime
#SBATCH --ntasks=24         # number of tasks
#SBATCH --mem-per-cpu=1024  # memory/cpu (in MB)
#SBATCH -C wm               # sb=Sandybridge,wm=Westmere
######################################################
###  Load the Environment
source /etc/profile
module load Abaqus
######################################################
###  The files will be allocated in the shared FS
cp myinput.inp $SCRATCH_DIR
cd $SCRATCH_DIR
source /share/SubmitScripts/slurm/slurm_setup_abaqus-env.sh
######################################################
###  Run the Parallel Program
abaqus job=test input=myinput.inp cpus=$SLURM_NTASKS -verbose 3 standard_parallel=all scratch=$SCRATCH_DIR mp_mode=mpi interactive
######################################################
###  Transferring the results to the home directory ($HOME)
mkdir -p $HOME/OUT/abaqus
cp -pr $SCRATCH_DIR $HOME/OUT/abaqus
