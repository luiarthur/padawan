set.seed(205)
life <- read.table("../../dat/lifetime.txt",header=TRUE)
source("permutation.R")
source("../../../../R_Functions/plotPost.R",chdir=TRUE)

X <- life$x
Y <- life$y

#X <- rnorm(100,.2,1)
#Y <- rnorm(100,0,1)

plot(density(Y),col="red",lwd=2)
lines(density(X),col="blue",lwd=2)

perm.mean.diff <- permutation.test(X,Y,mean,B=10000)
mean(mean(X) - mean(Y) <= perm.mean.diff)

# https://en.wikipedia.org/wiki/Resampling_(statistics)
