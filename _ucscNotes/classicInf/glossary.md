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

**Convergence in Probability:** $\forall \epsilon \gt 0, \lim\_{n\rightarrow\infty} P(|X\_n-X|>\epsilon) = 0$. Usually, convergence in probability can be proved by Chebychev's inequality. Convergenve in probability always implies convergence in distribution.

- Note: $X\_n \overset{P}{\rightarrow} X \Rightarrow h(X\_n) \overset{P}{\rightarrow} h(X)$, for $h(\cdot)$ a continuous function.

**Chebychev's Inequality:** $\displaystyle P(|g(x) -\mu| \ge r)~\le~\frac{E(g(x))}{r}$

**Convergence in Distribution:** $\lim\_{n\rightarrow\infty} F\_n(x) = F(x)$, $F$ is continuous. Convergence in distribution to a constant implies convergence in distribution to the same constant.

**Weak Law of Large Numbers (WLLN):** $\bar X\_n \overset{P}{\rightarrow} \mu$

**CLT:** $\frac{\bar X\_n - \mu}{\sigma/n} \overset{D}{\rightarrow} N(0,1)$ 

**Slutsky's Theorem:** If $X\_n \overset{D}{\rightarrow} X$ and $ Y\_n \overset{D}{\rightarrow} a$, then

- $Y\_n X\_n \overset{D}{\rightarrow} aX$
- $X\_n + Y\_n \overset{D}{\rightarrow} X + a$

**Delta Method:** If $\sqrt{n}[Y\_n-\theta] \overset{D}{\rightarrow} N(0,\sigma^2)$ then
$$
  \sqrt{n}[g(Y\_n)-g(\theta)] \overset{D}{\rightarrow} N(0,\sigma^2[g'(\theta)]^2)
$$

## Data Reduction:

**Sufficient Statistic:** $T(x)$ is sufficient for $\theta$ $iff$ $\forall x$ in the sample space $p(x|T(x) = \frac{p(x|\theta)}{q(t|\theta)}$ is independent of $\theta$. (Not unique)

**Minimal Sufficient Statistic (mss):**  An mss $T(x)$ can be written as a function of any other sufficient statistic $T(x)$.

- Find mss using this **important** theorem: If $\frac{f(x|\theta)}{f(y|\theta)}$ is constant as a function of $\theta$ iff $T(x) = T(y)$, then $T(x)$ is mss.
- Use this to find mss for all distributions, as practice. (Remember to **prove both directions**)


**Ancillary Statistics:** A statistic $S(x)$ whose  distribution does not depend on the parameter of interest $\theta$ is an ancillary statistic. (No shortcuts, must calculate the pdf.)

  - The range is ancillary to the location parameter in location families
  - The ratio of two random variables in a scale family is ancillary to the scale parameter
  - Ancillary and sufficient statistics are not always independent 


**Complete Statistic:**

  - complete statistics are also minimal sufficient statistics (if they exist)
  - In the exponential family, $T\_k(X)$ is complete (as long as the parameter space $\Theta^d$ contains an open set in $\mathcal{R}^k$, i.e. d \le k)

**Basu's Theorem:** Complete mss are independent of every ancillary statistic.

**Factorization Theorem:** $f(x|\theta) = g(t|\theta) h(x)$ iff $T(x)$ is sufficient for $\theta$.

- Exercise: pick a distribution and find the sufficient statistic by identifying $g(.),h(.)$

