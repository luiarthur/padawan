pow_1 <- function(theta,n,alpha=.1,theta_0=0,s=1) {
  t_alpha <- qt(1-alpha, df=n-1)
  pt(t_alpha + sqrt(n) *(theta_0-theta) / s, df=n-1, lower.tail=FALSE)
}

pow_2 <- function(theta,n,alpha=.1,theta_0=0,s=1) {
  t_alpha <- qnorm(1-alpha)
  #pt(t_alpha + sqrt(n) *(theta_0-theta) / s, df=n-1, lower.tail=FALSE)
  pnorm(t_alpha + sqrt(n) *(theta_0-theta) / s, lower.tail=FALSE)
}

xx <- seq(-3,3,len=1000)
plot(xx,pow_1(xx,n=10),type='l',lwd=4,col="red")
lines(xx,pow_1(xx,n=100),type='l',lwd=4,col="red")
lines(xx,pow_1(xx,n=1000),type='l',lwd=4,col="red")


lines(xx,pow_2(xx,n=10),type='l',lwd=4,col="blue",lty=3)
lines(xx,pow_2(xx,n=100),type='l',lwd=4,col="blue",lty=3)
lines(xx,pow_2(xx,n=1000),type='l',lwd=4,col="blue",lty=3)
