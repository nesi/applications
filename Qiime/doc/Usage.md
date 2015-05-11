Our quime_config is:

    cluster_jobs_fp start_parallel_jobs_srun.py
    temp_dir $SCRATCH_DIR

We have added start_parallel_jobs_srun.py to QIIME, based on start_parallel_jobs.py.  As the name suggests, it uses srun, and so for QIIME scripts which can make use of this you can apply multiple CPUs by setting --ntasks greater than one and informing the QIIME script of that with "-n $SLURM_NTASKS".

If the QIIME script(s) you are using make use of USEARCH then please register at http://www.drive5.com/usearch.


