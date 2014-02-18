#@ job_name = gromacs
#@ class = default
#@ group = nesi
#@ account_no = uoa12345
#@ initialdir = /projects/uoa12345
#@ wall_clock_limit = 300:00:00
#@ node_resources = ConsumableMemory(16192mb) ConsumableVirtualMemory(16192mb)
#@ environment = COPY_ALL
#@ job_type = parallel
#@ total_tasks=4
#@ blocking=unlimited
#@ output = $(job_name).$(jobid).out
#@ error = $(job_name).$(jobid).err
#@ queue
 
/share/apps/gromacs/gromacs_workflow.sh -d /projects/uoa12345/1IL6 -i confout.gro -mpi
