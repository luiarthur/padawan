source("../../../../assets/R_Functions/colorUnderCurve.R")
N <- 1000 # number of observations?
a <- 10 # alpha
rG <- function(n) rgamma(n,3,scale=3)
pG <- function(x) pgamma(x,3,scale=3)
#rG <- function(n) rbeta(n,2,3)
#pG <- function(x) pbeta(x,2,3)
#rG <- function(n) rnorm(n,0,1)
#pG <- function(x) pnorm(x,0,1)
#rG <- function(n) rpois(n,20)
#pG <- function(x) ppois(x,20)

x <- rep(0,N)
x[1] <- rG(1)

for (i in 2:N) {
  nx <- table(x[1:(i-1)])
  xs <-    c(     rG(1),  names(nx) ) 
  probs <- c( a/(a+N-1), nx/(a+N-1) )
  x[i] <- as.numeric( sample(xs, 1, prob=probs) )
  cat("\r Progress: ",i,"/",N)
}

# Plot Results
#png("../../../../assets/ams241/01/plots/dp_gamma.png"); pmar <- par("mar")
#par("mar"=c(4,4,1,0))
#par(mfrow=c(1,2))
#  hist(rG(1e6),freq=F,add=F,col="grey",border="white",xlab="x",
#       ylab="Probability",main="",breaks=min(length(unique(x))*2,30))
#  lines(table(x) / sum(table(x)) ,col="blue")
  
  plot(ecdf(x),col=rgb(0,.2,.5),main="")
  G0 <- rG(1000)
  if (length(unique(rG(1000))) < length(G0) *.9) {
    points(pG(0:100),pch=20,col=rgb(.5,.5,.5,.5),cex=1.5)
  } else {
    curve(pG,main="",col=rgb(.5,.5,.5),lwd=2,add=T)
  }
  legend("bottomright",legend=c("G_0",paste0("DP(G_0, ",a,")"),""),
         text.col=c(rgb(.1,.1,.1),rgb(0,.2,.5),rgb(0,0,0,0)),bg="orange")
#par(mfrow=c(1,1))
#par("mar"=pmar); dev.off()
