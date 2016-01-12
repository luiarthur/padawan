---
title: "Bayesian Inference Glossary"
date: "01/07/2015"
comments: fb
---

**Posterior Predictive:** $p(y^\*|y)$ = $\displaystyle
\int p(y^\*|\theta,y)~p(\theta|y)~d\theta$  
Note that the second portion in the integral is what we sample from (the posterior in this case), and the first portion is what we evaluate based on the sampled posterior to obtain our posterior predictive samples. Also, the first portion is the data generating mechanism, which is simply $p(y^\*|\theta)$ if the mechanism doesn't depend on previous draws (which isn't the case in a time series).

**Prior Predictive (a.k.a. Marginal):** $p(y^\*)$ = $\displaystyle
\int p(y^\*|\theta)~p(\theta)~d\theta$  

**Conjugate Prior:** A prior is conjugate if the posterior comes from the same distributional family as the prior. Note that if the likelihood is in the exponential family, there exists a conjugate prior (often from the exponential family). You can also find likelihoods that are not in the exponential family that have conjugate priors.

# Notes:
If $ p(x|\eta) $ is the sampling distribution in the natural exponential family, then the conjugate prior is 
$$
  \pi(\eta) = A(\nu,\mu)\exp\\{\sum\_{k=1}^K \mu\_k\eta\_k - \nu\psi(\eta) \\}
$$
where $\nu,\mu$ are hyperparameters.

$p(\eta|x) = \pi(\eta) p(x|\eta)$ is a family in the natural exponential family with 
$\tilde\nu = \nu+n$ and $\tilde{\mu}\_k = \mu\_k + \sum\_{i=1}^nt\_k(x\_i)$.

**Exercises:** 

- find the commonly used conjugate priors from the sampling distributions using this technique
- find the posterior / prior predictives using this technique
    - prior pred.: $p(y) = \displaystyle\frac{\prod\_{i=1}^n h(y\_i) A(\nu,\mu)}{A(\tilde\nu,\tilde\mu)}$
    - post. pred.: $p(y^\*|y) = \displaystyle\frac{h(y^\*) A(\tilde\nu,\tilde\mu)}{A(\tilde\nu+1,\tilde\mu+t(y^\*))}$
