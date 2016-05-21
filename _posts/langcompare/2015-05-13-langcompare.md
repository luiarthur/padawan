---
layout: post
title: Comparing Programming Languages for Statistics
subtitle: "Execution vs. Development Time"
description: "C++ / Scala / Julia / R execution time vs. development time"
barchart: off
dollar: on
plotlyjs: on
comments: cucumber
header-color: "rgb(136,48,48)"
---

As a statistical package with a large support community R serves its purpose
well. However, at times, especially when doing more computation-heavy analysis,
R slows down and reaches memory limits quickly. So, I've looked around for a
language that is reasonably fast, and quick to develop. Conciseness usually
means less room for coding errors and higher productivity. I tried out C, C++,
Scala, Python, and Julia. (I also attempted Go, but soon realized the
linear algebra libraries were a pain to grind through.) And since my
computational work is usually Bayesian, I created my own criteria for judging
performance -- a standard Bayesian multiple linear regression algorithm. 

$$
\begin{array}{rcl}
  y\v\beta & \sim & \text{Normal}(X\beta,\sigma^2I) \\
     \beta & \sim & \text{Normal}(0,100(X'X)^{-1}) \\
  \sigma^2 & \sim & \text{Gamma}(1,1)
\end{array}
$$

The simulated data used for this study can be found at my
[github](https://github.com/luiarthur/progSpeedCompare/blob/master/data/dat.txt).

This simulation study is not meant to be an official benchmark. Sites such as
[computer language benchmark
games](http://benchmarksgame.alioth.debian.org/u64q/compare.php?lang=scala&lang2=gpp)
do a more thorough job. Though, this study surely offers insights for those
that do computational statistics.

Note that for C++, I used the [Armadillo](http://arma.sourceforge.net/) library
with [OpenBLAS](http://www.openblas.net/). For C, I used the GSL library.  I
*could* have done the C implementation in OpenBLAS. But is it *really* worth
it?  For Scala, I used the [breeze](https://github.com/scalanlp/breeze)
library. For Python, I used [Numpy](http://www.numpy.org/). For Julia, I used
the [Distributions](https://github.com/JuliaStats/Distributions.jl) package
(which is pretty standard in Julia and extremely well made, in my opinion).
Last of all, I didn't need any additional libraries in R.


## Laptop Specs

Here are the specs for the machine I used to run the simulation.

| | HP EliteBook 8560p|
|:---|:---|
| CPU    | Quad core 2 threads per core Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz |
| Memory | 16 GB |

## Results
From the plots below, we can see that Julia and Scala seem to be fast and
concise. In Julia, loading libraries still takes some time to compile (as of
v0.4.5, it's much faster), but there are also ways to [precompile
packages](https://groups.google.com/forum/#!topic/julia-users/uQfBNtJksRo).

I've included code at the bottom of this page.

***

<h3 style="text-align:center"> Bayesian Multiple Linear Regression Speed (seconds) </h3> 
<div id="speed"></div>
<span class="caption text-muted"> C++ wins in execution time. </span>

***

<h3 style="text-align:center"> Bayesian Multiple Linear Regression (Lines of Code) </h3>
<div id="conciseness"></div>
<span class="caption text-muted"> R wins in conciseness. </span>

***

{::comment} ![Overall Comparison](/assets/langcompare/img/vs.svg) {:/comment}
<h3 style="text-align:center"> Speed vs. Code Length Trade-off </h3>
<div id="scatplot" class="plotly-graph-div"></div>
<span class="caption text-muted">We want things to be in the bottom left quadrant &mdash;  Julia wins that one.</span>

***

It's definitely a toss up between Julia and Scala. Julia is created for 
technical computing. And some have said that it is also general purpose. 
It hasn't reached a 1.0 version yet. Sometimes, I'll run into bugs when
loading new libraries. Searching for fixes is usually a longer process.
Documentation is not consistent, but all the Julia packages are hosted
on Github. In short, Julia is lightning fast, and quick to develop in, but
there is a moderate lack of consistency in documentation and interoperability
of packages. Still, it's *pretty* fast. Also it's quite mobile because
it runs the LLVM virtual machine.

Scala is much more mature of a language and has attracted many large
enterprises and users. It is general purpose. It has full support for
functional programming and tail call optimization. It is quite fun to program
in a functional way and think recursively. And Scala is pretty fast. It runs on
JVM which is extremely portable. People even write Android apps in Scala. 
Many users favor general purpose languages for computation because 
they want to integrate their algorithms into other products. In other words, 
it's often not enough to only have a fast computation platform; having
support for functionality outside of computation is desirable for 
much commercial work. Perhaps also true for academia. Last of all, the
distributed computing tool, [Spark](http://spark.apache.org/), is written in
Scala. That is quite enticing.

Scala and Julia are both *in demand* and desirable skill-sets. So
if you're considering learning one or the other, there are great
advantages to learning either. If you have the patience, why not 
even learn both? 

There are many resources for learning Scala. Coursera has two courses centered
on Scala. One on [Functional
Programming](https://www.coursera.org/course/progfun), and another on [Reactive
Programming](https://www.coursera.org/course/reactive).  Both are taught by
Martin Odersky, the creator of Scala. You can find tutorials here and there for
Julia. Perhaps the best place to get started is the [Julia
Homepage](http://julialang.org/).  Note that the [Jupyter
Project](http://jupyter.org/) also includes Julia, so there are popular
implementations of ipython notebook for Julia.  (Quick plug-in for Jupyter. You
can install
[vim-bindings](https://github.com/lambdalisue/jupyter-vim-binding)!)


## Sample Code
<div class="btn-group" role="group" aria-label="...">
  <button type="button" class="rcode btn btn-default">R</button>
  <button type="button" class="pycode btn btn-default">Python</button>
  <button type="button" class="jlcode btn btn-default">Julia</button>
  <button type="button" class="scalacode btn btn-default">Scala</button>
  <button type="button" class="cppcode btn btn-default">C++</button>
  <button type="button" class="ccode btn btn-default">c</button>
  <button type="button" class="hcode btn btn-default">my_gsl.h</button>
</div>

***

<div class="mycode hide" id="r">
{% highlight R linenos %}{% include_relative code/raw.R %}{% endhighlight %}
</div>
<div class="mycode hide" id="py">
{% highlight python linenos %}{% include_relative code/raw.py %}{% endhighlight %}
</div>
<div class="mycode hide" id="jl">
{% highlight julia linenos %}{% include_relative code/raw.jl %}{% endhighlight %}
</div>
<div class="mycode hide" id="scala">
{% highlight scala linenos %}{% include_relative code/raw.scala %}{% endhighlight %}
</div>
<div class="mycode hide" id="cpp">
{% highlight C++ linenos %}{% include_relative code/raw.cpp %}{% endhighlight %}
</div>
<div class="mycode hide" id="c">
{% highlight c linenos %}{% include_relative code/raw.c %}{% endhighlight %}
</div>
<div class="mycode hide" id="h">
{% highlight c linenos %}{% include_relative code/raw.h %}{% endhighlight %}
</div>



<script> 
$(document).ready(function(){
  $("button.rcode").click(function(){$(".mycode").attr("class","mycode hide"); $("#r").attr("class","mycode show");});
  $("button.pycode").click(function(){$(".mycode").attr("class","mycode hide"); $("#py").attr("class","mycode show");});
  $("button.jlcode").click(function(){$(".mycode").attr("class","mycode hide"); $("#jl").attr("class","mycode show");});
  $("button.scalacode").click(function(){$(".mycode").attr("class","mycode hide"); $("#scala").attr("class","mycode show");});
  $("button.cppcode").click(function(){$(".mycode").attr("class","mycode hide"); $("#cpp").attr("class","mycode show");});
  $("button.ccode").click(function(){$(".mycode").attr("class","mycode hide"); $("#c").attr("class","mycode show");});
  $("button.hcode").click(function(){$(".mycode").attr("class","mycode hide"); $("#h").attr("class","mycode show");});
});
</script>

{::comment}
<script>
  var data = [{code:"C++",color:"goldenrod",val:1.9},
              {code:"Scala",color:"mediumseagreen",val:4.2},
              {code:"Julia",color:"crimson",val:3.0},
              {code:"Python",color:"grey",val:23.5},
              {code:"R",color:"darkcyan",val:51.2}];
  barchart(data,"#speed",1);
</script>
{:/comment}


{::comment}
<script>
  var data = [{code:"C++",color:"goldenrod",val:124},
              {code:"Scala",color:"mediumseagreen",val:93},
              {code:"Julia",color:"crimson",val:75},
              {code:"Python",color:"grey",val:84},
              {code:"R",color:"darkcyan",val:55}];
  barchart(data,"#conciseness");
</script>
{:/comment}

{% include_relative code/scatter.html %}
{% include_relative code/bar_line.html %}
{% include_relative code/bar_time.html %}
