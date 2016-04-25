---
layout: post
title: Using RCall in Julia
subtitle: Interfacing Julia and R
description: "How to use R in Julia. can i make R plots from julia? Can I pass data to and from R and Julia?"
dollar: off
comments: cucumber
---

Julia is a great language for computation. It's quick to develop in, and execution time is short compared to many other languages. Check out [the julia home site][1] to see how Julia compares to other languages (including C, Go, Java, and Python) used for scientific computing. 

Often when I am working in Julia, I need to use functions in R -- mostly for plotting, sometimes to use nice canned stats functions. So, an interface to R is a big plus. [RCall][6] in Julia is one tool that allows interface with R. It's great, except for the [documentation][4] is very underwhelming... But no worries, here is a brief demonstration of how to exploit the statistical functionality in R by simply using the RCall package in Julia. I use RCall mostly for plotting figures in R, because so far, no other plotting tools works anywhere as good... Note that there are other tools for interfacing Julia and R. [Rif][5], for instance. However, Rif seems to produce a lot of deprecation warnings. So, I am only talking about RCall.

I highly recommend Julia for computation. It's concise and fast. But, [here][3] is some other opinions against Julia.


### Quick Reference

| | Example Julia Command | Notes |
|:---|:---|:---|
|Install RCall| `Pkg.add("RCall")` | |
|Load RCall | `using RCall`| |
|Execute a statement in R| `reval("plot(rnorm(10))")` | or `R"plot(rnorm(10))"` |
|Creating an R variable in R| `R"var <- 123*321"`| You can later refer to `var` by `R"var"`. You could manipulate the variable too: `R"var / 100"`|
|Create an R Object| `r_X = RObject([1 2; 4 5; 7 8])`| But I really don't know what this is used for... |
|Saving an R Function | `R_plot = R"plot"` | use it later in Julia: `R_plot(x=randn(100),ylab='')` |
|Loading an R Library| `@rlibrary("maps")` or `R"library(maps)"` | Need to have installed the package in R or in Julia by `R"install.packages('maps')"`|
|Using the loaded R Library| `R"map('county')"` | |
|Loading a Julia variable into R| `@rput X` | See example below |
|Putting an R variable into Julia| `@rget Z` | See example below |


### A Cool Example

```bash
#= To Install RCall:
  Pkg.add("RCall")
=#
using RCall


X = randn(3,2)
b = reshape([2.0, 3.0], 2,1)
y = X * b + randn(3,1)

# Note that X and y are julia variables. @rput sends y and X to R with the same names
@rput y
@rput X

# Fit a model in R
R"mod <- lm(y ~ X-1)"
R"summary(mod)"

# If you want to retrieve a variable from R, look at this example
R"z <- y * 3"
@rget z
z

# In this example, we really need to use reval
R_lm(some_str_expr) = reval(rparse("lm(" * some_str_expr * ")"))
R_summary = R"summary"
R_mod = R_lm("y ~ X-1")
R_summary(R_mod)

# Finally, plotting. Note that if you don't set ylab and xlab, you'll get a very messy plot...
R_plot = R"plot"
R_plot(x=rand(100),y=rand(100),pch=20,cex=2,fg="grey",bty="n",ylab="",xlab="")
R"plot(X[,1],y)"
# Now, you can call R_plot in julia quite like you call plot in R
```


[1]: http://julialang.org/#high-performance-jit-compiler
[2]: https://dahl.byu.edu/software/jvmr/
[3]: https://darrenjw.wordpress.com/2013/12/23/scala-as-a-platform-for-statistical-computing-and-data-science/
[4]: http://rcalljl.readthedocs.org/en/latest/api/RCall/#macro___rget.1
[5]: https://github.com/lgautier/Rif.jl
[6]: https://github.com/JuliaStats/RCall.jl

<!--
As a statistics grad student, I have dabbled around in various language to figure out what my niche is. During my masters and undergrad, I coded quite exclusively in R, sometimes interfacing with C, and occasionally using SAS for things like multivariate analysis and mixed effects models. I even used a little Scala when I first started working with David Dahl (my advisor at BYU). When I began my PhD (at UC - Santa Cruz) last year I took a Bayesian nonparametrics course, I learned that while I really like R (what statistician doesn't?), I needed to get very comfortable with other languages. The goal was to become as conversant in those languages as I was in R. So, for my BNP course, I coded a couple of assignments in C++, and another couple in Julia. Quite a fun learning experience! I continued to use armadillo with OpenBLAS for C++, interfacing from R to get some interactivity, and nice plots.

I've recently decided to revisit Scala and Julia. I think that only by actually coding things regularly, can I really figure out what suits my needs as a young budding statistician the most. For practical reasons, I still need the interface with R. For parsing data, exploratory analysis, and easy and publication ready plotting! I've written quite a few handy functions for plotting posterior distributions in `R`. So, instead of letting them go to waste, I'd like to keep them around. Scala has a great solution to interfacing to R - [JVMR][2]. Written by David Dahl, actually! You drop a `jar` in your `lib` directory and off you go. And the documentation is quite comprehensive and easy to follow. With Julia, there's also... -->


