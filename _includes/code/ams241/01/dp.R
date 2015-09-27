N <- 1000 # number of observations?
a <- 3 # alpha

rG <- function(num) rgamma(num,3,scale=3)
#rG <- function(num) rbeta(num,2,3)
#rG <- function(num) rnorm(num,0,1)
#rG <- function(num) rpois(num,4)

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
  hist(rG(1e6),freq=F,add=F,col="lightgrey",border="white",xlab="x",
       ylab="Probability",main="")
  lines(table(x) / sum(table(x)) ,col="blue")
#par("mar"=pmar); dev.off()
