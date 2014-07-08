#!/bin/bash
#SBATCH -J Serial_Job
#SBATCH --job-name=matlab
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=00:10:00     # Walltime
#SBATCH --mem-per-cpu=4096  # memory/cpu (in MB)
#SBATCH --cpus-per-task=5 
#SBATCH --mail-type=ALL
#SBATCH --mail-user=
module load MATLAB/UoA-FoE-R2012b
srun matlab -nodesktop -nosplash -r myLu
