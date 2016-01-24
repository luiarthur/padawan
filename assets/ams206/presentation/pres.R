#7
a <- seq(-3,3,len=10000)
f <- function(x) exp(x) - x - 1

pdf("img/fig1.pdf")
par(mar=c(4.2,5,1,1))
plot(a,f(a),col='grey',lwd=3,type='l',bty='n',
     xlab=expression(theta-theta(x)),
     ylab=expression( "L ="~ e^{c(theta-theta(x))} - c(theta-theta(x)) - 1))
lines(a,f(a*.1),lwd=3,type='l',bty='n',col='red')
lines(a,f(a*.5),lwd=3,type='l',bty='n',col='blue')
lines(a,f(a* 1),lwd=3,type='l',bty='n',col='grey')
lines(a,f(a* 2),lwd=3,type='l',bty='n',col='green')
legend("topleft",legend=(paste0("c = ",c(2,1,.5,.1))),bty='n',
       col=c('green','grey','blue','red'),lwd=3,cex=1.5)

dev.off()
