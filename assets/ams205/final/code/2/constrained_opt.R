log_like <- function(lam_1_and_2,x1_and_x2) {
  l1 <- lam_1_and_2[1]
  l2 <- lam_1_and_2[2]
  x1 <- x1_and_x2[,1]
  x2 <- x1_and_x2[,2]
  n <- length(x1)

  out <- NULL

  if (l1 > l2 || l1 < 0 || l2 < 0) {
    out <- -1e8
  } else {
    out <- -n*log(l1*l2) - sum(x1) / l1 - sum(x2) / l2
  }

  out
}

source("../plotmap.R")
xx <- cbind(rep(4,100),rep(1,100))
cost <- function(lams) -log_like(lams,xx)
grid <- expand.grid(seq(.1,5,len=100), seq(.1,5,len=100))
costs <- c(t(apply(grid,1,function(l) log_like(l,xx))))
plotmap(costs,grid,ylab="lam2",xlab="lam1",bks=c(-480,-470))
grid[which.max(costs),]

