source("1.R")
## Computation: ######################
#mle <- 1.97, -1.50, 1.75, 3.10, .0198

Y <- orb$Y
X <- orb$X
a <- mle[1]
b <- mle[2]
w <- mle[3]
d <- mle[4]
s2 <- mle[5]

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

l_ww <- sum(  b*X^2*(cos(X*w+d)*(Y-h(X)) - b*sin(X*w+d)^2)  ) / s2
I_w <- -l_ww
se_w <- 1/sqrt(I_w)
(ci_w <- qnorm(c(.025,.975),w,se_w))

l_dd <- sum(  b*cos(X*w+d)*(Y-h(X)) - b^2*sin(X*w+d)^2  )  / s2
I_d <- -l_dd
se_d <- 1/sqrt(I_d)
(ci_d <- qnorm(c(.025,.975),d,se_d))

opt <- optim(c(w,d),fn=function(x) -profile_like(x), hessian=TRUE)
se_wd <- 1 / sqrt(opt$hessian)[c(1,4)]

qnorm(c(.025,.975),w,se_wd[1])
qnorm(c(.025,.975),d,se_wd[2])
