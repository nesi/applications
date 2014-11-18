#!/bin/bash
#SBATCH -J phenix_commands
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=05:00:00     # Walltime
#SBATCH --mem-per-cpu=8132  # memory/cpu (in MB)

module load Rosetta/3.5-gcc-4.4.6
module load phenix/1.9-1692
export PHENIX_ROSETTA_PATH=$MODULE_ROSETTA_ROOT
source phenix_env.sh

srun phenix_regression.wizards.test_command_line_rosetta_quick
