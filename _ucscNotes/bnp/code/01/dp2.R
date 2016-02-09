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

rG <- function(n) rnorm(n,0,1)
pG <- function(x) pnorm(x,0,1)

a <- 100
N <- 100
B <- 1000
X <- matrix(0,B,N)
for (i in 1:B) {
  X[i,] <- dp(rG,a,N)
  plot.cdf(X[i,],
           discrete=F,print=F,add=ifelse(i==1,F,T),
           cex=.5,pch=20,
           col=ifelse(i==B,"black",rgb(.5,.5,.5,.2)),
           ylim=c(0,1),xlim=c(-3,3),
           ylab="Fn(x)",xlab="x",main="CDF"
           )
  cat("\r Progress:",i,"/",B)
}

curve(pG,add=T,lwd=2,col="red")
X.sort <- t(apply(X,1,function(r) sort(r)))
X.mean <- apply(X.sort,2,mean)
plot.cdf(X.mean,discrete=F,print=F,add=T,col="blue",lwd=3)

#Linear Interpolation#################
tY <- apply(X.sort,1,function(x) {
               #ux <- sort(unique(x))
               ux <- x
               lux <- length(ux)
               cdf <- double(lux)

               for (i in 1:lux) {
                 if (i>1) cdf[i-1] <- sum(ux[i] > x)
               }

               cdf <- cdf / length(x)
               cdf[lux] <- 1
               cdf
           })
Y <- t(tY)
xout = seq(-4, 4, length = 100)

Z <- matrix(0, B, N)
for (i in 1:B)
  Z[i,] <- approx(X.sort[i,], Y[i,], xout = xout)$y
  #Z[i,] <- approx(unique(X.sort[i,]), Y[[i]], xout = xout)$y
Zmeans = apply(Z, 2, mean, na.rm = TRUE)
lines(xout, Zmeans, col = 'green',lwd=2)
abline(h=.5,lwd=1.5)
