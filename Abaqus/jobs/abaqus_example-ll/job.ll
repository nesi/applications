##########################################################################################
# for detailed information about LoadLeveler job description files, please visit:
#    - https://wiki.auckland.ac.nz/display/CERES/NeSI+Pan+Cluster+Job+Submission+Guide
#    - https://wiki.auckland.ac.nz/display/CERES/LoadLeveler+-+job+submission
#    - https://wiki.auckland.ac.nz/display/CERES/LoadLeveler+-+example+scripts
##########################################################################################

#@ shell = /bin/bash
#@ job_name = test
#@ class = default
#@ group = nesi
#@ account_no = uoa12345
#@ initialdir = $(HOME)
#@ wall_clock_limit = 1:00:00
#@ resources = ConsumableMemory(10gb) ConsumableVirtualMemory(10gb)
#@ job_type = parallel
#@ total_tasks = 10
#@ output = stdout.txt
#@ error = stderr.txt
#@ queue

# Enforce memory constraints on master process. Value is in KB
let "limit = 10 * 1024  *1024"
ulimit -v ${limit} -m ${limit}

# Prepare the Abaqus env file
envFile=abaqus_v6.env
echo "import os">>$envFile
mp_host_list="["

# Set the hostlist in a format appropriate for Abaqus
for i in $(cat $LOADL_HOSTFILE) ; do
    mp_host_list="${mp_host_list}['$i', 1],"
done

mp_host_list=`echo ${mp_host_list} | sed -e "s/,$//"`
mp_host_list="${mp_host_list}]"
export mp_host_list
echo "mp_host_list=${mp_host_list}" >>abaqus_v6.env
echo "mp_mpirun_path = {HP:'/share/apps/aba/6.10-EF1/External/mpi/hpmpi-2.3/bin/mpirun'}" >> abaqus_v6.env
echo "mp_rsh_command = 'ssh -x -n -l %U %H %C'" >> abaqus_v6.env

/share/apps/aba/6.10-EF1/exec/abq610ef1.exe job=test input=myinput.inp cpus=10 standard_parallel=all mp_mode=mpi interactive
