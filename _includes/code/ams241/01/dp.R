source("../../../../assets/R_Functions/colorUnderCurve.R")
N <- 1000 # number of observations?
a <- 10 # alpha
rG <- function(n) rgamma(n,3,scale=3)
dG <- function(x) dgamma(x,3,scale=3)
#rG <- function(n) rbeta(n,2,3)
#dG <- function(x) dbeta(x,2,3)
#rG <- function(n) rnorm(n,0,1)
#dG <- function(x) dnorm(x,0,1)
#rG <- function(n) rpois(n,20)
#dG <- function(x) dpois(x,20)

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
  hist(rG(1e6),freq=F,add=F,col="grey",border="white",xlab="x",
       ylab="Probability",main="",breaks=min(length(unique(x))*2,30))
  lines(table(x) / sum(table(x)) ,col="blue")
#par("mar"=pmar); dev.off()
