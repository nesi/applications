# You don't have write permissions on /share/test/VASP
# copy the dir to your home dir for this test,
# and change the initialdir below


#!/bin/sh
 
#@ job_name         = run33
#@ group            = nesi
#@ account_no       = uoa12345
#@ job_type         = MPICH
#@ node             = 1
#@ tasks_per_node   = 12
#@ resources        = ConsumableMemory(6656mb) ConsumableVirtualMemory(6656mb)
#@ wall_clock_limit = 48:00:00
#@ shell            = /bin/sh
#@ initialdir       = /share/test/VASP/PTGa3Al17_FinalStp
#@ output           = /projects/uoa12345/$(job_name).$(jobid).out
#@ error            = /projects/uoa12345/$(job_name).$(jobid).err
#@ notification     = complete
#@ queue
 
. /etc/profile.d/modules.sh
module load vasp/5.2-noarch
 
ulimit -v 6291456 -m 6291456
MPIRUN vasp.MPI
