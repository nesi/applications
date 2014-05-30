#!/bin/bash
# LAMMPS SubmitScript
# Optimized for run parallel job of 1024 Cores at NeSI 
######################################################
#SBATCH -J LAMMPS
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=00:30:00     # Walltime
#SBATCH --mem-per-cpu=4096  # memory/cpu (in MB)
#SBATCH --ntasks=128        # Number of tasks
#SBATCH --cpus-per-task=8   # Number of OpenMP threads
######################################################
###  Load the Environment
source /etc/profile.d/modules.sh
module load lammps/12Aug13-sandybridge
######################################################
###  The files will be allocated in the shared FS 
cd $SCRATCH_DIR
cp -pr /share/test/LAMMPS/* .
######################################################
###  Run the Parallel Program
#Lennard Jones Benchmark input parameters: Weak Scaling
srun lmp_mpi -var x 10 -var y 40 -var z 40 -in in.lj
######################################################
###  Transferring the results to the home directory
cp -pr $SCRATCH_DIR $HOME/OUT/lammps/
