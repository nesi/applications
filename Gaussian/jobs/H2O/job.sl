#!/bin/bash

#SBATCH -J H2O
#SBATCH -A uoa99999         # Project Account
#SBATCH -t 01:00:00         # Walltime
#SBATCH --cpus-per-task=8   # 8 OpenMP Threads, same as %NProcShared
#SBATCH --mem-per-cpu=1280  # Memory per CPU (in MB).
                            # Total memory (mem-per-cpu multiplied by
                            # cpus-per-task) should be 2 GB more than
                            # requested with %Mem in Gaussian input.
#SBATCH --workdir=/projects/uoa99999/H2O
#SBATCH -o H2O.out
#SBATCH -e H2O.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=j.bloggs@auckland.ac.nz
#SBATCH --mail-user=jblo123@aucklanduni.ac.nz

module load Gaussian/D.01
export GAUSS_SCRDIR=${SCRATCH_DIR}
srun g09 < H2O.gjf
