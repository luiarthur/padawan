source("cdf.R")

dp <- function(rG,a,N=100,printProg=F) {
  x <- rep(0,N)
  x[1] <- rG(1)

  for (i in 2:N) {
    nx <- table(x[1:(i-1)])
    xs <-    c(     rG(1),  names(nx) ) 
    probs <- c( a/(a+N-1), nx/(a+N-1) )
    x[i] <- as.numeric( sample(xs, 1, prob=probs) )
    if (printProg) cat("\r Progress: ",i,"/",N)
  }

  x
}

rG <- function(n) rnorm(n)

a <- 3
N <- 100
plot.cdf(dp(rG,a,N),discrete=F,print=F,cex=.5,pch=20,
         col=rgb(.5,.5,.5,1),ylim=c(0,1),xlim=c(-3,3))
for (i in 1:1000) {
  plot.cdf(dp(rG,a,N),discrete=F,print=F,add=T,cex=.5,pch=20,
           col=rgb(.5,.5,.5,.1))
  cat("\r Progress:",i,"/",1000)
}

curve(pnorm,add=T,lwd=2,col="red")
