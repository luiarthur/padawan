# mw.pairs is a function written by Mickey Warner. It does essentially the same
# thing as the pairs function. But it plots a histogram across the diagonal,
# plots the scatter plot in the upper triangle, and plots the contour plots
# in the lower triangle.


mw.pairs <- function(x){
  require(MASS)
  par(mfrow=rep(ncol(x), 2), mar=rep(0, 4)) 
  for (i in 1:ncol(x)){
    for (j in 1:ncol(x)){
      if (i == j){ 
        hist(x[,i], axes = FALSE, main = "", col = "gray")
        legend("topright", legend = i, box.lty = 0, cex = 1.5)
      } else if(i > j){ 
        z = kde2d(x[,i], x[,j])
        plot(NA, xlim = range(z$x), ylim = range(z$y), axes = FALSE)
        .filled.contour(x=z$x, y=z$y, z=z$z, levels=seq(min(z$z), max(z$z), length=20), col=gray(seq(0.0, 1.0, length=20)))
      } else {
        plot(x[,j], x[,i], pch=20, axes = FALSE)
      }   
      box()
    }   
  }
}

#Example:
#dat <- matrix(rnorm(10000),ncol=10)
#mw.pairs(dat)

