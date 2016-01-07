---
title: "Bayesian Inference Glossary"
date: "01/07/2015"
comments: fb
---

**Posterior Predictive:** $p(y^\*|y)$ = $\displaystyle
\int p(y^\*|\theta,y)~p(\theta|y)~d\theta$  
Note that the second portion in the integral is what we sample from (the posterior in this case), and the first portion is what we evaluate based on the sampled posterior to obtain our posterior predictive samples. Also, the first portion is the data generating mechanism, which is simply $p(y^\*|\theta)$ if the mechanism doesn't depend on previous draws (which isn't the case in a time series).

**Prior Predictive:** $p(y^\*)$ = $\displaystyle
\int p(y^\*|\theta)~p(\theta)~d\theta$  

**Conjugate Prior:** A prior is conjugate if the posterior comes from the same distributional family as the prior. Note that if the likelihood is in the exponential family, there exists a conjugate prior (often from the exponential family). You can also find likelihoods that are not in the exponential family that have conjugate priors.

