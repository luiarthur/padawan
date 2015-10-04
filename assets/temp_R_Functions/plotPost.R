my.color <- function(dat,from,to,col.den="black",col.area="red",...) {
  if (is(dat)[1] == "function") {
    color.fn(dat,from,to)
  } else if (is(dat)[1] == "density") {
    color.den(dat,from,to,col.den,col.area,...)
  } else if (is(dat)[1] == "matrix") {
    color.emp(dat,from,to)
  }
}


color.den <- function(den,from,to,col.den="black",col.area="red",add=F,...) {
  # Colors area under a density within an interval
  # den has to be a density object
  if (add) {
    #lines(den,col=col.den,...)
  } else {
    plot(den,col=col.den,...)
  }
  polygon(c(from, den$x[den$x>=from & den$x<=to], to),
          c(0, den$y[den$x>=from & den$x<=to], 0),
          col=col.area,border=col.den)
}

color.fn <- function(f,from,to) {
  x <- seq(from,to,by=(to-from)/10000)
  polygon(c(from,x,to),
          c(0,f(x),0),col="red")
}


color.emp <- function(M,from,to) {
  x <- M[,1]
  y <- M[,2]
  polygon(c(from,x[x>=from & x<= to],to),
          c(0,y[x>=from & x<=to],0),col="red")
}


bound <- function(x, dens, return.x=TRUE){
  # Mickey Warner: 
  # https://github.com/mickwar/r-sandbox/blob/master/mcmc/bayes_functions.R
  # returns the x-value in dens that is closest
  # to the given x
  if (return.x)
      return(dens$x[which.min(abs(dens$x-x))])

  # returns the y-value in dens at the closest x
  return(dens$y[which.min(abs(dens$x-x))])
}

col.mult = function(col1 = 0x000000, col2 = "gray50"){
  # Mickey Warner: 
  # https://github.com/mickwar/r-sandbox/blob/master/mcmc/bayes_functions.R
  # returns the x-value in dens that is closest
  # to the given x
  if (is.character(col1))
      val1 = t(col2rgb(col1) / 255)
  if (is.numeric(col1))
      val1 = t(int2rgb(col1) / 255)
  if (is.character(col2))
      val2 = t(col2rgb(col2) / 255)
  if (is.numeric(col2))
      val2 = t(int2rgb(col2) / 255)
  rgb(val1 * val2)
}

int2rgb = function(x){
# int2rgb()
# convert an integer between 0 and 16777215 = 256^3 - 1,
# or between 0 and 0xFFFFFF
# this function is depended upon by col.mult
  # Mickey Warner: 
  # https://github.com/mickwar/r-sandbox/blob/master/mcmc/bayes_functions.R
  # returns the x-value in dens that is closest
  # to the given x
  hex = as.character(as.hexmode(x))
  hex = paste0("#", paste0(rep("0", 6-nchar(hex)), collapse=""), hex)
  col2rgb(hex)
}

plot.post <- function(x,main=NULL,hpd=T,color="cornflowerblue",cex.l=1,trace=T,
                      stay=F,tck.dig=4,...) {
  mn.x <- round(mean(x),5)
  v.x <- round(sd(x),3)
  den <- density(x)
  rng <- c(min(den$y),max(den$y))

  diff <- rng[2]-rng[1]
  main <- ifelse(is.null(main),"Posterior Distribution",
                         paste("Posterior Distribution \n for",main))
  if (hpd) {
  } else {
  }

  rng.x <- range(den$x)
  x.diff <- rng.x[2] - rng.x[1]

  if (hpd) {
    hpd <- get.hpd(x)

    plot(density(x),col=color,ylim=c(rng[1],rng[2]+diff*.3),lwd=3,
         main=main,xaxt="n")

    color.den(den,rng.x[1],rng.x[2],col.den=color,col.area=color,add=T)
    color.den(den,hpd[1],hpd[2],col.den=col.mult(color),
              col.area=col.mult(color),add=T) 
    lines(c(mn.x,mn.x),c(0,bound(mn.x,den,ret=F)),lwd=2,col="red")

    axis(1,at=c(hpd,mn.x),labels=round(c(hpd,mn.x),tck.dig),las=0,...)
    legend("topleft",legend=c(paste("Mean =",mn.x),
                              paste("Std. Dev. =",v.x),
                              paste("Low HPD =",round(hpd[1],4)),
                              paste("Upp HPD =",round(hpd[2],4))),
                              bty="n",cex=cex.l)
  } else {
    plot(density(x),col=color,ylim=c(rng[1],rng[2]+diff*.3),lwd=3,main=main)
    color.den(den,rng.x[1],rng.x[2],col.den=color,col.area=color,add=T)
    lines(c(mn.x,mn.x),c(0,bound(mn.x,den,ret=F)),lwd=2,col="red")
    legend("topleft",legend=c(paste("Mean =",mn.x),
                              paste("Std. Dev. =",v.x)),
                              bty="n",cex=cex.l)
  }

  mfg <- par()$mfg

  if (trace) {
    opts <- par(no.readonly=T)
      left <- rng.x[1] + x.diff*2/3
      right <- rng.x[2]
      par(fig = c(grconvertX(c(left,right),from="user",to="ndc"),
                  grconvertY(c(rng[2],rng[2]+diff*.3),from="user",to="ndc")),
          mar = c(.1,.1,1,.1), new = TRUE)
      plot(x,type="l",col="gray30",cex.main=.5,axes=F,main="Trace Plot")
      axis(1,cex.axis=.5)
      axis(2,cex.axis=.5)
    par(opts)
  }

  if (!(stay)) {
    row.num <- mfg[1]
    col.num <- mfg[2]
    last.row <- mfg[3]
    last.col <- mfg[4]

    if (col.num < last.col) {
      mfg[2] <- mfg[2] + 1
    } else {
      if (row.num < last.row) {
        mfg[1] <- mfg[1] + 1
      } else {
        mfg[1] <- 1
      }
      mfg[2] <- 1
    }
  }

  par(mfg=mfg)
}


get.hpd <- function(x,a=.05,len=1e3) {
  V <- matrix(seq(0,a,length=len))
  quants <- t(apply(V,1,function(v) quantile(x,c(v,v+1-a))))
  diff <- quants[,2]-quants[,1]
  min.d <- V[which.min(diff)]
  hpd <- quantile(x,c(min.d,min.d+1-a))
  hpd
}


plot.contour <- function(M,...) {
  library(MASS) # filled.contour, kde2d
  J <- kde2d(M[,1],M[,2])
  contour(J,...)
}

plot.posts <- function(M,names=rep(NULL,ncol(M)),digits=4,cex.legend=.7,
                       keep.par=F,tck.dig=4,cex.a=1/ncol(M)) {
  k <- ncol(M)
  corrs <- cor(M)
  set <- par(no.readonly=T)
  par(mfrow=c(k,k))
    for (i in 1:k) {
      if (i>1) {
        for (j in 1:(i-1)) { 
          plot(1, type="n", axes=F, xlab="", ylab="",
               main=paste0("Corr (",names[i],",",names[j],")")) # empty plot
          r <- round(corrs[i,j],digits)
          cex.cor <- max(.8/strwidth(format(r)) * abs(r),1)
          text(1,labels=r,cex=cex.cor)
          #legend("center",legend=corrs[i,j],
          #       title=paste0("Corr (",names[i],",",names[j],")"))
        }  
      }
      
      plot.post(M[,i],cex.l=cex.legend,main=names[i],tck.dig=tck.dig,cex.axis=cex.a)

      if (i<k) {
        for (j in (i+1):k) {
          plot(M[,c(j,i)],type="l",col="gray85",xlab=names[j],ylab=names[i],
               main=paste("Trace & Contour \n",names[i],"vs",names[j]))
          plot.contour(M[,c(j,i)],add=T)
        }
      }  
    }
  if (!(keep.par)) par(set)
}
