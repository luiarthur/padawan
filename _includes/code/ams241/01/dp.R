N <- 100 # number of observations?
a <- 10 # alpha
# X_i ~ G = Normal(0,1)

rG <- function(num) rgamma(num,3,3)
#rG <- function(num) rbeta(num,2,3)
#rG <- function(num) rnorm(num,0,1)
#rG <- function(num) rpois(num,30)


x <- rep(0,N)
x[1] <- rG(1)

for (i in 2:N) {
  nx <- table(x[1:(i-1)])
  x[i] <- as.numeric(sample(c(rG(1),names(nx)),1,prob=c(a/(a+N-1),nx/(a+N-1))))
  cat("\r Progress: ",i,"/",N)
}

# Plot Results
hist(rG(1e6),freq=F,add=F,col="lightgrey",border="white",xlab="x",
     ylab="Probability",main="")#, xlim=c(-4,4),ylim=c(0,.4))
lines(table(x) / sum(table(x)) ,col="blue")
