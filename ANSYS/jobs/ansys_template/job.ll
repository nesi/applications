#@ shell = /bin/sh
#@ job_name = <myjob>.job
#@ notify_user = <my-email>
#@ notification = complete
#@ class = default
#@ group = nesi
#@ account_no = /nz/nesi
#@ wall_clock_limit = 00:30:00
#@ resources = ConsumableMemory(3000mb) ConsumableVirtualMemory(3000mb)
#@ job_type = parallel
#@ total_tasks=40
#@ requirements = (Feature != "rackA")
#@ blocking=unlimited
#@ initialdir = /home/<mydir>
#@ output = $(job_name).$(jobid).out
#@ error = $(job_name).$(jobid).err
#@ queue

# Script to run a CFX job under LoadLeveler
ANSYS=/share/apps/ansys/v145

# Make sure we use ssh
CFX5RSH=ssh
MPI_REMSH=ssh
export CFX5RSH
export MPI_REMSH

# Executable and input file.
defname=<input>.def
exe=$ANSYS/CFX/bin/cfx5solve

# Get list of hosts, and count them
ncpu=`cat $LOADL_HOSTFILE|wc -l`
hostlist=`cat $LOADL_HOSTFILE`
hostlist=`echo $hostlist | sed 's/ /,/g' `

ulimit -m 3000*1024 -v 3000*1024

# Run the job
if [ ${ncpu} -lt 2 ] ; then
  $exe -batch -single -def $defname
else
  $exe -batch -single -def $defname -start-method 'HP MPI Distributed Parallel' -partition $ncpu -par-dist $hostlist <-initial-file <my-init-file>>
fi

