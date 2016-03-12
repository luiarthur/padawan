source("1.R")
## Computation: ######################
#mle <- 1.97, -1.50, 1.75, 3.10, .0198


h <- function(x,par=mle) {
  hi <- function(xi) {
    par[1] + par[2] * cos(par[3]*xi + par[4])
  }

  out <- NULL
  if (length(x) == 1) {
    out <- hi(x)
  } else {
    out <- sapply(x,hi)
  }

  names(out) <- NULL
  out
}


bootstrap <- function(par,B=100,x=orb$X) {
  out <- matrix(0,B,length(par))
  out[1,] <- par
  for (i in 2:B) {
    dat <- gen_from_mle(out[i-1,],x)
    mle_wd <- optim(out[i-1,3:4],fn=function(o) -profile_like(o,dat[,1],dat[,2]))$par
    out[i,] <- all_mle_from_wd(mle_wd)
    cat("\r",i,"/",B)
  }
  cat("\n")
  out
}

mle_boot <- bootstrap(mle,B=1000)
ci <- t(apply(mle_boot,2,function(o) quantile(o,c(.025,.975))))
ci[3:4,]
