set.seed(205)
life <- read.table("../../dat/lifetime.txt",header=TRUE)
source("permutation.R")
source("../../../../R_Functions/plotPost.R",chdir=TRUE)

X <- life$x
Y <- life$y
N <- length(Y)

#plot(density(Y),col="red",lwd=2)
#lines(density(X),col="blue",lwd=2)

perm.mean.diff <- permutation.test(X,Y,mean,B=10000)
(p_val_perm <- mean(mean(X) - mean(Y) <= perm.mean.diff)) # p-val: .03 < .05 => mean(X) > mean(Y)

# https://en.wikipedia.org/wiki/Resampling_(statistics)
# http://stats.stackexchange.com/questions/81151/likelihood-ratio-for-two-sample-exponential-distribution

z_stat_wald <- (mean(X) - mean(Y)) / sqrt( (var(X) + var(Y))/N )
(p_val_wald <- pnorm(z_stat_wald,lower=FALSE))


#l <- seq(1e-3,10,len=100)
#plot(l,dexp(.1,rate=1/l),type='l')
#lines(l,dexp(.5,rate=1/l),type='l')
#lines(l,dexp(1,rate=1/l))
#lines(l,dexp(2,rate=1/l))
#lines(l,dexp(5,rate=1/l))

lrt <- mean(Y) / mean(X)
(p_val_LRT <- pf(lrt, 2*N, 2*N, lower.tail=TRUE))
