# 2
phi <- function(x) x^2 * cos(x/2)
phi_even <- function(x) phi(x)
phi_odd <- function(x) ifelse(x > 0, phi(x), -phi(-x))

fs <- function(x,N=1e4) {
  n <- 1:N
  if (length(x) == 1) {
    sum( (3*n / (4*pi) + 2*n^3 / pi - 4*pi/n) * sin(n*x) )
  } else {
    J <- length(x)
    apply(matrix(1:J),1,function(j)
      sum( (3*n / (4*pi) + 2*n^3 / pi - 4*pi/n) * sin(n*x[j]) )
    )
  }
}


par(mfrow=c(2,1))
curve(phi_even(x),from=-pi,to=pi,main="Evem Extension",lwd=3)
curve(phi_odd(x),from=-pi,to=pi,main="Odd Extension",lwd=3)
curve(fs(x),from=-pi,to=pi,add=T,col="red",lwd=1)
par(mfrow=c(1,1))

