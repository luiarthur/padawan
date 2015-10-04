plot.in.plot <- function(minor.plot,coords="topright",scale=1/3) {
  # coords = x1,y1,x2,y2
  # minor.plot is a function with no parameters that plots the smaller plot
  mar <- x1 <- x2 <- y1 <- y2 <- NULL
  s <- par("usr")
  if (is.numeric(coords)) {
    x1 <- coords[1]; x2 <- coords[2]
    y1 <- coords[3]; y2 <- coords[4]
  } else if (coords=="topright"){
    x1 <- s[1] + (s[2]-s[1]) * (1-scale)
    x2 <- s[2] - (s[2]-s[1]) * .01
    y1 <- s[3] + (s[4]-s[3]) * (1-scale)
    y2 <- s[4]
    mar <- c(.1,.1,1,.1)
  } else if (coords=="bottomright") {
    x1 <- s[1] + (s[2]-s[1]) * (1-scale)
    x2 <- s[2] - (s[2]-s[1]) * .01
    y1 <- s[3] + (s[4]-s[3]) *.05
    y2 <- y1 + (s[4]-s[3]) * (scale)
    mar <- c(1,.1,1,.1)
  } else if (coords=="topleft") {
    x1 <- s[1] + (s[2]-s[1]) * .05
    x2 <- x1 + (s[2]-s[1]) * (scale)
    y1 <- s[3] + (s[4]-s[3]) * (1-scale)
    y2 <- s[4]
    mar <- c(.1,1,1,.1)
  }else if (coords=="bottomleft") {
    x1 <- s[1] + (s[2]-s[1]) * .05
    x2 <- x1 + (s[2]-s[1]) * (scale)
    y1 <- s[3] + (s[4]-s[3]) *.05
    y2 <- y1 + (s[4]-s[3]) * (scale)
    mar <- c(1,1,1,.1)
  }
  opts <- par(no.readonly=T)
    par(fig = c(grconvertX(c(x1,x2),from="user",to="ndc"),
                grconvertY(c(y1,y2),from="user",to="ndc")),
        mar = mar, new = TRUE)
    minor.plot()
    #axis(1,cex.axis=.5)
    #axis(2,cex.axis=.5)
  par(opts)
}

#x <- rnorm(10000)
#plot(density(x),ylim=c(0,.5))
#
#minor <- function() {
#  plot(x,type="l",axes=F,main="Trace",cex.main=.8) 
#  axis(1,cex.axis=.5)
#  axis(2,cex.axis=.5)
#}
#
##plotinplot(minor,c(1,4,.4,.5))
#plot.in.plot(minor,"topright")
#plot.in.plot(minor,"bottomright")
#plot.in.plot(minor,"bottomleft")
#plot.in.plot(minor,"topleft")

