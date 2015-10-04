hot.T2 <- function(Y,mu) {
  # Calculates the Hotelling's T2, and the corresponding F statistic.
  # Input: Y, the dataset. mu, the hypothesized mean vector.
  # REQUIREMENT: ncol(Y) = length(mu)

  mu <- matrix(mu)
  Y <- as.matrix(Y)
  S <- cov(Y)
  n <- nrow(Y)
  p <- ncol(Y)
  y.bar <- apply(Y,2,mean)
  T2 <- n * t(y.bar-mu) %*% solve(S) %*% (y.bar-mu)
  nu <- n-1
  F.stat <- (nu-p+1)/(nu*p) * T2
  p.val <- pf(F.stat,p,nu-p+1,lower=F)

  out <- matrix(c(T2,n,p,nu,F.stat,p.val),nrow=1)
  colnames(out) <- c("T2","n","p","nu","F.stat","p.val")
  out
}

two.samp.hot.T2 <- function(Y1,Y2) {
  # Calculates the two sample Hotelling's T2-stat, and corresponding F-stat.
  # Input: Y1, Y2, the 2 datasets. REQUIREMENT: ncol(Y1) = ncol(Y2)

  get.w <- function(Y) (nrow(Y)-1) * cov(Y)
  
  W1 <- get.w(Y1)
  W2 <- get.w(Y2)

  n1 <- nrow(Y1)
  n2 <- nrow(Y2)

  Spl <- (W1+W2)/(n1+n2-2)

  y.bar.1 <- apply(Y1,2,mean)
  y.bar.2 <- apply(Y2,2,mean)
  x <- y.bar.1 - y.bar.2
  T2 <- (n1*n2) / (n1+n2) * t(x) %*% solve(Spl) %*% x

  nu <- n1+n2-2
  p <- ncol(Y1) #REQUIRES: ncol(Y1) = ncol(Y2)
  F.stat <- (nu-p+1)/(nu*p) * T2
  p.val <- pf(F.stat,p,nu-p+1,lower=F)

  out <- matrix(c(T2,p,nu,F.stat,p.val),nrow=1)
  colnames(out) <- c("T2","p","nu","F.stat","p.val")
  out
}
