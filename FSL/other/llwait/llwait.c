#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "llapi.h"/* Get lib calls, data types and structures */


int main(int argc, char *argv[])                                                                    
{
    LL_element *queryObject=NULL, *job=NULL, *jobObject=NULL;
    LL_element *step=NULL, *machine = NULL, *cred=NULL, *node=NULL;
    int rc,err=0,obj_count,jobkey,i;
    char *job_step_list[2];
    int filter=QUERY_JOBID;

    if(argc!=2)
    {
        fprintf(stderr,"Usage: %s jobid, where jobid is in site.job format\n",argv[0]);
        return -1;
    }
    rc=0;
    for(i=0;argv[1][i];i++)
      if(argv[1][i]=='.')
         rc++;
    if(rc>1) 
      filter=QUERY_STEPID;
    
    printf("waitinf for job: %s\n", argv[1]);
    while(1)
    {
        err=0;
        obj_count=0;
        /* Initialize the query for jobs */
        queryObject=ll_query(JOBS);
        job_step_list[0]=argv[1];
        job_step_list[1]=NULL;
        rc = ll_set_request(queryObject,filter,job_step_list,ALL_DATA);
        if(rc) 
        { 
            fprintf(stderr,"Cannot obtain job details for %s\n",argv[1]);
            break;
        }

        job=ll_get_objs(queryObject,LL_CM,NULL,&obj_count,&err);
        if(!job)
        {
            break;
        }
        jobkey=0;
        rc=ll_get_data(job, LL_JobJobQueueKey, &jobkey);
        if(rc)
        {
            ll_free_objs(job);
            ll_free_objs(queryObject);
            break;
        }
        ll_free_objs(job);
        ll_free_objs(queryObject);
        sleep(1);
    }
    return 0;
}

