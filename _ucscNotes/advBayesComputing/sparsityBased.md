---
title: Sparsity Based Methods
geometry: margin=1in
fontsize: 12pt
header-includes: 
    - \usepackage{bm}
    - \newcommand{\norm}[1]{\left\lVert#1\right\rVert}
    - \newcommand{\p}[1]{\left(#1\right)}
    - \newcommand{\bk}[1]{\left[#1\right]}
    - \newcommand{\bc}[1]{ \{#1\} }
    - \newcommand{\abs}[1]{ \left|#1\right| }
    - \newcommand{\mat}{ \begin{pmatrix} }
    - \newcommand{\tam}{ \end{pmatrix} }
---

In the GP, the covariance function is,

$$
  \tau^2 \exp\bc{-\phi \norm{s-s'}} = cov(\mu(s),\mu(s')) > 0
$$

- Complexity for predictive process: $O(m^3+m^2n)$, and only good if $m \approx \sqrt{n}$, so complexity is about $O(n^2)$.
- Complexity for GP: $O(n^3)$.

Matrix to invert is $$ K + \sigma^2I $$ has no zero-entries. In sparsity based methods, the goal is to sparsfy the matrix $K$ and employ sparse matrix. ($n\log(n)$)

Cannot randomly make entries in $K$ zero, because the matrix will lose positive definiteness. So, we use sparsity based methods.


## Compactly Supported Correlation Functions

$\kappa(s,s',\delta)$ s.t. $\kappa(s,s',\delta) =0$ iif $\norm{s-s'} > \delta$

For example:

- $\kappa(s,s',\delta) = \p{\bk{1-\frac{ \norm{s-s'}} {\nu}}_+}^4 \p{1+\frac{4\norm{s-s'}}{\nu}}$
- $\kappa(s,s',\delta) = \p{\bk{1-\frac{ \norm{s-s'}} {\nu}}_+}^2 \p{1+\frac{2\norm{s-s'}}{\nu}}$

Use Kolmogorov consistency theorem to show that the covariance functions are *valid*.

Suppose $\mu \sim GP(\cdot, \kappa(\cdot,\cdot,\theta))$. Instead of fitting $y = \mu(s) + \epsilon$ we fit

$$
  y_i = \mu(s_i)w(s_i) + \epsilon
$$

where 

$$
  w(s_1,...,s_n) \sim GP(0,\kappa_\delta(\cdot,\cdot))
$$

is a compactly supported correlation function.

## Sparsity Based Methods

$K_1$  is the $n\times n$ covariance matrix s.t. $K{1,ij} = cov(\mu(s_i)w(s_i),\mu(s_j)w(s_j))$

This is equal to $\kappa(s_i,s_j,\theta) \kappa_\delta(s_i,s_j)$, where $\delta$ is tuned, and $\theta$ are the hyperparameters.

So, $K_{1,ij} = 0$ or nonzero. Impose more sparsity in $K_1\Rightarrow$  choose smaller $\delta$.

### Sang(2012) JRSB

Instead of $y_i = \mu(s_i)w(s_i) + \epsilon$, loog at the residuals the predictive process 

$$y = \tilde{\mu}(s) + (\mu(s)-\tilde{\mu}(s))w(s) + \epsilon$$
$$y = \text{global structure} + (\text{local structure}) $$

where $\tilde{\mu}(s) = E[\mu(s) | \mu(s_1^*),...,\mu(s_m^*)]$. $\tilde{\mu}(s)$ is going  to capture the long range dependicies between observations, but destroys (interpolates) local structure. Not scalable for more than 10000 observations.


### Fuentes Moutse, Michael Stein

Suppose covariance function of this type (isotropic)

$$
  \tau^2 \exp\bc{-\phi \norm{s-s'}} = \kappa(s,s') = \kappa(\norm{s-s'}) = \kappa(d)
$$

$$
  \kappa(d) = \int~e^{-2\pi i \lambda}\psi(\lambda)~d\lambda
$$

where $\psi(\lambda)$ is the Fourier transform of $\kappa$. For the Matern Correlation, there is a closed form Fourier transform (look it up because instructor didn't remember). Do the analysis in Fourier domain, and then back transform with inverse Fourier.

Broadly,

1. Instead of the data domain, work in the Fourier domain.
2. Show cleverness in estimating $\psi(\lambda)$ efficiently.
3. Use inverse Fourier transform.

Not interpretable. But scalable.
