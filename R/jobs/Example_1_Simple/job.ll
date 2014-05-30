#@ shell = /bin/bash
#@ job_name = R_test
#@ class = default
#@ group = nesi
#@ account_no = uoa12345
#@ wall_clock_limit = 00:30:00
#@ resources = ConsumableMemory(4096mb) ConsumableVirtualMemory(4096mb)
#@ job_type = serial
#@ parallel_threads = 1
#@ initialdir = /projects/uoa12345
#@ output = stdout.txt
#@ error = stderr.txt
#@ queue
 
# Enforce memory constraints for jobs running on single nodes. Value is in KB
let "limit = 4096 * 1024"
ulimit -v ${limit} -m ${limit}

R CMD BATCH test.R
