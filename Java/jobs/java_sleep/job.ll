##########################################################################################
# A job to execute a java jar file which prints out a string every xx seconds,
# sleeping inbetween, yy times.
##########################################################################################

#@ job_type       = serial
#@ initialdir     = //gpfs1m/projects/uoa99999/markus.binsteiner/active-jobs/java_sleep_2013.11.18_16.26.58.457/
#@ input          = /dev/null
#@ output         = //gpfs1m/projects/uoa99999/markus.binsteiner/active-jobs/java_sleep_2013.11.18_16.26.58.457/stdout.txt
#@ error          = //gpfs1m/projects/uoa99999/markus.binsteiner/active-jobs/java_sleep_2013.11.18_16.26.58.457/stderr.txt
#@ wall_clock_limit = 70:00
#@ class          = pan
#@ restart        = no
#@ resources   =  ConsumableMemory(8096) ConsumableVirtualMemory(8096)
#@ group   = nesi
#@ account_no = uoa12345
#@ initialdir = /projects/uoa12345
#@ shell = /bin/bash
#@ queue


ulimit -v 13533184 -m 8290304
/share/apps/smpexec  -s  java  '-XX:MaxHeapSize=64m' '-Xmx128m' '-cp' 'JavaSleep.jar' 'nz.org.nesi.javaTestJob.JavaTestJob' '360' '10'

