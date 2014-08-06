#!/bin/bash
# ANSYS_FLUENT SubmitScript
# Optimized for run parallel job 
######################################################
#SBATCH -J ANSYS_CFX_TEST
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --ntasks=16         # number of tasks
#SBATCH --mem-per-cpu=7G  # memory/cpu 
######################################################

###  Load the Environment
module load ANSYS/15.0

source /share/SubmitScripts/slurm/slurm_setup_cfx-env2.sh

# Executable and input file.
defname=example.def

cfx5solve -batch -single -def $defname -par -par-dist $CFX_HOSTLIST
