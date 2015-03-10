#!/bin/bash
#SBATCH -A uoa12345
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=2G
module load R

# Give this script doMPI_example.R or snow_example.R as an argument (ie: $1)
# Our R has a patched copy of the snow library so that there is no need to use RMPISNOW.
srun Rscript $1
