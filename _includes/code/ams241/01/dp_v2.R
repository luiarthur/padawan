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
dG <- function(x) dnorm(x)

a <- c(1,10,100,1000)
N <- 100
B <- 500
X <- matrix(0,B,N)
list.X <- lapply(as.list(a),function(x) X)

for (l in 1:length(a)) {
  for (i in 1:B) {
    list.X[[l]][i,] <- dp(rG,a[l],N)
    cat("\r Progress: ",i," / ", l)
  }
}

par(mfrow=c(2,2))
h <- c(4,.6,.6,.6)
for (j in 1:length(a)) {
  xl <- list.X[[j]]
  for (i in 1:B) {
    if (i == 1) {
      #plot(density(xl[i,]),xlim=c(-3,3),ylim=c(0,max(unlist(list.X))),
      plot(density(xl[i,]),xlim=c(-3,3),ylim=c(0,h[j]),
           col=rgb(.5,.5,.5,.2),main=paste("a =",a[j]))
    } else {
      lines(density(xl[i,]),xlim=c(-3,3),col=ifelse(i==B,"black",rgb(.5,.5,.5,.2)))
    }
  }
  curve(dG,add=T,lwd=2,col="red")
}; par(mfrow=c(1,1))
