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

**Conjugate Prior:** A prior is conjugate if the posterior comes from the same distributional family as the prior. Note that if the likelihood is in the exponential family, there exists a conjugate prior (often from the exponential family). You can also find likelihoods that are not in the exponential family that have conjugate priors (e.g. Uniform likelihood, Pareto prior). You can also get non-conjugate priors with closed form posteriors (e.g. Normal likelihood, Laplace prior, used in LASSO).

**Mixtures of conjugate priors are conjugate**

# Notes:
## Finding Conjugate Priors
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

## Computing Normal Mixtures using Linear Models (much easier)
$p(x) = \displaystyle\int\prod\_{i=1}^n N(x\_i;\theta,\sigma^2) N(\theta;\mu,\tau^2)d\theta$  
Notice that:

- $x\_i = \theta + \epsilon\_i$, $\epsilon\_i \sim N(0,\sigma^2)$
- $\theta = \mu + \delta$, $\delta \sim N(0,\tau^2)$

So,  
$ \mathbf x = \mathbf 1 \theta + \mathbf\epsilon $  
$ \mathbf x = \mathbf 1 (\mu+\delta) + \mathbf\epsilon $  
E[$ \mathbf x$] = $\mathbf 1 \mu$  
V[$ \mathbf x$] = $\tau^2 \mathbf{1'1} + \sigma^2 I\_n$  
V[$ \mathbf x$] = $n\tau^2 + \sigma^2 I\_n$  

OR:  
if $X | \theta \sim N(\theta,\sigma^2 I\_n)$  
and $\theta|\mu,\tau^2 \sim N(\mu,\tau^2)$  
$E[X] = E[E[X | \theta]] = E[\theta] = \mu$  
$V[X] = E[V[X | \theta]] + V[E[X | \theta]] = E[\sigma^2] + V[\theta] = \sigma^2 I\_n + 1'1\tau^2 = n\tau^2 + \sigma^2 I\_n$

## Decision Theory
Notation:

1. $a \in A$: $a$ is an "action" and $A$ is the set of all possible actions
2. $L(\theta,a)$: loss function for $\theta \in \Theta$ and $a\in A$, $L(\theta,a) \ge -K \gt -\infty$
  - useful loss functions:
    - Quadratic loss: $(\theta-a)^2$
    - Absolute loss: $|\theta-a|$
    - 0-1 loss: $I(\theta \ne a)$
3. $\delta(x)$: decision rule, function from $X$ to $A$, $X$ is the sample space

### Example:
- Drug company needs to market a new pain killer:
  - $\theta$: proportion of the market that the drug will capture
  - $\theta \in \Theta = [0,1]$, at $A =[0,1]$
  - $L(\theta,a) = \theta-a \text{ if } \theta\ge a$
  - $L(\theta,a) = 2(a-\theta) \text{ if } \theta\lt a$
- Survey of $x$ peolpe out of $n$ responded "yes" 
  - possible model $x|n \sim Bin(n,\theta)$
  - possible decision rule: $\delta(x) = x / n$
