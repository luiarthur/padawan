pow_1 <- function(theta,n,alpha=.1,theta_0=0,s=1) {
  t_alpha <- qt(1-alpha, df=n-1)
  pt(t_alpha + sqrt(n) *(theta_0-theta) / s, df=n-1, lower.tail=FALSE)
}

pow_2 <- function(theta,n,alpha=.1,theta_0=0,s=1) {
  t_alpha <- qnorm(1-alpha)
  pnorm(t_alpha + sqrt(n) *(theta_0-theta) / s, lower.tail=FALSE)
}


theta_0 <- 1
s <- 1
xx <- theta_0 + 1*seq(-s,s,len=1000)

pdf("../output/power.pdf")
plot(xx,pow_1(xx,theta_0=theta_0,s=s,n=10),type='l',lwd=4,col="red",
     ylab="Power",xlab=expression(theta),cex.lab=1.3,
     ylim=c(0,1),xaxt="n",
     main=expression("Power Functions for "~theta[0]~"=0"))
lines(xx,pow_1(xx,theta_0=theta_0,s=s,n=100),type='l',lwd=4,col="red")
lines(xx,pow_1(xx,theta_0=theta_0,s=s,n=1000),type='l',lwd=4,col="red")

lines(xx,pow_2(xx,theta_0=theta_0,s=s,n=10),type='l',lwd=4,col="blue",lty=3)
lines(xx,pow_2(xx,theta_0=theta_0,s=s,n=100),type='l',lwd=4,col="blue",lty=3)
lines(xx,pow_2(xx,theta_0=theta_0,s=s,n=1000),type='l',lwd=4,col="blue",lty=3)

axis(1,at=theta_0+s*c(-1,0,1),lab= c(expression(theta[0]~"-s"),
                                     expression(theta[0]),
                                     expression(theta[0]~"+s")))

#axis(1,at=theta_0,lab=expression(theta[0]))
#axis(1,at=(theta_0-2):(theta_0+2),lab= c(expression(theta[0]~"-2"),
#                                         expression(theta[0]~"-1"),
#                                         expression(theta[0]~""),
#                                         expression(theta[0]~"+1"),
#                                         expression(theta[0]~"+2")))
legend("topleft",c("Power Function for T statistic","Power Function for Z statistic"),
       col=c("red","blue"),lwd=2,bty="n",cex=1)
abline(v=theta_0,col="grey",lwd=2)
abline(h=.1,col="grey",lwd=2)
dev.off()
