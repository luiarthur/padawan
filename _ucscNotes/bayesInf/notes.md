---
title: "Temp Notes"
date: "01/07/2015"
comments: fb
---

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
  - possible decision rule: $\delta(x) = x / n
