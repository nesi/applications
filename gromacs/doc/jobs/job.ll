#@ shell = /bin/sh
#@ job_name = gromacs
#@ class = default
#@ group = nesi
#@ account_no = /nz/nesi
#@ wall_clock_limit = 300:00:00
#@ node_resources = ConsumableMemory(16192mb) ConsumableVirtualMemory(16192mb)
#@ environment = COPY_ALL
#@ job_type = serial
#@ initialdir = /home/mfel395/1IL6
#@ output = $(job_name).$(jobid).out
#@ error = $(job_name).$(jobid).err
#@ queue
 
/share/apps/gromacs/gromacs_workflow.sh -d /home/mfel395/1IL6 -i confout.gro
