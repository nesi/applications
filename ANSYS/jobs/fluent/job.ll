#@ job_name = FluentJobName
#@ notify_user = a.person@auckland.ac.nz
#@ notification = complete
#@ class = default
#@ group = nesi
#@ account_no = uoa
#@ environment=COPY_ALL
#@ wall_clock_limit = 00:30:00
#@ resources = ConsumableMemory(1048mb) ConsumableVirtualMemory(1048mb)
#@ job_type = parallel
#@ initialdir = $(HOME)
#@ total_tasks=8
#@ output = $(job_name).$(jobid).out
#@ error = $(job_name).$(jobid).err
#@ queue

let "limit = 1048 * 1024"
ulimit -v ${limit} -m ${limit}

# Script to run a Fluent job under Loadleveller
 
# Load the moduel file
module load ANSYS/v150
 
#########################################################
# the following is a generic command. In order to get this command working
# please decide if you want to run the 2d or 2ddp OR 3d OR 3ddp solver and
# please use ONLY one of the options in the <> shown below
# fluent <2d|2ddp|3d|3ddp> -g -t2

# Between the two EOFluentInput, you can put your fluent script. The example
# reads a case and a data file, initialises the system, does 6000 iterations 
# and writes the results fluent.dat. 
# 'yes' is the answer to 'do you want to overwrite data in fluent.dat'

fluent -v2d -g -cnf=$LOADL_HOSTFILE -pinfiniband -ssh << EOFluentInput > output.dat
  rc fluent.cas
  rd fluent.dat
  /solve/init/init
  it 6000
  wd fluent.dat
  exit
EOFluentInput
