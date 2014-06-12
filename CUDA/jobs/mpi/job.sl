#!/bin/bash
#SBATCH -J GPU_JOB
#SBATCH --time=01:00:00     # Walltime
#SBATCH -A uoa99999         # Project Account
#SBATCH --ntasks=4          # number of tasks
#SBATCH --ntasks-per-node=2 # number of tasks per node
#SBATCH --mem-per-cpu=8132  # memory/cpu (in MB)
#SBATCH --cpus-per-task=4   # 4 OpenMP Threads
#SBATCH --gres=gpu:2        # GPUs per node
#SBATCH -C kepler
source /etc/profile
srun binary_cuda_mpi
