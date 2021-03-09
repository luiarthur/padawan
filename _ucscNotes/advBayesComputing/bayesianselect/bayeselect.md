---
layout: post
date: 2016-02-14
permalink: "/ucsc_notes/advBayesComputing/bayeselect/"
wide: on
title: Comparing Bayesian Regression Methods in High Dimension Settings
subtitle: "UCSC AMS 268 Course Assignment 1"
dollar: on
---

In my advanced Bayesian computation course this semester, we compared the performance of several modern regression models[^1]: lasso, rigdge, SSVS, Bayesian lasso, and generalized double pareto prior regression. To compare the performances, we were given some specifications for a simulation study. Here are the specifications and what we wanted to investigate. 

<center>
<object data='{{ "/assets/ams268/hw/hw1/instructions/hw1.pdf" | prepend: site.baseurl }}' type="application/pdf" width="900px" height="1000px">
</object>
</center>

## Comparing Competing Bayesian Models

The performances of three Bayesian models

- Stochastic Search Variable Selection (SSVS)
- Bayesian Lasso
- Generalized Double Pareto (GDP)

were compared using the RMSE of the posterior means for the coefficiencts $E[\pmb\beta\|\mathbf y]$. The findings are summarized in Figure 1 and Table 1. 

{::options parse_block_html="true" /}
<div id="rmse-fig" style="text-align:center">
<div class="img-blasso">
#### RMSE sorted by Bayesian Lasso RMSE
![rmseblasso]({{ "/assets/ams268/hw/hw1/img/rmseblasso.png" | prepend: site.baseurl }})
</div>
<div class="img-gdp hide">
#### RMSE sorted by Generalized Double Pareto Prior Model RMSE
![rmseblasso]({{ "/assets/ams268/hw/hw1/img/rmsegdp.png" | prepend: site.baseurl }})
</div>
<div class="img-ssvn hide">
#### RMSE sorted by SSVS Model RMSE
![rmseblasso]({{ "/assets/ams268/hw/hw1/img/rmsessvn.png" | prepend: site.baseurl }})
</div>
<span class="caption text-muted"> 
  Figure 1: RMSE of Bayesian regression models sorted according to the various models. Click the figure to change how the figure is sorted. Triangles represent the RMSE of the SSVS model; circles represent the RMSE of the Bayesian lasso model; and crosses represent the RMSE the generalized double pareto prior model. 
</span>
</div>

<div id="rmse-tab">

|             |Bayesian Lasso|  GDP| SSVS|
|:-----------:|-------------:|----:|----:|
|Average RMSE |         0.314|0.372|0.584|

<span class="caption text-muted"> Table 1 </span>
</div>

From Table 1, we see averaged across the different simulated data sets, and across a variety of situations, the Bayesian lasso performs best (with lowest RMSE of .314). From Figure 1, we see that the SSVS performs the worst when all the coefficents are non-zero. The effect is increased when the variables are correlated. The utility of the SSVS, however, is in its variable selection ability.The performance of the GDP prior model in recovering the true value of the coefficients is in between that of the Bayesian lasso and the GDP prior model. It sacrifices accuracy slightly to gain much flexibility. Note that in the case where none of the predictors were zero, the GDP prior model does at least as good as the Bayesian lasso model.

{::options parse_block_html="false" /}


## Comparing Spike and Slab Prior Model and Lasso for Variable Selection

We investigate the performance of Lasso and the Spike and Slab prior model in this section. (From here on, we will use SSVS and spike and slab interchangeably because SSVS was used in the implementation.) For the SSVS model, a variable was counted as selected when the indicator $\gamma\_j$ for variable $j$ had a posterior mean greater than $.5$. Also, for the SSVS model, we used $g=100/\tau\_j^2$, and $\tau\_j^2=.0025$. The results are summarized in Figure 2 and Table 2.

{::options parse_block_html="true" /}
<div id="lvs" style="text-align: center">
<div class="img-lvsp">
#### Lasso Vs. SSVS Prior Model True Positives sorted by Lasso True Positives
![lassoVssvn]({{ "/assets/ams268/hw/hw1/img/lassoVssvnPP.png" | prepend: site.baseurl }})
</div>
<div class="img-svlp hide">
#### Lasso Vs. SSVS Prior Model True Positives sorted by SSVS True Positives
![lassoVssvn]({{ "/assets/ams268/hw/hw1/img/ssvnVlassoPP.png" | prepend: site.baseurl }})
</div>
<div class="img-lvsf hide">
#### Lasso Vs. SSVS Prior Model True Positives sorted by Lasso True Negatives
![lassoVssvn]({{ "/assets/ams268/hw/hw1/img/lassoVssvnFF.png" | prepend: site.baseurl }})
</div>
<div class="img-svlf hide">
#### Lasso Vs. SSVS Prior Model True Positives sorted by SSVS True Negatives
![lassoVssvn]({{ "/assets/ams268/hw/hw1/img/ssvnVlassoFF.png" | prepend: site.baseurl }})
</div>
<span class="caption text-muted"> 
  Figure 2: Proportion of true positives (++) and true negatives (--) of variables being selected in the Lasso (dot) and SSVS model (triangle). Click the image to see them sorted in different orders. The SSVS and lasso models perform poorly at variable selection when all the coefficients are non-zero and the number of preditors is much larger than the number of observations. In those settings, the SSVS performs better than lasso, but worse than guessing.
</span>
</div>

Figure 2 shows the proportion of true positives (++) and true negatives (--) of variables being selected in the Lasso (dot) and SSVS model (triangle). The SSVS and lasso models perform poorly at variable selection when all the coefficients are non-zero and the number of preditors is much larger than the number of observations. In those settings, the SSVS performs better than lasso, but worse than guessing. However, averaged across the different models, their true positive and true negative rates are about the same. This suggests that for variable selection, one may use a lasso to select variables as a preliminary screening, and then perform regression on the screened variables. The true negative rates were 0 for the lasso model when only the intercept was 0 and all the other coefficients were 1. That is the lasso model took the intercept to be non-zero when it in fact was in the case that all the variables were important. Also, when the number of predictors was much greater than the number of observations, the SSVS model predicted only half of the truly non-zero coefficients to be zero while the lasso model predicted most of them to be zero.

<div id="lvs-tab">

|     | True Positive | True Negative |
|----:|--------------:|---------------:|
|Lasso| .7220 | .6391|
|SSVS | .7208 | .8963|

<span class="caption text-muted"> Table 2: True positives and true negatives averaged across all simulated models of variables being selected. </span>
</div>

From Table 2, we see that averaged across all the models the lasso models true positive rates (that is the proportion of times that the model selects a variable) is slightly higher than that of the SSVS model. The true negative rates were higher for SSVS. 

{::options parse_block_html="false" /}



{::options parse_block_html="true" /}

## Mean Lengths of Coefficients
The posterior mean lengths of the truly-zero coefficients are generally low when the number of predictors is not drastically greater than the number of observations.  The SSVS model outperforms the competing models in most situations, except for when $p \gg n$. In which case, the $M\_0$ can get very large (about 30 in this simulation).  Similarly, the posterior mean lengths of the truly-nonzero coefficients are generally low when the number of predictors is not drastically greater than the number of observations.  The SSVS model outperforms the competing models in most situations, except for when $p \gg n$.  In which case, the $M\_{nonzero}$ can get very large (about 30 in this simulation). See Figure 3.

<div id="mzero" style="text-align: center">
<div class="img-Lblasso">
## $M\_{zero}$ sorted by Blasso $M\_{zero}$
![Lblasso]({{ "/assets/ams268/hw/hw1/img/Lblasso.png" | prepend: site.baseurl }})
</div>
<div class="img-Lgdp hide">
## $M\_{zero}$ sorted by GDP $M\_{zero}$
![Lgdp]({{ "/assets/ams268/hw/hw1/img/Lgdp.png" | prepend: site.baseurl }})
</div>
<div class="img-Lssvn hide">
## $M\_{zero}$ sorted by SSVS $M\_{zero}$
![Lssvn]({{ "/assets/ams268/hw/hw1/img/Lssvn.png" | prepend: site.baseurl }})
</div>
<div class="img-L1blasso hide">
## $M\_{nonzero}$ sorted by Blasso $M\_{nonzero}$
![L1blasso]({{ "/assets/ams268/hw/hw1/img/L1blasso.png" | prepend: site.baseurl }})
</div>
<div class="img-L1gdp hide">
## $M\_{nonzero}$ sorted by GDP $M\_{nonzero}$
![L1gdp]({{ "/assets/ams268/hw/hw1/img/L1gdp.png" | prepend: site.baseurl }})
</div>
<div class="img-L1ssvn hide">
## $M\_{nonzero}$ sorted by SSVS $M\_{nonzero}$
![L1ssvn]({{ "/assets/ams268/hw/hw1/img/L1ssvn.png" | prepend: site.baseurl }})
</div>
<span class="caption text-muted"> 
  Figure 3
</span>
</div>


## RMSE of Posterior Predictive Mean 

The posterior predictive means for the Bayesian lasso and GDP models followed the data closely. The SSVS model posterior predictive was obtained by first determining which coefficients were zero, by checking if the posterior mean for the $\gamma\_j$'s were greater than .5. And then only using the predictors that were selected to compute the posterior predictive. The posterior predictive obtained in this way fot the SSVS followed the general trend of the true response but also contains noise. The root mean squared error for the posterior predictive means were lowest for the GDP model (.1485) and highest for SSVS (4.225). (See Figure 4 and Table 3)

<div style="text-align:center">
#### Posterior Predictive Means for Bayesian Models

![postpred]({{ "/assets/ams268/hw/hw1/img/postpred.png" | prepend: site.baseurl }})
<span class="caption text-muted"> 
  Figure 4
</span>
</div>


<div style="text-align:center">
| |Blasso|GDP|SSVS|
|:---:|---:|---:|---:|
| RMSE | .1876811 | .148497 |4.225246|

<span class="caption text-muted"> Table 3 </span>
</div>

{::options parse_block_html="false" /}

## Code for Blasso, GDP, and SSVS

<div class="btn-group" role="group" aria-label="...">
  <button type="button" class="btn btn-default blasso">Blasso</button>
  <button type="button" class="btn btn-default gdp   ">GDP</button>
  <button type="button" class="btn btn-default ssvs  ">SSVS</button>
  <button type="button" class="btn btn-default func  ">func.h</button>
</div>

<div class="mycode hide blasso">
{% highlight C++ linenos %}{% include_relative code/blasso.cpp %}{% endhighlight %}
</div>

<div class="mycode hide gdp">
{% highlight C++ linenos %}{% include_relative code/gdp.cpp %}{% endhighlight %}
</div>

<div class="mycode hide ssvs">
{% highlight C++ linenos %}{% include_relative code/spikeAndSlab.cpp %}{% endhighlight %}
</div>

<div class="mycode hide func">
{% highlight C++ linenos %}{% include_relative code/func.cpp %}{% endhighlight %}
</div>

***

#### Footnotes:
[^1]: Code used for this project can be found [here](https://github.com/luiarthur/advBayesComputing/tree/master/hw/hw1)

{::comment} ----------------JavaScript-------------------- {:/comment}
<script> 
$(document).ready(function(){
  $(".img-blasso").click(function(){$(this).addClass("hide"); $(".img-gdp").removeClass("hide");});
  $(".img-gdp").click(function(){$(this).addClass("hide"); $(".img-ssvn").removeClass("hide");});
  $(".img-ssvn").click(function(){$(this).addClass("hide"); $(".img-blasso").removeClass("hide");});
});
</script>

<script> 
$(document).ready(function(){
  $(".img-lvsp").click(function(){$(this).addClass("hide"); $(".img-svlp").removeClass("hide");});
  $(".img-svlp").click(function(){$(this).addClass("hide"); $(".img-lvsf").removeClass("hide");});
});
  $(".img-lvsf").click(function(){$(this).addClass("hide"); $(".img-svlf").removeClass("hide");});
  $(".img-svlf").click(function(){$(this).addClass("hide"); $(".img-lvsp").removeClass("hide");});
</script>

<script> 
$(document).ready(function(){
  $(".img-Lblasso").click(function(){$(this).addClass("hide"); $(".img-Lgdp").removeClass("hide");});
  $(".img-Lgdp").click(function(){$(this).addClass("hide"); $(".img-Lssvn").removeClass("hide");});
  $(".img-Lssvn").click(function(){$(this).addClass("hide"); $(".img-L1blasso").removeClass("hide");});
  $(".img-L1blasso").click(function(){$(this).addClass("hide"); $(".img-L1gdp").removeClass("hide");});
  $(".img-L1gdp").click(function(){$(this).addClass("hide"); $(".img-L1ssvn").removeClass("hide");});
  $(".img-L1ssvn").click(function(){$(this).addClass("hide"); $(".img-Lblasso").removeClass("hide");});

});
</script>

<script> 
$(document).ready(function(){
  $("button.blasso").click(function(){$(".mycode").addClass("hide"); $(".mycode.blasso").removeClass("hide");});
  $("button.gdp").click(function(){$(".mycode").addClass("hide"); $(".mycode.gdp").removeClass("hide");});
  $("button.ssvs").click(function(){$(".mycode").addClass("hide"); $(".mycode.ssvs").removeClass("hide");});
  $("button.func").click(function(){$(".mycode").addClass("hide"); $(".mycode.func").removeClass("hide");});
});
</script>
