#!/bin/bash

#SBATCH -J pmemd_4096wat_oct
#SBATCH -A uoa99999
#SBATCH --time=01:00:00
#SBATCH --ntasks=8
#SBATCH --mem-per-cpu=512

module load Amber/12-ictce-5.4.0
srun pmemd.MPI -O
