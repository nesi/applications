# Make a SNOW MPI cluster
library(snow)
cl<-makeMPIcluster()

# Avoid warnings about parallel functions duplicating SNOW ones
library(parallel, warn.conflicts = FALSE)

# SNOW MPI clusters can be used in place of non-MPI parallel ones
library(doParallel, quiet=TRUE)
registerDoParallel(cl)

foreach(z=1000000:1000050) %dopar% {
  x <- sum(rnorm(z))
}

stopCluster(cl)
