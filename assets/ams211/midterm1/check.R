# 3 
A <- matrix(c(3,2,2,3,2,-2),2)
tA <- t(A)

svd(A)

# 2
B <- 1e4
R <- 2
x <- runif(B,-R,R)
y <- runif(B,-R,R)
z <- runif(B,-R,R)
r <- sqrt(x^2 + y^2 + z^2)
ind <- r < R

mean.r <- mean(r[ind])
plot(x[ind],y[ind],col=rgb(.3,.3,.5,.5),pch=20,
     main=paste0("R=",R,", mean=",round(mean.r/R,3),"R"))

#Ans = .75R

# 1.
V <- 200 #cm3
S <- 50 / 100^2
