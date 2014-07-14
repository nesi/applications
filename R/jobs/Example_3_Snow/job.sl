#!/bin/bash
#SBATCH -A uoa12345
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=2G
module load R/3.1.1-goolf-1.5.14  
# this version of R has a patched version of the snow library so that there is no need to use RMPISNOW.
srun Rscript parallel-snow.R
