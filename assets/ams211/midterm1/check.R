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
cyl.price.cm2 <- 50 / 100^2 # $ / cm^2
cap.price.cm2 <- 75 / 100^2 # $ / cm^2

h <- function(r)  V / (pi*r^2)
r.grid <- seq(.1,20,by=.001)
cost <- function(r) pi*r^2 * cap.price.cm2 * 2 + 2*pi*r*h(r)  * cyl.price.cm2

ind.min <- which.min(cost(r.grid))
r.best <- r.grid[ind.min]
r.best
h(r.best)
cost(r.best)

r.ans <- ( 200 / (3*pi) ) ^ (1/3)
h.ans <- ( 1800 / pi ) ^ (1/3)
cost.ans <- pi * r.ans * (.015*r.ans + .01*h.ans)

result <- matrix(c(r.best,r.ans,
                   h(r.best),h.ans,
                   cost(r.best),cost.ans),ncol=2,byrow=T)
colnames(result) <- c("estimate", "solution")
plot(r.grid,cost(r.grid),type='l')
# check:
pi* r.ans^2 * h.ans - V < 1e-10

result

(deriv <- (.03*r.ans + .01*h.ans) / (2*r.ans*h.ans) + .01 / r.ans)

# 4
A <- matrix(c(1,1,2,1,2,1,2,1,1),3,byrow=T)
eig <- eigen(A)

S <- matrix(c(c(1,1,1)/sqrt(3),
              c(1,-2,1)/sqrt(6),
              c(1,0,-1)/sqrt(2)),3)
D <- diag(c(4,1,-1))
S %*% D %*% t(S)
