library(MCMCpack)

rdir <- function(N,a) {
  k <- length(a)
  x <- matrix(rgamma(k*N, a, 1), N, k, byrow=T)
  rowsums <- x %*% rep(1,k)
  x / as.vector(rowsums)
}

dp <- function(N=1,pG,a,xlim=c(0,1),n=1000) {
  x <- seq(xlim[1],xlim[2],length=n)
  x <- sort(c(-1e1000,x))
  dG0 <- pG(x[-1]) - pG(x[-length(x)])
  out <- rdir(N,a*dG0)
  G <- t(apply(out,1,cumsum))
  list("G"=G, "x"= x[-1])
}

########
N <- 1000
a <- 100
xlim <- c(-3,3)
n <- 10
pG <- function(x) pnorm(x)

X <- dp(N=N,pG=pG,a=a,xlim=xlim,n=n)
plot(0,xlim=range(X$x),ylim=c(0,1),cex=0)
for (i in 1:nrow(X$G)) {
  lines(X$x,X$G[i,],type="l",col=rgb(.4,.4,.4),lwd=.1)
}
curve(pnorm,add=T,col="darkred",lwd=3)
EG <- apply(X$G,2,mean)
lines(X$x,EG,col="blue",lwd=3)
