source("cdf.R")
# Polya Urn construction:
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

make.plot <- function(a,N,B,rG,pG,col.a=.2,plot.main) {
  X <- matrix(0,B,N)
  for (i in 1:B) {
    X[i,] <- dp(rG,a,N)
    plot.cdf(X[i,],
             discrete=F,print=F,add=ifelse(i==1,F,T),
             cex=.5,pch=20,
             col=ifelse(i==B,"black",rgb(.5,.5,.5,col.a)),
             ylim=c(0,1),xlim=c(-3,5),
             ylab="Fn(x)",xlab="x",main=plot.main
             )
    cat("\r Progress:",i,"/",B)
  }

  curve(pG,add=T,lwd=2,col="red")
  X.sort <- t(apply(X,1,function(r) sort(r)))
  X.mean <- apply(X.sort,2,mean)
  plot.cdf(X.mean,discrete=F,print=F,add=T,col="blue",lwd=2)
  legend("bottomright",legend=c("Random draws from the DP",
                                "A particular draw from the DP",
                                "G0","E[G]"),
         bty="n",col=c("darkgrey","black","red","blue"),lwd=3)
}


#png("../../../../assets/ams241/01/plots/dp_compare.png",1000,400);
par(mfrow=c(1,3))
  rG <- function(n) rnorm(n,0,1)
  pG <- function(x) pnorm(x,0,1)
  make.plot(a=1,N=100,B=100,rG,pG,col.a=.4,plot.main="a = 1")
  make.plot(a=10,N=100,B=100,rG,pG,col.a=.4,plot.main="a = 10")
  make.plot(a=100,N=100,B=100,rG,pG,col.a=.4,plot.main="a = 100")
par(mfrow=c(1,1))
#dev.off();
