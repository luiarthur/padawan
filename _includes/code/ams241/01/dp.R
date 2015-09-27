N <- 50 # number of observations?
a <- 5 # alpha
# X_i ~ G = Normal(0,1)

rG <- function() rnorm(1)

x <- rep(0,N)
x[1] <- rG()

for (i in 2:N) {
  nx <- table(x[1:(i-1)])
  x[i] <- as.numeric(sample(c(rG(),names(nx)),1,prob=c(a/(a+N-1),nx/(a+N-1))))
  cat("\r Progress: ",i,"/",N)
}

# Plot Results
hist(rnorm(1e6),freq=F,add=F,col="lightgrey",border="white",xlab="x",
     ylab="Probability", xlim=c(-4,4),ylim=c(0,.4),main="")
curve(dnorm(x),add=T,col="grey",lwd=2)
lines(table(x) / sum(table(x)) ,col="blue")
