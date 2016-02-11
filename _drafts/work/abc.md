---
layout: post
title: Comparing Bayesian Regression Methods in High Dimension Settings
subtitle: UCSC AMS 268 Course Assignment 1
dollar: on
---

{::comment}
PUT THE INTRO HERE
{:/comment}

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
  models. Click the figure to change how the figure is sorted. Circles in red
  represent the RMSE of the SSVN model; circles in blue represent the RMSE of the
  Bayesian lasso model; and circles in green represent the RMSE the generalized
  double pareto prior model. 
</span>
</div>

<div id="rmse-tab">

|             |Bayesian Lasso|  GDP| SSVN|
|:-----------:|-------------:|----:|----:|
|Average RMSE |         0.926|1.029|3.989|

<span class="caption text-muted"> Table 1 </span>
</div>

From Table 1, we see averaged across the different simulated data sets, and across a variety of situations, the Bayesian lasso performs best (with lowest RMSE of 1.115). From Figure 1, we see that the SSVN performs the worst almost uniformly (with almost uniformly highest RMSE). The performance is worse as the number of predictors increases and becomes much greater than the number of observations. The utility of the SSVN, however, is in it's variable selection ability.The performance of the GDP prior model is almost as good as that of the Bayesian Lasso. It only sacrifices accuracy slightly to gain much flexibility. Note that in the case where none of the predictors were zero, the GDP prior model outperforms the Bayesian lasso model.

{::options parse_block_html="false" /}



{::comment} JavaScript {:/comment}
<script> 
$(document).ready(function(){
  $(".img-blasso").click(function(){$(this).addClass("hide"); $(".img-gdp").removeClass("hide");});
  $(".img-gdp").click(function(){$(this).addClass("hide"); $(".img-ssvn").removeClass("hide");});
  $(".img-ssvn").click(function(){$(this).addClass("hide"); $(".img-blasso").removeClass("hide");});
});
</script>
