#!/bin/bash

#SBATCH -J cuda_4096wat_oct
#SBATCH --time=01:00:00
#SBATCH -A uoa99999
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=512
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

module load Amber/12-ictce-5.4.0
touch dummy
srun pmemd.cuda -O < dummy
/bin/rm -f dummy
