---
layout: post
wide: on
title: Comparing Bayesian Regression Methods in High Dimension Settings
subtitle: UCSC AMS 268 Course Assignment 1
dollar: on
---

In my advanced Bayesian computation course this semester, we had to compare the performance of several modern regression models: lasso, rigdge, SSVN, Bayesian lasso, and generalized double pareto prior regression. To compare the performances, we were given some specifications for a simulation study. Here is are the specifications and what we wanted to investigate.

<center>
<object data="/assets/ams268/hw/hw1/instructions/hw1.pdf" type="application/pdf" width="900px" height="1000px">
</object>
</center>

## Comparing Competing Bayesian Models

The performances of three Bayesian models

- Stochastic Search Variable Selection (SSVN)
- Bayesian Lasso
- Generalized Double Pareto (GDP)

were compared using the RMSE of the posterior means for the coefficiencts $E[\pmb\beta\|\mathbf y]$. The findings are summarized in Figure 1 and Table 1. 

{::options parse_block_html="true" /}
<div id="rmse-fig">
#### RMSE sorted by various Bayesian Regression Models
{: style="text-align: center"}
![rmseblasso](/assets/ams268/hw/hw1/img/rmseblasso.png){: class="img-blasso"}
![rmseblasso](/assets/ams268/hw/hw1/img/rmsegdp.png){: class="img-gdp hide"}
![rmseblasso](/assets/ams268/hw/hw1/img/rmsessvn.png){: class="img-ssvn hide"}
<span class="caption text-muted"> 
  Figure 1: RMSE of Bayesian regression models sorted according to the various
  models. Click the figure to change how the figure is sorted. Triangles
  represent the RMSE of the SSVN model; circles represent the RMSE of the
  Bayesian lasso model; and crosses in green represent the RMSE the generalized
  double pareto prior model. 
</span>
</div>

<div id="rmse-tab">

|             |Bayesian Lasso|  GDP| SSVN|
|:-----------:|-------------:|----:|----:|
|Average RMSE |         0.314|0.372|0.584|

<span class="caption text-muted"> Table 1 </span>
</div>

From Table 1, we see averaged across the different simulated data sets, and across a variety of situations, the Bayesian lasso performs best (with lowest RMSE of 1.115). From Figure 1, we see that the SSVN performs the worst when all the coefficents are non-zero. The effect is increased when the variables are correlated. The utility of the SSVN, however, is in its variable selection ability.The performance of the GDP prior model in recovering the true value of the coefficients is in between that of the Bayesian lasso and the GDP prior model. It sacrifices accuracy slightly to gain much flexibility. Note that in the case where none of the predictors were zero, the GDP prior model does at least as good as the Bayesian lasso model.

{::options parse_block_html="false" /}


## Comparing Spike and Slab Prior Model and Lasso for Variable Selection

We investigate the performance of Lasso and the Spike and Slab prior model in this section. (From here on, we will use SSVN and spike and slab interchangeably because SSVN was used in the implementation.) For the SSVN model, a variable was counted as selected when the indicator $\gamma\_j$ for variable $j$ had a posterior mean greater than $.5$. The results are summarized in Figure 2 and Table 2. 

{::options parse_block_html="true" /}
<div id="lvs">
#### Lasso Vs. SSVN Prior Model
{: style="text-align: center"}
![lassoVssvn](/assets/ams268/hw/hw1/img/lassoVssvnPP.png){: class="img-lvsp"}
![lassoVssvn](/assets/ams268/hw/hw1/img/ssvnVlassoPP.png){: class="img-svlp hide"}
![lassoVssvn](/assets/ams268/hw/hw1/img/lassoVssvnFF.png){: class="img-lvsf hide"}
![lassoVssvn](/assets/ams268/hw/hw1/img/ssvnVlassoFF.png){: class="img-svlf hide"}
<span class="caption text-muted"> 
  Figure 2: Proportion of true positives (++) and true negatives (--) of variables being selected, according to Lasso (dot) and ssvn model (triangle). Click the image to see them sorted in different orders. 
</span>
</div>

<div id="lvs-tab">

|     | True Positive | True Negative |
|----:|--------------:|---------------:|
|Lasso| .7318 | .6325|
|SSVN | .7478 | .7225|

<span class="caption text-muted"> Table 2: True positives and true negatives averaged across all simulated models of variables being selected. </span>
</div>

From Table 2, we see that the SSVN models true positive rates (that is the proportion of times that the model selects a variable) is slightly higher than that of the lasso model. Also, the true negative rates were higher for SSVN.

{::options parse_block_html="false" /}



{::options parse_block_html="true" /}

#### Mzero Stuff
<div id="mzero">
{: style="text-align: center"}
![Lblasso](/assets/ams268/hw/hw1/img/Lblasso.png){: class="img-Lblasso"}
![Lgdp](/assets/ams268/hw/hw1/img/Lgdp.png){: class="img-Lgdp hide"}
![Lssvn](/assets/ams268/hw/hw1/img/Lssvn.png){: class="img-Lssvn hide"}
![L1blasso](/assets/ams268/hw/hw1/img/L1blasso.png){: class="img-L1blasso"}
![L1gdp](/assets/ams268/hw/hw1/img/L1gdp.png){: class="img-L1gdp hide"}
![L1ssvn](/assets/ams268/hw/hw1/img/L1ssvn.png){: class="img-L1ssvn hide"}
<span class="caption text-muted"> 
  Figure 3: 
</span>
</div>

{::options parse_block_html="false" /}


{::comment} JavaScript {:/comment}
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

