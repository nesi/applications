# All tasks execute this, but only one returns, the rest become the slave tasks
library(snow)
# Don't specify cluster size or type here, it will be MPI, one fewer nodes than
# the number of tasks specified to sbatch since this one is this master process
cl<-makeMPIcluster()
# 50 calculations to be done:
x <- clusterApply(cl, 1000000:1000050, function(z) sum(rnorm(z)))
stopCluster(cl)
