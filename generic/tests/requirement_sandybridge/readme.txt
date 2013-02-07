Gee -- Test job setup
----------------------

1) Configure the test job

 * Create the testjob by editing job.config.
 * Put all input files you need for this job into the 'files' folder. They will end up in the working directory of the job.

2) Configure the checks to run against the job results

 * figure out what you want to test, you can use scripts/executables in the 'checks' subdirectory of the test, the $GEE_TEST_ROOT/checks and $PATH (in that order)
 * edit checks.config, each line is a test (except comments) optional prepend with '<check_name>=' , expected exit code for success is 0
 * if you enclose the filename of a file that you expect to exist in the jobdirectory by one of the following methods, the string will be replaced with the result of the method:
    * content(<filename>): the content of the file
    * filesize(<filename>): the size of the file in bytes
    * file(<filename>): the path to the file itself, which was downloaded by the client and put into a cache directory

3) Logs will be put in the logs subdirectory, if a testrun was successful, the log ends up in the 'archived' folder. If it failed, it will end up in the 'failed' folder, along with stdout/stderr of the checks that failed.