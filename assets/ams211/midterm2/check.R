# 2
phi <- function(x) x^2 * cos(x/2)
phi_even <- function(x) phi(x)
phi_odd <- function(x) ifelse(x > 0, phi(x), -phi(-x))

B <- function(n,d,x) {
  ( cos(d*x) * (2-(d*d*x*x)) + 2*(d*x)*sin(d*x) ) / (d^3 * 2*pi)
}

bn <- function(n) {
  a <- .5 + n
  b <- .5 - n
  B(n,a,-pi) - B(n,b,-pi) - B(n,a,0) + B(n,b,0) +
  B(n,a,pi) - B(n,b,pi) - B(n,a,0) + B(n,b,0)
}

fs <- function(x,N=1e5) {
  n <- 1:N
  #Bn <- bn(n)
  a <- .5 + n
  b <- .5 - n
  Bn <- 2*( (a^-2 - b^-2)*(-1)^n - (a^-3 - b^-3)/pi )

  if (length(x) == 1) {
    sum( Bn * sin(n*x) )
  } else {
    J <- length(x)
    apply(matrix(1:J),1,function(j)
      sum( Bn * sin(n*x[j]) )
    )
  }
}


par(mfrow=c(3,1))
curve(phi_even(x),from=-pi,to=pi,main="Evem Extension",lwd=3)
curve(phi_odd(x),from=-pi,to=pi,main="Odd Extension",lwd=5,col="grey")
curve(fs(x,N=3),add=T,col="blue",lwd=5,lty=3)
curve(fs(x,N=3),from=-3*pi,to=3*pi,col="blue",lwd=5,lty=3,main="Extensions")
par(mfrow=c(1,1))

#1 
#x^(2/3) + 9y^(2/3) = 4
B <- 1e6
x <- runif(B,-10,10)
y <- runif(B,-1,1)

ind <- which( (x^2)^(1/3) + 9*(y^2)^(1/3) <= 4 )
# ((4 - (x^2)^(1/3)) / 9)^(3/2)
plot(x[ind],y[ind],pch=20)
# https://www.desmos.com/calculator

#5
z <- 13/20
5*z ^5 +z^2 + z
