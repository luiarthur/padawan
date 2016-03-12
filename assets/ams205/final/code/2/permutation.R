permutation.test <- function(x,y,f=mean,B=100) {
  n <- length(x)
  all_dat <- c(x,y)
  perm_stat <- NULL

  for (i in 1:B) {
    #xy_relabelled <- t(apply(xy_true,1,function(r) sample(r)))
    ind <- sample(2*n,n)
    perm_stat[i] <- f(all_dat[ind]) - f(all_dat[-ind])
    cat("\r",i,"/",B)
  }
  
  perm_stat
}
