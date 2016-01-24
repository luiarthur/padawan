#7
a <- seq(-1,1,len=10000)
f <- function(x) exp(x) - x - 1

par(mar=c(4.2,5,4,1))
plot(a,f(a),col='grey',lwd=3,type='l',bty='n',
     xlab=expression(theta-theta(x)),
     ylab=expression( "L ="~ e^{c(theta-theta(x))} - c(theta-theta(x)) - 1))
lines(a,f(a*.1),lwd=4,type='l',bty='n',col='red')
lines(a,f(a*.5),lwd=4,type='l',bty='n',col='blue')
lines(a,f(a* 1),lwd=4,type='l',bty='n',col='green')
lines(a,f(a* 2),lwd=4,type='l',bty='n',col='orange')
