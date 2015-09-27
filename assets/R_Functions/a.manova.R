a.manova <- function(ys) {# a list of matrices
  k <- length(ys)
  n <- as.numeric(lapply(ys,nrow))
  p <- ncol(ys[[1]])
  N <- sum(n)
  ybar. <- lapply(ys,function(y) as.matrix(apply(y,2,mean)))
  y <- lrbind(ys)
  ybar.. <- apply(y,2,mean)

  H <- matrix(0,p,p)
  for (i in 1:k) {
    A <- ybar.[[i]]-ybar..
    H <- n[i] * A%*%t(A) + H
  }
  
  E <- matrix(0,p,p)
  for (i in 1:k){
    for (j in 1:(n[i])){
      A <- ys[[i]][j,] - ybar.[[i]]
      E <- A%*%t(A) + E
    }
  }
  
  lam <- det(E) / det(E+H)
  vH <- k-1
  vE <- N-k
  
  t <- sqrt(((p*vH)^2-4)/(p^2+vH^2-5))
  w <- vE+vH-.5*(p+vH+1)
  df1 <- p*vH
  df2 <- w*t-.5*(p*vH-2)
  lam.th.rt <- lam^(1/t)
  F.stat <- (1-lam.th.rt)*df2/(lam.th.rt*df1)
  #see p.185 of 666 (373)
  out <- c(F.stat,df1,df2,pf(F.stat,df1,df2,lower.tail=F))
  names(out) <- c("F.stat","df1","df2","p.val")
  out
}
