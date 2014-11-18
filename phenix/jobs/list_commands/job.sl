#!/bin/bash
#SBATCH -J phenix_commands
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=05:00:00     # Walltime
#SBATCH --mem-per-cpu=8132  # memory/cpu (in MB)

module load phenix/1.9-1692
source phenix_env.sh

srun phenix.commands
