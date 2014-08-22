#!/bin/bash
# Abaqus SubmitScript
# Optimized for run parallel job 
######################################################
#SBATCH -J Abaqus_TEST
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=02:00:00     # Walltime
#SBATCH --ntasks=1         # number of tasks
#SBATCH --mem-per-cpu=4G  # memory/cpu 
######################################################
###  Load the module

module load ABAQUS

source /share/SubmitScripts/slurm/slurm_setup_abaqus-env.sh

abaqus cae -noGUI=composite.py
