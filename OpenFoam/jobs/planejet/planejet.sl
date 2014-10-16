#!/bin/bash
#SBATCH -J planejet
#SBATCH -A uoa99999		# Project account
#SBATCH -D /share/test/OpenFOAM
#SBATCH --time=06:00:00 	# Walltime
#SBATCH --mem-per-cpu=4096	# memory/cpu (in MB)
#SBATCH -o planejet.out
#SBATCH -e planejet.err
#SBATCH -C sb 				# sb=Sandybridge wm=Westmere
#SBATCH --ntasks=4			# MPI processes
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

module load OpenFOAM/2.3.0-ictce-5.4.0
source $FOAM_BASH

blockMesh
srun simpleFoam -parallel 



