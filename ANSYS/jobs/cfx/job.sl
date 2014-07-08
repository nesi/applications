#!/bin/bash
# ANSYS_FLUENT SubmitScript
# Optimized for run parallel job 
######################################################
#SBATCH -J ANSYS_CFX_TEST
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --ntasks=12         # number of tasks
#SBATCH --mem-per-cpu=8192  # memory/cpu (in MB)
######################################################
###  Load the Environment
module load ANSYS
#module load ANSYS/v145

source /share/SubmitScripts/slurm/slurm_setup_cfx-env.sh

# Executable and input file.
#defname=ringRev9Ch75.def
defname=M010018.def

export CFX5RSH=ssh
export MPI_REMSH=ssh
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so

 #Run the job
if [ $SLURM_NTASKS -lt 2 ] ; then
  cfx5solve -batch -single -def $defname
else
  cfx5solve -batch -single -def $defname -par -partition $SLURM_NTASKS -par-dist $(cat ansys.env)
fi
