library(doMC); registerDoMC(strtoi(system("nproc",intern=T))/2)

boot <- function(dat,fn,B=1e4,parallel=T) {
  n <- length(as.vector(dat))
  samp <- function() sample(dat,n,replace=T)
  do.it <- function(x) fn(samp())

  if (parallel) {
    btstrp <- foreach(b=1:B,.combine=rbind) %dopar% do.it(i)
  } else {
    btstrp <- apply(matrix(1:B),1, do.it) 
  }

  est <- mean(btstrp)
  se <- sd(btstrp)

  out <- matrix(c(est,qnorm(c(.025,.975),est,se)),nrow=1)
  colnames(out) <- c("Estimate","CI.Lower","CI.Upper")
  out
} 
