#!/bin/bash
#SBATCH -J matlab
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=00:10:00     # Walltime
#SBATCH --mem-per-cpu=2G    # memory/cpu 
#SBATCH --cpus-per-task=5 
#SBATCH --mail-type=ALL
#SBATCH --mail-user=
module load MATLAB/UoA-FoE-R2012b
srun matlab -nodesktop -nosplash -r myLu
