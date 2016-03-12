source("plotmap.R")

orb <- read.table("../dat/orbits.txt",header=TRUE)

analytic_mle <- function(wd,x=orb$X,y=orb$Y) {
  n <- length(y)
  w <- wd[1]
  d <- wd[2]
  C <- cbind(1,cos(x*w+d))
  Ct <- t(C)
  CCi <- solve(Ct%*%C)
  beta <- CCi %*% Ct %*% y
  a <- beta[1]
  b <- beta[2]
  s2 <- sum((y - C %*% beta)^2) / n
  out <- matrix(c(a,b,s2), 1)
  colnames(out) <- c("a","b","s2")
  out
}

profile_like <- function(wd,x=orb$X,y=orb$Y) {
  n <- length(y)

  ll <- function(a,b,w,d,s2) {
    out <- NULL
    if (s2 > 0 && d < pi && d > -pi) {
      mu <- a+b*cos(w*x+d)
      n <- length(y)
      out <- -n*log(s2)/2 -sum((y-mu)^2)/(2*s2) 
    } else {
      out <- -1e18
    }
    out
  }

  log_like <- function(par) 
    ll(a=par[1],b=par[2],w=par[3],d=par[4],s2=par[5])


  par <- analytic_mle(wd)
  abwds <- c(par[1:2],wd,par[3])
  log_like(abwds)
}

all_mle_from_wd <- function(wd) {
  abs2 <- analytic_mle(wd)
  abwds <- c(abs2[1:2],wd,abs2[3])
  names(abwds) <- c("a","b","w","d","s2")
  abwds
}
