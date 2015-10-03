color.btwn <- function(x,ylo,yhi,from,to,col.area="grey") {
  x <- c(x,rev(x))
  y <- c(yhi,rev(ylo))

  polygon(c(x[x>=from & x<= to]),
          c(y[x>=from & x<=to]),
          col=col.area,border=F)
}

rdir <- function(N,a) {
  k <- length(a)
  x <- matrix(rgamma(k*N, a, 1), N, k, byrow=T)
  rowsums <- x %*% rep(1,k)
  x / as.vector(rowsums)
}

# Using the dirichlet distribution from gamma's
dp <- function(N=1,pG,a,xlim=c(0,1),n=1000) {
  x <- seq(xlim[1],xlim[2],length=n)
  x <- sort(c(-1e1000,x))
  dG0 <- pG(x[-1]) - pG(x[-length(x)])
  out <- rdir(N,a*dG0)
  G <- t(apply(out,1,cumsum))
  list("G"=G, "x"= x[-1])
}

### Plotting Function
dp.post <- function(X,...) {
  plot(0,xlim=range(X$x),ylim=c(0,1),cex=0,...)
  for (i in 1:nrow(X$G)) {
    lines(X$x,X$G[i,],type="l",col=rgb(.4,.4,.4,.1))
  }
}

# Posterior Simulation ################
# y_i | G ~ G
# G ~ DP(G_0,a)
n1 <- 1*5 
n2 <- 2*5
n <- n1+n2
y <- c(rgamma(n1,4,2),rgamma(n2,2,3))
pT <- function(x) (n1*pgamma(x,4,2) + n2*pgamma(x,2,3)) / n

# Gibbs
B <- 1000 # Big number for MCMC
k <- 100 # Number of obs for each DP draw, should be LARGE
alpha <- 10 # Later, put a prior. Large => More faith in prior.
pG <- function(x) pnorm(x,2,2)
pG1 <- function(x) {
  s <- sapply(x,function(w) sum(w >= y))
  (alpha * pG(x) +  s) / (alpha + n)
}
# Draw from G | y
G <- dp(N=B,pG1,a=alpha+n,xlim=c(-10,10),n=k)
EG <- apply(G$G,2,mean)

#pdf("~/temp/pdf/dp_post.pdf")
png("../../../../assets/ams241/03/plots/dp_post.png")
  #dp.post(G,xlab='y',ylab="Fn(y)")
  plot(0,cex=.001,ylim=c(0,1),xlim=c(-10,10),main=paste("alpha =",alpha),
       ylab="Fn(y)",xlab="y")
  lines(ecdf(y),cex=.5)
  curve(pG,add=T,col="red",lwd=3)
  lines(G$x,EG,col=rgb(0,0,1,.3),lwd=10)
  curve(pT,add=T,col="green",lwd=3)
  legend("bottomright",
         legend=c('Truth','Data','G0','Posterior:\n 95% C.I.','E[G|y]',''),
         col=c('green','black','red','grey','blue',rgb(0,0,0,0)),lwd=3)
  qG <- apply(G$G,2,function(x) quantile(x,c(.025,.5,.975)))
  #apply(qG,1,function(x) lines(G$x,x))
  glo <- qG[1,]
  ghi <- qG[3,]
  color.btwn(G$x,glo,ghi,-100,100,col.area=rgb(.2,.2,.2,.5))
dev.off()

#source("dp_posterior.R")
