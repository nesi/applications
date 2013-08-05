#!/bin/bash

#################################################################
# This is a LoadLevler job template to be used with FSL commands 
# which makes use of fsl_sub to distribute tasks among mulitiple
# processors on a compute cluster managed by LoadLevler.
#
# It works by submitting a 'master' job that runs a command which
# invokes fsl_sub. fsl_sub will launch multiple jobs which the 
# master job will wait for. 
#
# The settings below are divided into several categories.
#################################################################

#################################################################
# FSL Environment Configuration
#################################################################

module load FSL/5.0.4
. fsl.sh
#FSLDIR=/share/apps/fsl
#PATH=${FSLDIR}/bin:${PATH}
#. ${FSLDIR}/etc/fslconf/fsl.sh

#################################################################
# These variables determine which resources you have access to on
# cluster. They are used by fsl_sub when it submits jobs.
#################################################################

#@ class = default
export LL_CLASS=default
#@ account_no = uoa
export LL_ACCOUNT=uoa
#@ group = nesi
export LL_GROUP=nesi

#################################################################
# This is the memory that each sub task will use. If a job
# doesn't have enough memory it will crash.
#################################################################

export LL_MEMORY=10gb

#################################################################
# Variables for email notification used by the master job only.
# fsl_sub also accepts an email parameter with options specifying 
# when emails should be sent. Sub tasks will make use of these
# options if they are set by the script that invokes fsl_sub.
#################################################################

#@ notify_user = s.ansari@auckland.ac.nz
#@ notification = always

#################################################################
# Some standard things like where the master job should run from
# and how long it should take. If sub tasks run longer than the
# master task prost-processing is likely to fail.
#################################################################

#@ wall_clock_limit = 5:00:00
#@ job_name = fsl
#@ initialdir = /share/test/fsl

#################################################################
# Some constants for the master job. You can follow the progress
# of the whole process by looking at the output and error files.
#################################################################

#@ shell = /bin/bash
#@ job_type = serial
#@ resources = ConsumableMemory(1gb) ConsumableVirtualMemory(1gb)
#@ output = $(initialdir)/$(jobid).$(stepid).out
#@ error = $(initialdir)/$(jobid).$(stepid).err
#@ environment = COPY_ALL
#@ restart = yes
#@ queue

#################################################################
# FSL is designed to work with SGE so we need to make it think
# this is an SGE system.
#################################################################

export SGE_ROOT=y

#################################################################
# FSL properties. These are all the bits and pieces you would
# like to define for your tasks. If you have not defined
# environment variables like like FSLDIR elsewhere, you may want
# to do that here.
#################################################################

REQUESTED_TIME=60
export REQUESTED_TIME
DEFRAGMENT_TIME=60
export DEFRAGMENT_TIME

#################################################################
# Your standard shell workflow which may or may not make
# references to fsl_sub at some point.
#################################################################

# Enforce memory constrains
# Convert ConsumableMemory into KB
let "limit = 1 * 1024 * 1024" 
ulimit -m ${limit} -v ${limit}

feat r1_design.fsf

