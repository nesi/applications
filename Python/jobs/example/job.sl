#!/bin/bash
#SBATCH -J PythonTest
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=00:01:00     # Walltime
#SBATCH --mem-per-cpu=1G  # memory/cpu
#SBATCH --output=stdout.txt
#SBATCH --error=stderr.txt
 
# Load the Python module.
module load Python/2.7.8-goolf-1.5.14
 
# In addition, enable your virtual environment, if needed.
# Just delete or comment out the following line if you don't need your virtual environment.
source ~/mypython/bin/activate
 
# Do something with Python.
python -V 2>&1
