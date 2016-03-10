orb <- read.table("../dat/orbits.txt",header=TRUE)
#orb$Y <- (orb$Y - mean(orb$Y)) / sd(orb$Y)
#orb$X <- (orb$X - mean(orb$X)) / sd(orb$X)

lf <- function(y,x,a,b,w,d,s2) {
  out <- NULL
  if (s2 > 0) {
    mu <- a+b*cos(w*x+d)
    n <- length(y)
    out <- -n*log(s2)/2 -sum((y-mu)^2)/(2*s2) 
    #out <- -sum((y-mu)^2)/(2*s2) 
  } else {
    out <- -Inf
  }
  out
}

Q <- lf_cost <- function(par) {
  a <- par[1]
  b <- par[2]
  w <- par[3]
  d <- par[4]
  s2 <- par[5]
  -lf(orb$Y,orb$X,a,b,w,d,s2)
}

mle <- optim(c(2,-1.3,1.8,-10,.04),fn=lf_cost,hessian=TRUE) #1.97,-1.29, 1.79, -9.69, 8.05
mle$par

rf <- function(par,x=orb$X) {
  n <- length(x)
  a <- par[1]
  b <- par[2]
  w <- par[3]
  d <- par[4]
  s2 <- par[5]

  mu <- a+b*cos(w*x+d)
  #rnorm(n,mu,s2)
  mu
}

#source("sgd.R"); sgd_mle <- sgd(orb$X,orb$Y,100,.1,init=mle$par); rbind(sgd_mle,mle$par)

xx <- seq(range(orb$X)[1],range(orb$X)[2],len=1000)
plot(orb$X,orb$Y,pch=20,type="p",col="grey",cex=2)
lines(xx,rf(mle$par,xx),pch=20,col="red",lwd=3)
#lines(xx,rf(sgd_mle,xx),pch=20,col="blue")


