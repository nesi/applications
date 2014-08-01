#!/bin/bash
# ANSYS_FLUENT SubmitScript
# Optimized for run parallel job 
######################################################
#SBATCH -J ANSYS_CFX_TEST
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --ntasks=16         # number of tasks
#SBATCH --mem-per-cpu=7G  # memory/cpu 
#SBATCH --exclusive
######################################################

### Please use 16, 32, 48, 64, ... tasks, as 
### CFX only runs in exclusive mode.

###  Load the Environment
module load ANSYS/15.0

source /share/SubmitScripts/slurm/slurm_setup_cfx-env.sh

# Executable and input file.
#defname=ringRev9Ch75.def
defname=example.def


cfx5solve -batch -single -def $defname -par -partition $SLURM_NTASKS -par-dist $(cat ansys.env)
