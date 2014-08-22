#!/bin/bash
# ANSYS_FLUENT SubmitScript
# Optimized for run parallel job 
######################################################
#SBATCH -J ANSYS_FLUENT_TEST
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=01:03:00     # Walltime
#SBATCH --ntasks=24         # number of tasks
#SBATCH --mem-per-cpu=2G    # memory/cpu 
######################################################
###  Load the Environment
module load ANSYS/15.0

rm FLUENT_HOSTFILE
srun hostname > FLUENT_HOSTFILE
cat FLUENT_HOSTFILE
#########################################################
# the following is a generic command. In order to get this command working
# please decide if you want to run the 2d or 2ddp OR 3d OR 3ddp solver and
# please use ONLY one of the options in the <> shown below
# fluent <2d|2ddp|3d|3ddp> -g -t2

# Between the two EOFluentInput, you can put your fluent script. The example
# reads a case and a data file, initialises the system, does 6000 iterations 
# and writes the results fluent.dat. 
# 'yes' is the answer to 'do you want to overwrite data in fluent.dat'

fluent -v2d -g -t$SLURM_NTASKS -mpi=pcmpi -cnf=FLUENT_HOSTFILE -ssh << EOFluentInput > output.dat
  rc fluent.cas
  rd fluent.dat
  /solve/init/init
  it 6000
  wd fluent.dat
  exit
EOFluentInput
