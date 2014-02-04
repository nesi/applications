#@ shell = /bin/bash
#@ class = default
#@ group = nesi
#@ account_no = uoa
#@ wall_clock_limit = 00:30:00
#@ resources = ConsumableMemory(4096mb) ConsumableVirtualMemory(4096mb)
#@ job_type = serial
#@ parallel_threads = 1
#@ initialdir = ~
#@ output = stdout.txt
#@ error = stderr.txt
#@ queue
 
# Enforce memory constraints for jobs running on single nodes. Value is in KB
let "limit = 4096 * 1024"
ulimit -v ${limit} -m ${limit}
 
module load MATLAB/UoA-FoS-R2012a
matlab -nodesktop -nosplash -singleCompThread -r fftex
