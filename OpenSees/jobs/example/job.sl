#!/bin/bash
#SBATCH -J example
#SBATCH -A uoa00245         # Project Account
#SBATCH --time=00:20:00     # Walltime
#SBATCH --ntasks=48         # number of tasks
#SBATCH --mem-per-cpu=2048  # memory/cpu (in MB)
#SBATCH --workdir=/projects/uoa00245/Cer-Example
#SBATCH -C wm               # sb=Sandybridge,wm=Westmere
source /etc/profile
module load OpenSees
srun OpenSeesMP ./example.tcl
