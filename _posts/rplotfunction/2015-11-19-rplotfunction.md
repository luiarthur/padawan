---
layout: post
descriptions: "Making the default plot in R pretty by presetting .Rprofile"
title: "Pretty R Plots - by Default"
subtitle: "Simply Beautiful"
---

If you type `plot( rnorm(100), rnorm(100) )` in R, this is what you get.

![Ugly R Plot](/assets/rplotfunction/ugly.svg)

R is great for producing plots! Plotting is fast, graphs don't need to be
viewed in a browser, and the user has a decent amount of control over his/her
plots. I would choose R for *non-interactive* plotting any day. (For
interactive graphics, I would obviously choose to plot using a more suitable
tool, like `d3.js`.)

That having been said, I prefer plots that are less busy. I've heard that
plots / graphics should have a high data-to-ink ratio. That is, if a plot can
be shown as effectively with less ink, it should be done. So, I would like to
enter the `plot` command in R and get a simpler plot. And much less black,
because I prefer shades of grey... Look at this plot:

![Pretty R Plot](/assets/rplotfunction/pretty.svg)

- the default box was removed
- the color of the circles, axes, and labels were changed to grey
- and this was plotted using the same `plot( rnorm(100), rnorm(100) )` command

You read the last bullet correctly. I changed my default `plot` function
to use the colors and settings I like. It's as simple as putting this script
in your home directory and naming it `.Rprofile`.

~~~R
# ~/.Rprofile
dummy1 <- function(x,y,...) UseMethod("plot")

plot <- function(..., fg="grey", bty="n", col="grey20", 
                 col.lab="grey20",col.axis="grey30") {
  dummy2 <- function(..., fg.a = fg, bty.a = bty, col.a = col, 
                     col.lab.a = col.lab, col.axis.a = col.axis) {
    dummy1(fg=fg.a,bty=bty.a,col=col.a,col.axis=col.axis.a,col.lab=col.lab.a,...) 
  }
  dummy2(...)
}
~~~

Now, every time you launch R, this script is run. And you can use the plot
command as usual. You can still change the color of lines, points, etc.  using
the `col` argument. (That is the motivation behind using a dummy function in
the script above.) And you can get your default plots looking even better than
the default default-plots.
