#@ shell = /bin/bash
#@ job_name = blast+
#@ job_type = serial
#@ parallel_threads = 12
#@ wall_clock_limit = 00:30:00
#@ class = default
#@ group = nesi
#@ account_no = uoa12345
#@ initialdir = /projects/uoa12345
#@ output = $(job_name).$(jobid).$(stepid).out
#@ error = $(job_name).$(jobid).$(stepid).err
#@ resources = ConsumableMemory(2048mb) ConsumableVirtualMemory(2048mb)
#@ queue
 
# Enforce memory constraints for jobs running on single nodes. Value is in KB
let "limit = 2048 * 1024"
ulimit -v ${limit} -m ${limit}
 
# Load the BLAST module
module load NCBI-BLAST+/2.2.28
 
# Run the query
blastn -query test.fas -db refseq_rna -task blastn -dust no -outfmt 7 -num_threads 12 -out output.txt
