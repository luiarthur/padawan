plot.cdf <- function(x,discrete=T,add=F,printProgress=T,...) {
  ux <- sort(unique(x))
  lux <- length(ux)
  cdf <- matrix(0,lux,2)

  for (i in 1:lux) {
    cdf[i,1] <- ux[i]
    if (i>1) cdf[i-1,2] <- sum(ux[i] > x)
    if (printProgress) cat("\r Progress: ",i,"/",lux)
  }
  if (printProgress) cat("\n")

  cdf[,2] <- cdf[,2] / length(x)
  cdf[lux,2] <- 1

  if (add) {
    lines(cdf[,1],cdf[,2],type=ifelse(discrete,"p","l"),...)
  } else {
    plot(cdf[,1],cdf[,2],type=ifelse(discrete,"p","l"),...)
  }
}

# Example:
#plot.cdf(rnorm(2e4),col="black",discrete=F,lwd=3)
#for (i in 1:1000) {
#  plot.cdf(rnorm(1e2),col=rgb(.5,.5,.5,.1),cex=.5,pch=20,add=T,print=F)
#  cat("\r Progress: ",i,"/",1000)
#}
