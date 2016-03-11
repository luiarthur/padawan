life <- read.table("../../dat/lifetime.txt",header=TRUE)
X <- life$x
Y <- life$y

plot(density(Y),col="red",lwd=2)
lines(density(X),col="blue",lwd=2)
