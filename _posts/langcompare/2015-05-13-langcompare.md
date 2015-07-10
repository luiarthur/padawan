---
layout: post
title: Comparing Programming Languages for Statistics
subtitle: "Execution vs. Development Time"
description: "C++ / Scala / Julia / R execution time vs. development time"
header-color: "rgb(136,48,48)"
---

As a statistical package with a large support community R serves its purpose
well. However, at times, especially when doing more computation-heavy analysis,
R slows down and reaches memory limits. So, I've looked around for a language
that is reasonalbly fast, and quick to develop. Conciseness usually means less
room for coding errors and higher productivity. I tried out C++, Scala, and
Julia. (I also attempted C and Go, but soon realized the linear algebra
libraries were a pain to to grind through.) And since my computational work is
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
  <button type="button" class="jlcode btn btn-default">Julia</button>
  <button type="button" class="scalacode btn btn-default">Scala</button>
  <button type="button" class="cppcode btn btn-default">C++</button>
</div>

<div class="code hide" id="r">
  {% include langcompare/raw.R %} 
</div>
<div class="code hide" id="jl">
  {% include langcompare/raw.jl %}
</div>
<div class="code hide" id="scala">
  {% include langcompare/raw.scala %}
</div>
<div class="code hide" id="cpp">
  {% include langcompare/raw.cpp %}
</div>

<script>
  var lineno = d3.selectAll(".lineno");
</script>


<script> 
$(document).ready(function(){
  $("button.rcode").click(function(){$(".code").attr("class","code hide"); $("#r").attr("class","code show");});
  $("button.jlcode").click(function(){$(".code").attr("class","code hide"); $("#jl").attr("class","code show");});
  $("button.scalacode").click(function(){$(".code").attr("class","code hide"); $("#scala").attr("class","code show");});
  $("button.cppcode").click(function(){$(".code").attr("class","code hide"); $("#cpp").attr("class","code show");});
});
</script>

<script>
  var data = [{code:"C++",color:"goldenrod",val:3.3},
              {code:"Scala",color:"mediumseagreen",val:7.2},
              {code:"Julia",color:"crimson",val:9.1},
              {code:"R",color:"darkcyan",val:51.2}];
  barchart(data,"#speed");
</script>

<script>
  var data = [{code:"C++",color:"goldenrod",val:124},
              {code:"Scala",color:"mediumseagreen",val:117},
              {code:"Julia",color:"crimson",val:75},
              {code:"R",color:"darkcyan",val:56}];
  barchart(data,"#conciseness");
</script>

