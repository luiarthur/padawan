# EM algorithm for missing data. 
# X = missing data. threshold = convergence parameter. 
# maxit = maximum number of iterations.

EM <- function(X,thresh=.0001,maxit=100) {
  n <- nrow(X)
  p <- ncol(X)

  mis.ri <- NULL
  k <- 1
  for (i in 1:n) {
    if (any(is.na(X[i,]))) {
      mis.ri[k] <- i
      k <- k + 1
    }
  }

  new.X <- X
  for (j in 1:p) new.X[which(is.na(X[,j])),j] <- mean(X[,j],na.rm=T)

  old.X <- new.X + thresh*2
  j <- 1

  while (!(all(abs(new.X-old.X)<thresh)) & (j<maxit)) {
    for (i in mis.ri) {
      if (any(is.na(X[i,]))) {
        mi <- which(is.na(X[i,]))
        mu1 <- apply(as.matrix(new.X[-i, mi]),2,mean)
        mu2 <- apply(as.matrix(new.X[-i,-mi]),2,mean)
        x2  <- new.X[i,-mi]
        S11 <- var(new.X[-i,mi])
        S12 <- var(new.X[-i,mi],new.X[-i,-mi])
        S22 <- var(new.X[-i,-mi])
        B <- S12 %*% solve(S22)
        x1 <- mu1 + B %*% (x2-mu2)
        old.X <- new.X
        new.X[i,mi] <- as.vector(x1)
      }
      #print(Sys.time())
      #print(new.X)
      #Sys.sleep(1)
    } 
    j <- j+1
  } 
  
  print(paste(ifelse(j<maxit,"Converged.","Not Converged."),"Number of Iterations:", j)); cat("\n")
  new.X
}
