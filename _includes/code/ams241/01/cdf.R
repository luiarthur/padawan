set.seed(1)

plot.cdf <- function(x,discrete=T,...) {
  ux <- sort(unique(x))
  lux <- length(ux)
  cdf <- matrix(0,lux,2)

  for (i in 1:lux) {
    cdf[i,1] <- ux[i]
    if (i>1) cdf[i-1,2] <- sum(ux[i] > x)
    cat("\r Progress: ",i,"/",lux)
  }
  cat("\n")

  cdf[,2] <- cdf[,2] / length(x)
  cdf[lux,2] <- 1

  plot(cdf[,1],cdf[,2],type=ifelse(discrete,"p","l"),...)
}

y <- rnorm(1e3,20)
plot.cdf(y,pch=20,discrete=T)
