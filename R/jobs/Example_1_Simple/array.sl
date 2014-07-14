#!/bin/bash
#SBATCH -J R-array
#SBATCH -A uoa12345         # Project Account
#SBATCH --time=01:00:00     # Walltime (hh:mm:ss)
#SBATCH --mem-per-cpu=2048  # memory/cpu (in MB)
#SBATCH --array=1-10        # Array definition (max 1000 jobs)

# SLURM creates an environment variable that holds the array id (e.g 1 - 10)
# This is useful if you want to read a filename unique to the job e.g input_1.txt, input_2.txt, ... input_10.txt
# It is also useful as a random seed that guarntees each job will draw random numbers in a different sequence.

# You can access this value from within R using Sys.getenv e.g:
# jobid = as.numeric(Sys.getenv("SLURM_ARRAY_TASK_ID"))

srun Rscript test.R
