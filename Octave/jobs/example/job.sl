#!/bin/bash
#SBATCH -J Serial_Job
#SBATCH --job-name=octave
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=00:10:00     # Walltime
#SBATCH --mem-per-cpu=2048  # memory/cpu (in MB)
#SBATCH --mail-user=myemail@auckland.ac.nz
#SBATCH --mail-type=ALL
module load Octave
octave  'myTest.m'
