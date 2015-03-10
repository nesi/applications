library(doMPI, quiet=TRUE)
cl <- startMPIcluster()
registerDoMPI(cl)

foreach(z=1000000:1000050) %dopar% {
  x <- sum(rnorm(z))
}

closeCluster(cl)
mpi.quit()
