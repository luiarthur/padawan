pow_1 <- function(theta,n,alpha=.1,theta_0=0,s=1) {
  t_alpha <- qt(1-alpha, df=n-1)
  pt(t_alpha + sqrt(n) *(theta_0-theta) / s, df=n-1, lower.tail=FALSE)
}

sapply(2:100,function(n) pow_1(0+1,n,.05))

pow_2 <- function(theta,n,alpha=.1,theta_0=0,s=1) {
  t_alpha <- qnorm(1-alpha)
  #pnorm(t_alpha + sqrt(n) *(theta_0-theta) / s, lower.tail=FALSE)
  pt(t_alpha + sqrt(n) *(theta_0-theta) / s, df=n-1,lower.tail=FALSE)
}


theta_0 <- 1
s <- 1
xx <- theta_0 + 1*seq(-s,s,len=1000)

pdf("../output/power.pdf")
plot(xx,pow_1(xx,theta_0=theta_0,s=s,n=10),type='l',lwd=4,col="red",
     ylab=expression(beta(theta)),xlab=expression(theta),cex.lab=1.1,
     ylim=c(0,1),xaxt="n",
     main=expression("Power Functions"))
lines(xx,pow_1(xx,theta_0=theta_0,s=s,n=100),type='l',lwd=4,col="orange")
lines(xx,pow_1(xx,theta_0=theta_0,s=s,n=1000),type='l',lwd=4,col="yellow")

lines(xx,pow_2(xx,theta_0=theta_0,s=s,n=10),type='l',lwd=4,col="cadetblue",lty=3)
lines(xx,pow_2(xx,theta_0=theta_0,s=s,n=100),type='l',lwd=4,col="green",lty=3)
lines(xx,pow_2(xx,theta_0=theta_0,s=s,n=1000),type='l',lwd=4,col="black",lty=3)

axis(1,at=theta_0+s*c(-1,0,1),lab= c(expression(theta[0]~"-s"),
                                     expression(theta[0]),
                                     expression(theta[0]~"+s")))

#axis(1,at=theta_0,lab=expression(theta[0]))
#axis(1,at=(theta_0-2):(theta_0+2),lab= c(expression(theta[0]~"-2"),
#                                         expression(theta[0]~"-1"),
#                                         expression(theta[0]~""),
#                                         expression(theta[0]~"+1"),
#                                         expression(theta[0]~"+2")))
legend("topleft",c("Power Function for T (n=10)",
                   "Power Function for Z (n=10)",
                   "Power Function for T (n=100)",
                   "Power Function for Z (n=100)",
                   "Power Function for T (n=1000)",
                   "Power Function for Z (n=1000)"),
       col=c("red","cadetblue","orange","green","yellow","black"),lwd=3,bty="n",cex=1)
abline(v=theta_0,col="grey",lwd=2)
abline(h=.1,col="grey",lwd=2)
dev.off()

