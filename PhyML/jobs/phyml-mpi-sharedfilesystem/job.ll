#!/bin/bash 
# PhyML SubmitScript 
# Optimized for run parallel job of NCORES Cores at NeSI (Pandora-SandyBridge)
##########################################################################
#@ job_name = PhyML_TEST
#@ class = default
#@ group = nesi
#@ account_no = uoa123456
#@ initialdir = /projects/uoa12345
#@ notification = never
#@ wall_clock_limit = 00:20:00
#@ resources = ConsumableMemory(4096mb) ConsumableVirtualMemory(4096mb)
#@ job_type = MPICH
#@ blocking = unlimited
#@ node_usage = not_shared
#@ output = $(job_name).$(jobid).out
#@ error = $(job_name).$(jobid).err
#@ requirements = (Feature=="sandybridge")
#@ total_tasks = NCORES
#@ queue
########################################################################## 
###  Load the Enviroment
ulimit -m $((4096*1024)) -v $((4096*1024)) 
. /etc/profile.d/modules.sh
module load PhyML/20120412-sandybridge
########################################################################## 
###  The files will be allocated in the shared FS ($SCRATCH_DIR)
cd $SCRATCH_DIR
cp -pr /share/test/phyml/examples/nucleic .
export OMP_NUM_THREADS=1
/usr/bin/time MPIRUN phyml-mpi -i nucleic -b NCORES
cat $LOADL_HOSTFILE | sort | uniq > machinefile 
/usr/bin/time mpiexec.hydra -np NCORES -machinefile ./machinefile -genv I_MPI_FABRICS dapl -genv I_MPI_PIN_PROCESSOR_LIST='grain=cache2,shift=sock' -envall phyml-mpi -i nucleic -b NCORES 
########################################################################## 
###  Transfering the results to the home directory ($HOME) 
mkdir -p $HOME/OUT/PhyML/
cp -pr $SCRATCH_DIR $HOME/OUT/PhyML/
