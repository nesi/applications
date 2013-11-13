# Take input from the commandline
args <- commandArgs(TRUE)
numberOfChunks <-args[1]
numberOfNumbers <-args[2]
library(snow)

# mpiexec will define size of cluster so don't give this function call a size parameter
# BeSTGRID resources have MPI installed and use the RMPI library also which is why we specify explicitly the MPI cluster to avoid doubt.

cl <- makeMPIcluster()

# chunkadd is a function that takes two parameters, the file number and the number of numbers to add up.

chunkadd <- function(fileNumber,numbers)
{
    x<- sample(1:10000,numbers,replace=T)
    result <-0
    for(m in 1:length(x)){
        result = result + x[m]
    }
    resultfile<-paste("intermed",fileNumber,".txt",sep="")
    write(result,resultfile)
}

#this is the main body of code.
# clusterApplyLB calls the function chunkadd once for each file (numberOfChunks)
# and distributes them across the available resources in the cluster.
# the LB part of the function name, means that the function will load balance,
# nodes will be fed work depending on how fast they complete previous work.

clusterApplyLB(cl, 1:numberOfChunks, chunkadd, numberOfNumbers)

# as we are using a cluster, we need to stop the cluster before the end of our script.

stopCluster(cl)

# The code to add the intermediate files goes after we have stopped the cluster as it is a serial job, we are no longer running in parallel.
# Initialize the final result variable

finalresult <-0
for (i in 1:numberOfChunks)
{
    # generate the input file name
    inputfile<-paste("intermed",i,".txt",sep="")

    # read the values from the input file, ours will only have one value, but this code will work for files with multiple values
    x <- scan(inputfile)

    # add up the values of the file.
    for(j in 1:length(x)){
        finalresult = finalresult + x[j]
    }
}

# write to file the final result calculated
write(finalresult,"finalresult.txt")

# we use the normal quit operation to exit R
q()
