#!/bin/bash
#SBATCH -J fixbb.serial
#SBATCH -A nesi99999         # Project Account
#SBATCH --time=01:00:00      # Walltime
#SBATCH --mem-per-cpu=8096   # memory/cpu (in MB)

module load Rosetta/3.5-gcc-4.4.6

srun fixbb.linuxgccrelease -no_binary_dunlib -s 1l2y_centroid.pdb -centroid_input -score:weights centroid_des.wts -out:file:scorefile score.cen_sc

