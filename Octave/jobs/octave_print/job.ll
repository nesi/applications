#! /bin/bash
#@ job_name	      = getting_started
#@ job_type       = serial
#@ initialdir     = $(home)/Octave
#@ input          = /dev/null
#@ output         = $(home)/stdout.txt
#@ error          = $(home)/stderr.txt
#@ wall_clock_limit = 1:00
#@ class          = default
#@ account_no     = uoa12345
#@ initialdir     = /projects/uoa12345
#@ restart        = no
#@ resources      =  ConsumableMemory(2048mb) ConsumableVirtualMemory(2048mb)
#@ group          = nesi
#@ shell          = /bin/bash
#@ notification   = complete
#@ queue
#

module load Octave/3.6.4

let "limit = 2048 * 1024"
ulimit -v ${limit} -m ${limit}
octave  'myTest.m'

