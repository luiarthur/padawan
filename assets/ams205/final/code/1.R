source("likeprofile.R")
system("mkdir -p output")
#mle <- 1.97, -1.50, 1.75, 3.10, .0198

## Explore
wd <- expand.grid(seq(1.5,2,len=100), seq(.001,2*pi,len=100))
like_wd <- t(apply(wd,1,function(xx) profile_like(xx)))
plotmap(like_wd,wd,ylab="delta",xlab="w")

## Compare
init_grid <- expand.grid(seq(1,5,len=10), seq(.01,2,len=10))
init_grid <- expand.grid(seq(1,5,len=10), seq(.01,2*pi,len=10))

# 41 seconds
system.time(init_likes <- t(apply(init_grid,1, function(init) {
      opt <- optim(init,fn=function(x) -profile_like(x),hessian=TRUE)
      c(opt$val,opt$par)
})))
top_ten <- init_likes[order(init_likes[,1]),][1:10,]
colnames(top_ten) <- c("log_like","w","d")
unique(round(top_ten,4))

(optim_result <- top_ten[1,])
(mle <- all_mle_from_wd(optim_result[-1]))


pred <- function(par,x=orb$X) par[1] + par[2] * cos(par[3]*x + par[4])
gen_from_mle <- function(n,par,x=seq(0,12,len=100)) cbind(x,rnorm(n,pred(par,x),sqrt(par[5])))

xx <- seq(range(orb$X)[1],range(orb$X)[2],len=1000)
plot(orb$X,orb$Y,pch=20,type="p",col="black",cex=2)
points(gen_from_mle(1000,mle),pch=20,col="lightblue",lwd=3)
lines(xx,pred(mle,xx),pch=20,col="red",lwd=3)
#mle <- 1.97, -1.50, 1.75, 3.10, .0198

#################

