---
title: "Classical Inference Glossary"
date: "01/07/2015"
comments: fb
---

**Bias:** $E[\hat{\theta}] = \theta $

**Consistency:**

**Efficiency:**

**Exponential Family:** $p(x|\theta) = h(x)c(\theta)\exp\\{\sum\_{k=1}^K t\_k(x)w\_k(\theta)\\}$, where $K$ is the number of parameters (i.e. the dimensions of $\theta$).

**Natural Exponential Family:** 
$p(x|\eta) = h(x)\exp\\{\sum\_{k=1}^K \eta\_k t\_k(x) - \psi(\eta)\\}$, with **natural parameter** $\eta$, and **sufficient statistic** $\sum\_{k=1}^K t\_k(x)$.

# Notes

- If $X\_1,X\_2$ iid $N(\mu,\sigma^2)$, a, b constant. $aX\_1 + bX\_2 \sim N((a+b)\mu,(a^2+b^2)\sigma^2)$
- Multivariate Normal distribution
  - $AX + b \sim N(\mu+b,~A\Sigma A')$
  - Conditional normal
- $\Gamma(1/2) = \sqrt{2\pi}$
- Non-central $\chi^2$
  - $X\_1 \sim N(1,1)$, etc
  - $X\_1^2 \sim \chi^2\_1(1)$
