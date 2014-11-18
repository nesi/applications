#!/bin/bash
#SBATCH -J fixbb.mpi
#SBATCH -A nesi99999         # Project Account
#SBATCH --time=01:00:00      # Walltime
#SBATCH --mem-per-cpu=8096   # Memory/cpu (in MB)
#SBATCH --ntasks=16			 # Number of proccessor cores to use

module load Rosetta/3.5-mpi-gcc-4.4.6

srun fixbb.mpi.linuxgccrelease -no_binary_dunlib -s 1l2y_centroid.pdb -centroid_input -score:weights centroid_des.wts -out:file:scorefile score.cen_sc

