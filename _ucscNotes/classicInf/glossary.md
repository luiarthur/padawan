---
title: "Classical Inference Glossary"
date: 2016-01-07
comments: disqus
ams: 205
---

**Bias:** $E[\hat{\theta}] - \theta$

  - Note that by construction, method of moment estimators are unbaised for the moments.
  - Unbiasedness is not invariant to transformations.
  - The variances can be used to compare two estimators with the same bias.

**Consistency:** An estimator $\hat\theta\_n$ is consistent if $\hat\theta\_n\overset{P}{\rightarrow}\theta$
  
  - You can prove consistency typically in two ways:
    - using the definition of consistency (checking convergence in probability)
    - If $\lim E\brak{\hat\theta} = \theta$ and $\lim Var\brak{\hat\theta} = 0$, then $\hat\theta$ is consistent. That is, if the estimator is asymptotically unbiased and has zero variance, then it is consistent.


**Relative Efficiency:** $RE(\hat\theta\_n,\tilde\theta\_n) = \frac{V(\hat\theta\_n)}{V(\tilde\theta\_n)}$. 

**Asymptotic Relative Efficiency:** $ARE(\hat\theta\_n,\tilde\theta\_n) = \lim \frac{V(\hat\theta\_n)}{V(\tilde\theta\_n)}$. 

**Efficiency:**

**MSE:** MSE($\hat\theta$) = E$\brak{\paren{\hat\theta -\theta}^2}$ = $\text{Bias}(\hat\theta)^2 + \text{Var}(\hat\theta)$

**Exponential Family:** $p(x\|\theta) = h(x)c(\theta)\exp\\{\sum_{k=1}^K t_k(x)w_k(\theta)\\}$, where $K$ is the number of parameters (i.e. the dimensions of $\theta$).

**Natural Exponential Family:** 
$p(x|\eta) = h(x)\exp\\{\sum\_{k=1}^K \eta\_k t\_k(x) - \psi(\eta)\\}$, with **natural parameter** $\eta$, and **sufficient statistic** $\sum\_{k=1}^K t\_k(x)$.

**Convergence in Probability:** $\forall \epsilon \gt 0, \lim\_{n\rightarrow\infty} P(\abs{X\_n-X}>\epsilon) = 0$. Usually, convergence in probability can be proved by Chebychev's inequality. Convergenve in probability always implies convergence in distribution.

- Note: $X\_n \overset{P}{\rightarrow} X \Rightarrow h(X\_n) \overset{P}{\rightarrow} h(X)$, for $h(\cdot)$ a continuous function.

**Chebychev's Inequality:** $\displaystyle P( \abs{g(x) -\mu} \ge r)~\le~\frac{E(g(x))}{r}$

**Convergence in Distribution:** $\lim\_{n\rightarrow\infty} F\_n(x) = F(x)$, $F$ is continuous. Convergence in distribution to a constant implies convergence in distribution to the same constant.

**Weak Law of Large Numbers (WLLN):** $\bar X\_n \overset{P}{\rightarrow} \mu$

**CLT:** $\frac{\bar X\_n - \mu}{\sigma/\sqrt n} \overset{D}{\rightarrow} N(0,1)$ 

**Slutsky's Theorem:** If $X\_n \overset{D}{\rightarrow} X$ and $ Y\_n \overset{D}{\rightarrow} a$, then

- $Y\_n X\_n \overset{D}{\rightarrow} aX$
- $X\_n + Y\_n \overset{D}{\rightarrow} X + a$

**Delta Method:** If $\sqrt{n}[Y\_n-\theta] \overset{D}{\rightarrow} N(0,\sigma^2)$ then
$$
  \sqrt{n}[g(Y_n)-g(\theta)] \overset{D}{\rightarrow} N(0,\sigma^2[g'(\theta)]^2)
$$

## Data Reduction:

**Sufficient Statistic:** $T(x)$ is sufficient for $\theta$ iff $\forall x$ in the sample space $p(x\|T(x)) = \frac{p(x\|\theta)}{q(t\|\theta)}$ is independent of $\theta$. (Not unique)

**Minimal Sufficient Statistic (mss):**  An mss $T(x)$ can be written as a function of any other sufficient statistic $T(x)$.

- Find mss using this **important** theorem: If $\frac{f(x\|\theta)}{f(y\|\theta)}$ is constant as a function of $\theta$ iff $T(x) = T(y)$, then $T(x)$ is mss.
- Use this to find mss for all distributions, as practice. (Remember to **prove both directions**)


**Ancillary Statistics:** A statistic $S(x)$ whose  distribution does not depend on the parameter of interest $\theta$ is an ancillary statistic. (No shortcuts, must calculate the pdf and show that it is constant w.r.t. $\theta$.)

  - The range is ancillary to the location parameter in location families
  - The ratio of two random variables in a scale family is ancillary to the scale parameter
  - Ancillary and sufficient statistics are not always independent 


**Complete Statistic:** Let $f(t\|\theta)$ be a family of pdfs or pmfs for a statistic $T(x)$ (i.e., $T(x)$ is a statistic / transformation of the data: mean, sd, etc.). If $E\_{t\|\theta}[g(T)] = 0 $ for all $\theta$ implies that $P(g(T)=0) = 1$ for all $\theta$, then $T(x)$ is a complete statistic.

  - complete statistics are also minimal sufficient statistics (if they exist)
  - In the exponential family, $T\_k(X)$ is complete (as long as the parameter space $\Theta^d$ contains an open set in $\mathcal{R}^k$, i.e. $d \le k$)
  - Note: $\frac{d}{d\theta} \int\_0^\theta~g(t)~dt = G'(\theta) - G'(0) = g(\theta) - g(0)$, if $g$ is Riemman integrable.

**Basu's Theorem:** Complete mss are independent of every ancillary statistic. 

  - Example 6.2.26 is an interesting example

**Factorization Theorem:** $f(x\|\theta) = g(t\|\theta) h(x)$ iff $T(x)$ is sufficient for $\theta$.

- Exercise: pick a distribution and find the sufficient statistic by identifying $g(.),h(.)$

**Hessian:** In computing the MLE, the second derivative equivalent in bivariate case is the Hessian matrix H: Matrix of second derivatives. Evaluate $H=H(\hat\mu,\hat\phi)$ and check that it has all negative eigenvalues. True for higher dimensions.
$$ H = 
\left(
  \begin{matrix}
    l_{\mu\mu} & l_{\mu\phi} \\\\
    l_{\phi\mu} & l_{\phi\phi} \\\\
  \end{matrix}
\right)
$$

**Invariance of MLE:** Let mle of a function of a parameter is the function of the mle of the parameter.

**Satterwhite Approximation:** Approximating $Z = \sum a\_i Y\_i$, $Y\_i \sim \chi^2\_{r\_i}$.

- Approx with $Z \approx \chi^2\_{\nu}/\nu$
- $E(Z) = \sum a\_i r\_i \approx E(\chi^2\_\nu/\nu) = 1$
- find $E(Z^2)$ then solve for $\nu$.
- Finally, $\tilde\nu = \frac{2}{(\sum a\_i Y\_i)^2-1}$

### Statistics Joke:
Three statisticians go hunting in a forest. The first one shoots one meter to the left; the other shoots one meter to the right. The third statistician says, "we got it!"

UMVUE
: Uniformly Minimum Variance Unibaised Estimator  

Cramer-Rao Lower Bound
: Let $$x_1,...,x_n$$ be a sample with pdf $$f(\pmb x|\theta)$$ and let
$W(\pmb x)$ be any function satisfying 

1.  $$\frac{d}{d\theta} \int_\mathcal{X}~W(x)f(x|\theta) ~dx = \int_\mathcal{X}~\frac{d}{d\theta}W(x)f(x|\theta) ~dx$$
2. $$Var(W(x)) \lt \infty$$

then, 

$$Var(W(x)) \ge \frac{ \brak{\frac{d}{d\theta}E_{x|\theta}(W(x))}^2 }{E_{x|\theta}\paren{\paren{\frac{d}{d\theta}\log f(x|\theta)}^2}}$$

Rao-Blackwell
: Let $W = W(x)$ be an unbiased estimator of $\tau(\theta)$, and let $T$ be a sufficient statistic for $\theta$. Define $\phi(T) = E(W\|T)$. Then $E(\phi(T)) = T(\theta)$ and $Var(\phi(T)) \le Var(W)$ for all $\theta$.

Theorem
: UMVUE's are unique

Theorem
: Let $T$ be a complete sufficient statistic for $\theta$, and let $\phi(T)$ be any estimator of $\theta$ based on $T$. Then $\phi(T)$ is the unique best unbiased estimator of its expected value.

Theorem (for checking an estimator is not UMVUE)
: If $E\_{x\|\theta}(W)=\tau(\theta)$ $W$ is the best unbiased estimator for $\tau(\theta)$ iff $W$ is uncorrelated with all unbaised estimators of 0. (i.e. $Corr(W,W^\*)=0$, where $E[W^\*]=0$.)

### EM (Expectation-Maximization) Algorithm

- Let $Y$ = "incomplete" data (observed)
- Let $X$ = "augmented" data (unobserved)
- Let $(X,Y)$ = "complete" data
- Then $p(x,y \| \lambda)$ is supposedly the likelihood
- And  $p(x \| y,\lambda) = \frac{p(x,y \| \lambda)}{p(y \| \lambda)}$ 
  - Startwith some $\lambda^0$, and sequentially compute: $\lambda^{(i)} = \underset{\lambda}{argmax} E[\log P(x,y \| \lambda) \| \lambda^{(i-1)}, y]$

### Hypothesis testing 

Likelihood Ratio statistic
: $$\lambda(x) = \frac{\underset{\theta\in H_0}{sup} L(\theta;x,y)}{\underset{\theta\in H_0 \cup H_a}{sup} L(\theta;x,y)}$$
reject when $\lambda \lt c$ where $c$ is small

Power Function
: The power function of a hypothesis test with rejection region $R$ is the function of the parameter $\theta$ defined by $$\beta(\theta) = P_\theta(X\in R)$$. When $$\theta = \theta_0$$, $$\beta(\theta) = \alpha$$. Yes, confusing nomenclature.

| |Reject Null | Accept Null |
|---|---|---|
| Null is True | Type I error | ok |
| Null is False| ok | Type II error |

Type I  error $$=\beta(\theta_0) = \alpha$$ 
Type II error, could be infemum of power, or $$1-\beta(\theta_1) = 1-\gamma$$

Most Powerful Test
: Let $G$ be a class of tests for testing $$H_0:\theta\in\Theta_0$$ vs $$H_a:\theta\in\Theta_0^C$$. A test in class $G$ with power function $\beta(\theta)$ is a uniformly most powerful (UMP) class $G$ test if $\beta \ge \beta'(\theta)$ for every $\theta\in\theta^C$ and every $\beta'(\theta)$ that is a power function of a test in class $G$.

Neyman-Pearson lemma (simple-simple)
: Consider testing $$H_0: \theta=\theta_0$$ vs $$H_1: \theta=\theta_1$$ where the pdf or pmf is $f(x \| \theta\_i)$, $i=0,1$, using a test with rejection region

$$
  \begin{array}{lcl}
    X \in R   &\text{if}& f(x|\theta_1) \gt kf(x|\theta_0) \\
    X \in R^C &\text{if}& f(x|\theta_1) \le kf(x|\theta_0) \\
  \end{array}
$$

for some ($k\ge0$) such that $\alpha = \beta(\theta\_0)$. Then

1. Sufficiency: Any test that satisfies this is a UMP level $\alpha$ test.
2. Necessity: If there is a test satisfying these conditions with $k\gt 0$, then every UMP level $\alpha$ test is a size $\alpha$ and every UMP level $\alpha$ test satisfies the structure of the rejection region except perhaps on a set $A$ satisfying $$P_{\theta_0}(X\in A) = P_{\theta_1}(X\in A) = 0$$.

Monotone Likelihood Ratio tests
: A family of pdfs or pmfs $\brac{g(t\|\theta): \theta\in\Theta}$ for a univariate random variable $T$ with real valued parameter $\theta$ has a monotone likelihood ratio (MLR) if $\forall(\theta\_2 \gt \theta\_1)$, $\frac{g(t\|\theta\_2)}{g(t\|\theta\_1)}$ is a monotone function of $t$. 

Karlin-Rubin Theorem
: Consider testin $$H_0: \theta \lt \theta_0$$ vs $$H_1: \theta \gt \theta_0$$. Suppose that $T$ is a sufficient statistic for $\theta$ and the family of pdfs or pmfs $\brac{g(t\|\theta): \theta\in\Theta}$ of $T$ has a MLR. Then for any $t\_0$, the test that rejects $H\_0$ iff $T\gt t\_0$ is a UMP level $\alpha$ test where $\alpha = P\_{\theta\_0}(T\gt t\_0)$

p-value
: A p-value $p(x)$ is a *test statistic* satisfying $0\le p(x) \le 1$ for every sample $x$. Small values of $p(x)$ give evidence that $H\_1$ is true. A p-value is called valud if for every $\theta \in \Theta\_0$ and every $0 \lt \alpha \lt 1$, $P\_{\theta}(p(x) \lt \alpha) \le \alpha$

When the distribution of the test statistic is not available in closed form, we can

1. use asymptotics
2. permutation test

Wilk's Theorem
: For testing $H\_0: \theta = \theta\_0$ vs $H\_1: \theta \ne \theta\_0$ suppose $x\_1,...,x\_n$ are iid from $f(x\|\theta)$, $\hat\theta$ is the MLE and $f$ satisfies regularity conditions. Under the null hypothesis, as $n \rightarrow \infty$,

$$
  -2 log(\lambda) \overset{D}{\rightarrow} \chi_1^2
$$

More generally, if $H\_0 \in \Theta\_0$ vs $H\_1 \in \Theta\_0^C$ then

$$
  -2 log(\lambda) \overset{D}{\rightarrow} \chi_d^2
$$

where $d=dim(\Theta) - dim(\Theta\_0)$

<!-- comment
The TRUMP test
: if you are Donald Trump, then you are uniformly most powerful. Otherwise, you're a loser. In other words, you're fired.
-->

Permutation test
: if under the null the distribution of the data is invariant under the action of permutations, the distribution of statistics can be easily computed.

### Example

$ X\_1,...,X\_n \sim F\_1$ and $ Y\_1,...,Y\_n \sim F\_2$. $H\_0: F\_1 = F\_2$ vs $H\_1: F\_1 \ne F\_2$.

We can test this by randomly relabelling the samples and testing to see if the distributions are the same by seeing if some statistic of the difference of the distributions $Z = g(X) - g(Y)$ is different from 0.

Wald Likelihood Test
: Under large samples, we can test the two-sided hypothesis $H\_0: \theta=\theta\_0$ vs. $H\_1: \theta\ne\theta\_0$ (not necessarily bidirectional, can be simply greater than or less than)  with the statistic

$$
  Z_n = \frac{\hat\theta-E[\hat\theta]}{\sqrt{Var\p{\hat\theta}}} = \frac{W_n - \theta_0}{S_n}
$$

Note that when $W\_n$ is the mle and $S_n$ is the $\frac{1}{\sqrt{I(W\_n)}}$, $Z\_n \overset{D}{\rightarrow} N(0,1)$. We can also substitute $\sqrt{Var(\hat\theta)}$ with $se(\hat\theta)$. Using $se(\hat\theta)$ is often easier when inverting a test, and that is used most often in intro stats courses. The wald test is an approximate test. Using a wald test and inverting it to get a confidence interval may show up in the first year exam. (Try doing this for all exponential family distribution models.)

Interval Estimation
: An interval estimate of a real-valued parameter $\theta$ is any pair of functions $L(X)$ and $U(X)$ of a sample that satisfies $L(X) \lt U(X)$ for all $X$ in the sample space. If $X$ is observed the implied inference is that $L(X) \lt \theta \lt U(X)$. Note that here, $X$ is a random variable. 

Confidence Coefficient
: $\underset{\theta}{\text{inf}}~P\_\theta(\theta \in (L(X), U(X)) )$

Pivot
: Intervals that are based on point estimators whose distribution does not depend on the parameters of the model.

Test Inversion
: Like probability that confidence interval contains the hypothesized value. The test is constructed such that it will have the desired coverage.

Under regularity conditions (see below), if $x\_i$ are iid $f(x\_i\v\theta)$ and $\hat{\theta}\_n$ are the MLE's for $\theta$ then

$$
  \frac{\hat\theta - \theta}{\sqrt{Var(\hat\theta)}} \overset{D}{\rightarrow} N(0,1) ~~ \text{assymptotically Normal}
$$

and 

$$
  \hat\theta \overset{P}{\rightarrow} \theta ~~ \text{consistent}
$$

**Regularity Conditions**

1. iid observations
2. Identifiability of parameters (i.e. $\theta \ne \theta' \Rightarrow f(x\v\theta) \ne f(x\v\theta'), \forall x$)
3. $f(x\v\theta)$ to have the same support for every $\theta$ (support does not depend of parameter) and be differentiable in $\theta$.
4. The parameter space contains an open set $\omega$ of which the true value of the parameter $\theta\_0$ is an interior point. (true parameter is not on the boundaries of the parameter space.)
5. For every $x$ the density $f(x\v\theta)$ is three times differentiable wrt $\theta$, the thrid derivatie is continuous in $\theta$ andd $\int f(x\v\theta) dx$ can be differentiated 3 times under the integral sign.
6. For any $\theta\_0$ there exists a positive number $c$R and a function $M(x)$ (both of which can depend on $\theta\_0$) such that the $\abs{\frac{\partial^3}{\partial\theta^3}\log f(x\v\theta)} \le M(x)$ for $\theta\_0-c \lt \theta \lt \theta\_0+c$ with $E\_{x\v\theta}(M(x)) \lt \infty$

Consistency requies 1-4. Normality requires 1-6.

Likelihood Profile
: A likelihood of the form $L(\theta\_1,\hat\theta\_0(\theta\_1))$. Where $\hat\theta\_0(\theta\_1)$ are the MLE's for a set of parameters $\theta\_0$ evaluated (in closed form) based on some parameters  $\theta\_1$(for which the MLE's cannont be found in closed form).

### Parametric Bootstrap

For a likelihood $f$,

1. Draw $y\sim f(y\v\hat\theta\_{MLE})$
2. For $b = 1:B$
    - $y^{(b)} \sim f(y\v\hat\theta\_{MLE})$
    - Compute $\hat\theta\_{MLE}(y^{(b)})$

### Nonparametric Bootstrap

Sample data of size $n$ with replacement, fit model, get estimates.

***

# Possible Projects

- Comparing Newton Raphson, SGD, and GD for finding MLE of a (generalized) linear model
    - speed and difficulty
    - review EM


