# 3-4 minutes run-time:
# X - Longitude
# Y - Latitude

rm(list=ls())
library(LatticeKrig)
library(geoR)
library(maps)
library(xtable)

CMAQ  <- read.csv("cmaq.csv")       # 66960 x 4
O3    <- read.csv("ozone.csv")      #   800 x 6
predL <- read.csv("PredLocs.csv")   #  2834 x 4

quilt.plot(CMAQ$lon,CMAQ$lat,CMAQ$cmaq)
map('state',add=T)

plot.O3 <- function(main="") {
  quilt.plot(c(O3$lon,-110),c(O3$lat,50),c(O3$ozone,50),main=main)
  map('state',add=T)
}  

plot.CMAQ <- function(main="") {
  quilt.plot(CMAQ$lon,CMAQ$lat,CMAQ$cmaq,main=main)
  map('state',add=T)
}

#GP: #####################################################################
GP <- function(o3=O3,cmaq=CMAQ,pred=cbind(predL$X,predL$Y),
               nu=2,init=c(c(var(o3$ozone),.001)),X1.col=10){

  find.X1 <- function(DD,k=X1.col) {

    print(paste("Finding",k,"closest columns"))
    find.smallest.i <- function(one.row) {
      Ind <- NULL
      max.val <- max(one.row)+1
      for (i in 1:k){
        Ind[i] <- which.min(one.row)
        one.row[Ind[i]] <- max.val
      }
      Ind
    }

    weighted.ave <- function(one.row) {
      k <- length(one.row)
      (1 - one.row/sum(one.row)) %*% one.row /k
    }

    find.x1 <- function(one.row) {
      ind <- find.smallest.i(one.row)
      #weighted.ave(cmaq$CMAQ[ind]) # method 1
      cmaq$cmaq[ind] # method 2
    }

    #library(foreach)
    #library(doMC)
    #registerDoMC(10)
    #X1 <- foreach(i=1:nrow(DD),.combine=rbind) %dopar% find.x1(DD[i,])

    do.one <- function(y) rbind(find.x1(y,X1.col))
    X1 <- t(apply(DD,1,find.x1))
    X1
  }  
  
  N <- nrow(o3)
  coord <- cbind(o3$lo,o3$la)
  Y <- o3$ozone
  print("rdist is executing")
  D.X1 <- rdist(coord,cmaq[,1:2])
  X1 <- find.X1(D.X1)
  X <- cbind(1,X1)

  dat <- cbind(Y,X1,coord)
  obs <- as.geodata(dat,data.col=1,coords.col=(ncol(dat)-1):ncol(dat))
  gp.fit <- likfit(obs,cov.model="matern",kappa=nu,fix.kappa=TRUE,
                   ini.cov.pars=init,trend=~X1) # Takes 2 minutes

  phi <- 1/gp.fit$phi
  s2 <- gp.fit$sigmasq
  b.hat <- gp.fit$beta
  tau2 <- gp.fit$tausq
  mu.1 <- X %*% b.hat


  # Predictions:
  K <- nrow(pred)
  print("rdist is executing")
  D <- rdist(rbind(as.matrix(pred),as.matrix(coord)))

  print("rdist is executing")
  DD <- rdist(pred,cmaq[,1:2])
  x1 <- find.X1(DD)
  x  <- cbind(1,x1)
  mu.2 <-  x %*% b.hat

  print("Computing V with Matern")
  V <- s2*Matern(D,alpha=phi,nu=nu) #V = Sigma_Y
  print("Computing E[Y|X]. Heavy matrix inverting.")
  EV <- mu.2 + V[1:K,K+(1:N)] %*% solve(V[K+(1:N),K+(1:N)]+tau2*diag(N)) %*% (Y-mu.1)
  print("Computing var[Y|X]. Heavy matrix inverting.")
  cond.Var <- diag((V[1:K,1:K]+tau2*diag(K))-V[1:K,K+(1:N)] %*% 
              solve(V[K+(1:N),K+(1:N)] + tau2*diag(N))%*%t(V[1:K,K+(1:N)]))

  upper <- qnorm(0.975,mean=EV,sd=sqrt(cond.Var))
  lower <- qnorm(0.025,mean=EV,sd=sqrt(cond.Var))

  print("Completed a Gaussian Process! :)")
  list("gp.fit"=gp.fit,"prediction"=EV,"upper"=upper,"lower"=lower)
}

#Main: #####################################

result <- GP(X1.col=10)
center <- result$pred  
upper  <- result$upper
lower  <- result$lower

plot.pred <- function(pred,main="",predl=predL) {
  quilt.plot(predl$X,predl$Y,pred,main=main)
  map('state',add=T)
}

# Comparison of upper, center, and lower: ########
plot.prediction <- function(){
  par(mfrow=c(3,1))
    plot.pred( upper,"Predicted OZone Levels Upper")
    plot.pred(center,"Predicted OZone Levels")
    plot.pred( lower,"Predicted OZone Levels Lower")
  par(mfrow=c(1,1))
}
##################################################

# Comparison of CMAQ, O3, and Prediction: ########
plot.compare.methods <- function(){
  par(mfrow=c(3,1))
    plot.CMAQ("CMAQ")
    plot.pred(center,"Predicted")
    plot.O3("OZone")
  par(mfrow=c(1,1))
}
##################################################

# Compare All: ###################################
plot.all <- function(){
  par(mfrow=c(3,2))
    plot.pred( upper,"Predicted OZone Levels Upper")
    plot.CMAQ("CMAQ Ozone")
    plot.pred(center,"Predicted OZone Levels")
    plot.pred(center,"Predicted OZone Levels")
    plot.pred( lower,"Predicted OZone Levels Lower")
    plot.O3("Directly Measured OZone")
  par(mfrow=c(1,1))
}

pdf("../latex/raw/cmaq.pdf");plot.CMAQ("CMAQ Ozone");dev.off()
pdf("../latex/raw/center.pdf");plot.pred(center,"Predicted OZone Levels");dev.off()
pdf("../latex/raw/lower.pdf");plot.pred( lower,"Predicted OZone Levels Lower");dev.off()
pdf("../latex/raw/upper.pdf");plot.pred( upper,"Predicted OZone Levels Upper");dev.off()
pdf("../latex/raw/ozone.pdf");plot.O3("Directly Measured OZone");dev.off()
pdf("../latex/raw/all.pdf");plot.all();dev.off()

# Need: 
#   1) Residuals: Done
#   2) Coverage: Run
#   3) Interpret

# 1) Residuals:
   resids <- result$gp.fit$model.components$residuals

   #1:
   pdf("../latex/raw/resids.pdf")
     plot(resids,pch=20,main="Residuals")
   dev.off()

   #2: # Looks like a Cauchy / Laplace
   pdf("../latex/raw/hist.pdf")
     hist(resids,col='gold',30,freq=F,main="Histogram of Residuals",xlab="Residuals")
     lines(density(rnorm(1000000,sd=1:7)),col='blue',lwd=3)
     legend("topleft",legend="Normal(0,V)",col="blue",lwd=3)
   dev.off()

   #3:
   pdf("../latex/raw/qqnorm.pdf")
     qqnorm(resids,col='gold')  # Looks reasonable
   dev.off()

# 2) Coverage:
  get.coverage <- function(test.size=50) {
    testI <- sample(1:nrow(O3),test.size)
    cv.1  <- GP(o3=O3[-testI,],pred=O3[testI,5:4],X1.col=10)
    cv.lo <- cv.1$lower
    cv.up <- cv.1$upper
    y.in.pi <- ifelse(cv.lo<=O3[testI,6] & O3[testI,6]<=cv.up,T,F) 
    p <- mean(y.in.pi); n <- length(y.in.pi)
    cov.ci <- qnorm(c(.025,.975),p,sqrt(p*(1-p)/n))

    list("coverage"=p,"ci"=cov.ci,"testI"=testI,"gp"=cv.1)
  }

  library(foreach)
  library(doMC)
  registerDoMC(4)
  coverages <- foreach(i=1:10,.errorhandling="remove") %dopar% get.coverage(400)

  covs <- sapply(coverages,function(x) x$cov)
  cov.est <- mean(covs)
  cov.ci  <- qnorm(c(.025,.975),cov.est,sd(covs))

  #mean.ci <- apply(sapply(coverages,function(x) x$ci),1,mean)

  y <- sapply(coverages,function(x) O3[x$testI,6])
  y.hat <- sapply(coverages,function(x) x$gp$pred)
  mses <- apply(y-y.hat,2,function(x) sum(x^2))
  mse.est <- mean(mses)
  mse.ci <- qnorm(c(.025,.975),mse.est,sd(mses))

  options("scipen"=10,"digits"=3)
  cov.and.mse <- rbind(c(cov.est,cov.ci),c(mse.est,mse.ci))
  colnames(cov.and.mse) <- c("Estimate","CI.Lower","CI.Upper")
  rownames(cov.and.mse) <- c("Coverage","MSE")
  options("scipen"=5,"digits"=3)

  xtab.cov.mse <- xtable(cov.and.mse,digits=c(1,3,3,3),caption='Coverage and MSE')
  sink("../latex/raw/cov.mse.tex"); print(xtab.cov.mse,caption.pl='top'); sink()

#3) Interpret:
  
  beta.est <- result$gp.fit$beta
  beta.sd  <- sqrt(diag(result$gp.fit$beta.var))
  beta.ci  <- t(apply(cbind(beta.est,beta.sd),1,
                function(x) qnorm(c(.025,.975),x[1],x[2])))
  betas <- cbind(beta.est,beta.ci)
  colnames(betas) <- c("Estimates","CI.Lo","CI.Hi")
  rownames(betas) <- paste("$\\beta_{",1:nrow(betas)-1,"}$",sep="")
  xtab.beta <- xtable(betas,digits=5,caption='Table 1: Parameter Estimates')
  sink("../latex/raw/beta.tex")
    print(xtab.beta,sanitize.text.function=function(x){x},caption.pl='top')
  sink()

  params <- rbind(result$gp.fit$tausq,1/result$gp.fit$phi,result$gp.fit$sigmasq)
  rownames(params) <- c("tau2","phi","sigma2")

  plot.all()
  plot.prediction()
  plot.compare.methods()
