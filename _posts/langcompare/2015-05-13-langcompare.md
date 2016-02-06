---
layout: post
title: Comparing Programming Languages for Statistics
subtitle: "Execution vs. Development Time"
description: "C++ / Scala / Julia / R execution time vs. development time"
barchart: on
header-color: "rgb(136,48,48)"
---

As a statistical package with a large support community R serves its purpose
well. However, at times, especially when doing more computation-heavy analysis,
R slows down and reaches memory limits. So, I've looked around for a language
that is reasonably fast, and quick to develop. Conciseness usually means less
room for coding errors and higher productivity. I tried out C++, Scala, Python,
and Julia. (I also attempted C and Go, but soon realized the linear algebra
libraries were a pain to grind through.) And since my computational work is
usually Bayesian, I created my own criteria for judging performance — a
standard Bayesian multiple linear regression algorithm.

\\[\begin{array}{rcl}
   y|\beta & \sim & Normal(X\beta,\sigma^2I) \\\\
     \beta & \sim & Normal(0,100(X'X)^{-1}) \\\\
  \sigma^2 & \sim & Gamma(1,1) \\\\
\end{array}\\]

The simulated data used for this study can be found at my
[github](https://github.com/luiarthur/progSpeedCompare/blob/master/data/dat.txt).

This simulation study is not meant to be an official benchmark. Sites such as
[computer language benchmark
games](http://benchmarksgame.alioth.debian.org/u64q/compare.php?lang=scala&lang2=gpp)
do a more thourough job. Though, this study surely offers insights for those
that do computational statistics.


## Results
From the plots below, we can see that Julia seems to be fast and concise. I
found some things that were non-intuitive. Loading libraries takes a while, but
there are ways to [precompile
packages](https://groups.google.com/forum/#!topic/julia-users/uQfBNtJksRo).

I've included code at the bottom of this page.

***
<div id="speed">
<h3 style="text-align:center"> Bayesian Multiple Linear Regression Speed (seconds) </h3> 
</div>
<span class="caption text-muted"> C++ wins in execution time. </span>
***
<div id="conciseness">
<h3 style="text-align:center"> Bayesian Multiple Linear Regression (Lines of Code) </h3>
</div>
<span class="caption text-muted"> R wins in conciseness. </span>
***

![Overall Comparison](/assets/langcompare/img/vs.svg)
<span class="caption text-muted">We want things to be in the bottom left quadrant &mdash;  Julia wins that one.</span>
***

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

<div class="mycode hide" id="r">
  {% highlight R linenos %} 
  {% include_relative code/raw.R %} 
  {% endhighlight %}
</div>
<div class="mycode hide" id="py">
  {% highlight python linenos %}
  {% include_relative code/raw.py %} 
  {% endhighlight %}
</div>
<div class="mycode hide" id="jl">
  {% highlight julia linenos %}
  {% include_relative code/raw.jl %}
  {% endhighlight %}
</div>
<div class="mycode hide" id="scala">
  {% highlight scala linenos %}
  {% include_relative code/raw.scala %}
  {% endhighlight %}
</div>
<div class="mycode hide" id="cpp">
  {% highlight C++ linenos %}
  {% include_relative code/raw.cpp %}
  {% endhighlight %}
</div>
<div class="mycode hide" id="c">
  {% highlight c linenos %}
  {% include_relative code/raw.c %} 
  {% endhighlight %}
</div>
<div class="mycode hide" id="h">
  {% highlight c linenos %}
  {% include_relative code/raw.h %} 
  {% endhighlight %}
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

<script>
  var data = [{code:"C++",color:"goldenrod",val:3.3},
              {code:"Scala",color:"mediumseagreen",val:7.2},
              {code:"Julia",color:"crimson",val:9.1},
              {code:"Python",color:"grey",val:23.5},
              {code:"R",color:"darkcyan",val:51.2}];
  barchart(data,"#speed");
</script>

<script>
  var data = [{code:"C++",color:"goldenrod",val:124},
              {code:"Scala",color:"mediumseagreen",val:117},
              {code:"Julia",color:"crimson",val:75},
              {code:"Python",color:"grey",val:84},
              {code:"R",color:"darkcyan",val:56}];
  barchart(data,"#conciseness");
</script>

