set.seed(1)
x <- rpois(10,2)
ux <- sort(unique(x))
lux <- length(ux)
cdf <- matrix(0,lux,2)

for (i in 1:lux) {
  cdf[i,1] <- ux[i]
  if (i>1) cdf[i-1,2] <- sum(ux[i] > x)
}

cdf[,2] <- cdf[,2] / length(x)
cdf[lux,2] <- 1
cdf

plot(ecdf(x))
plot(cdf[,1],cdf[,2])
