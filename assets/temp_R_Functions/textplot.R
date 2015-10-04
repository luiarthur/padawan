# Created By Mickey A Warner
# mickeyawarner@Gmail.com

### todo
# allow user to input where tick marks should be
# default labeling
# less hardcoding some of the values for spacing (in
#   case i want to make adjustments)
# better selection for default x and y tick marks
#   (try to get better round numbers, need to take
#   closest values of the real ticks to the 
#   estimated ticks)

textplot = function(x, y = NULL, pch="*", xlim = NULL, ylim = NULL,
    max.width = 150, max.height = 40, main = "", xlab = NULL, ylab = NULL){

    ### set up
    # process arguments
    if (any(is(x) == "density")){
        y = x$y
        x = x$x
        }
    if (is.null(y)){
        y = x
        x = seq(1, length(x), by = 1)
        }
    if (is.null(xlim))
        xlim = range(x)
    if (is.null(ylim))
        ylim = range(y)
    if (is.null(xlab))
        xlab = "x"
    if (is.null(ylab))
        ylab = "y"
    if (nchar(pch) > 1)
        pch = substr(pch, 1, 1)
    ### create functions
    # for repeating characters using "cat"
    fill = function(char, n)
        paste0(rep(char, n), collapse="")
    # to make cat default to sep="", like paste0
    cat0 = function(...)
        cat(..., sep="")
    sig = function(x)
        signif(x, 3)
    # to transform x from range(x) to [a, b]
    rescale = function(x, a, b)
        floor((x - min(x))/(max(x)-min(x)) * (b - a) + a)

    # subset x and y to fit within xlim and ylim
    x = c(xlim[1], x, xlim[2])
    y = c(ylim[1], y, ylim[2])
    keep.x = which(x >= xlim[1] & x <= xlim[2])
    x = x[keep.x]
    y = y[keep.x]
    keep.y = which(y >= ylim[1] & y <= ylim[2])
    x = x[keep.y]
    y = y[keep.y]
    # calculations to fit within max.width and max.height
    yaxt = as.character(sig(seq(ylim[2], ylim[1], length=6)))
    xaxt = as.character(sig(seq(xlim[1], xlim[2], length=6)))
    left.margin = nchar(ylab) + max(nchar(yaxt))+1
    # the 8 accounts for the space on top and bottom of plot
    h.range = (max.height - 8):1
    w.range = round(seq(0, max.width - left.margin - 3, length=6))
    m.range = 1:(max.width - left.margin - 4)
    new.x = rescale(x, 1, max.width - 4 - left.margin)
    new.x = new.x[-c(1, length(new.x))]
    new.y = rescale(y, 1, max.height - 8)
    new.y = new.y[-c(1, length(new.y))]
    P = unique(cbind(new.x, new.y))
 
    # print main title
    cat0(fill(" ",max(0, floor((max.width - nchar(main))/2))), main, "\n")
    # print blank line
    cat0("\n")
    # print top line of frame
    cat0(fill(" ", nchar(ylab)+1+max(nchar(yaxt))-nchar(yaxt[1])), yaxt[1],
        " -+", fill("-", max.width-4-left.margin), "+\n")
    # print body
    y.at = round(seq(h.range[1]+1, 0, length=length(yaxt)))
    mid = round((h.range[1]+1)/2)
    for (row in h.range){
        # row is on ylab location and a yaxt location
        if (row == mid && any(row == y.at))
            cat0(ylab, fill(" ", max(nchar(yaxt))-nchar(yaxt[which(row == y.at)])+1),
                yaxt[which(row == y.at)], " -|")
        # row is on ylab location but not on yaxt location
        if (row == mid && !any(row == y.at))
            cat0(ylab, fill(" ", max(nchar(yaxt))+1), "  |")
        # row is on yaxt and not mid
        if (row != mid && any(row == y.at))
            cat0(fill(" ", nchar(ylab)), fill(" ", max(nchar(yaxt))-
                nchar(yaxt[which(row == y.at)])+1), yaxt[which(row == y.at)], " -|")
        # row is on neither ylab or yaxt
        if (row != mid && !any(row == y.at))
            cat0(fill(" ", left.margin), "  |")
        # print coordinates
        subP = rbind(P[P[,2] %in% row,], 0)
        for (dot in m.range){
            if (any(dot == subP[,1])){
                cat0(pch)
            } else {
                cat0(" ")
                }
            }
        cat0("|\n")
        }
    # print bottom line of frame
    cat0(fill(" ", nchar(ylab)+1+max(nchar(yaxt))-nchar(yaxt[6])), yaxt[6],
        " -+", fill("-", max.width-4-left.margin), "+\n")
    # print x-axis tick marks
    cat0(fill(" ", left.margin+2), "'")
    for (col in 2:length(w.range))
        cat0(fill(" ", w.range[col] - w.range[col - 1] - 1), "'")
    cat0("\n")
    # print x-values
    cat0(fill(" ", left.margin+3-nchar(xaxt[1])), xaxt[1])
    for (j in 2:length(xaxt))
        cat0(fill(" ", w.range[j] - w.range[j-1] - nchar(xaxt[j])), xaxt[j])
    cat("\n")
        
    # print blank line
    cat0("\n")
    # print xlabel
    cat0(fill(" ",max(0, floor((max.width - nchar(xlab))/2))), xlab, "\n")

    }

# example usage

x = double(100000)
r = runif(length(x))
lr = length(r[r < 0.3])
x = ifelse(r < 0.3, rnorm(lr, -2), rnorm(length(x)-lr, 3))

textplot(density(x), max.width=150, pch="*", xlim=c(-5,5), ylim=c(0, 0.3))
textplot(rnorm(1000),rnorm(1000))


# x = seq(-4, 4, length=1000)
# y = dnorm(x)
# xlim = NULL
# ylab = "density"
# xlab = "x"
# pch = "*"
# main = "dnorm"
# max.width = 150
# max.height = 40

# textplot(x, y, main=main, max.width=max.width, max.height=max.height,
#     ylab=ylab, xlab=xlab, pch=pch, ylim=ylim, xlim=xlim)
# 
# textplot(density(rbeta(1000000, 0.5, 0.5)), main="rbeta", max.width=max.width, max.height=max.height,
#     ylab=ylab, xlab=xlab, pch=pch, ylim=ylim, xlim=xlim)
# 
# textplot(rgamma(1000, 1, 1/50), max.width=150, pch="+", ylim=c(0, 400))
# out = textplot(runif(100), runif(100), max.width=078, pch="*", xlim=c(0, 1), ylim=c(0,1))

# # textplot(density(rcauchy(100000), n=2^21), max.width=150, pch="*", xlim=c(-4,4))
# 
# x = seq(-5, 5, length=10000)
# y = dcauchy(x)
# textplot(x, y, max.width=170/2, pch="*", xlim=c(-4,4), ylim=c(0.0, 0.35))
# textplot(x, y, max.width=170, pch="*", xlim=c(-4,4), ylim=c(0.0, 0.35))
