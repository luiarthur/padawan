<span>**Dirichlet Process Mixture Models** [^1] </span>\
UCSC AMS 241 Homework 2\
\
Arthur Lui\

Location Normal DP Mixed Model
==============================

Pólya urn based Gibbs sampler
-----------------------------

Below is Pólya urn based Gibbs sampler. I will use the following
notation for convenience: $\stv = \tv$, $\stmi = \tmi$, and
$\stu = \tu$. $$p(\theta_i | \stmi, \alpha, \phi, \mu, \tau^2, y_i) = 
    \ds\frac{\alpha q_0}{\denom} h(\theta_i| \psi, \phi, y_i) + 
    \ds\sum_{j=1}^{n^{*-}}\frac{ n_j^- q_j }{\denom} \delta_{\theta_j^{*-}}(\theta_i)$$
where

-   $q_j = k(y_i | \theta_j^{*-},\phi)$, the Normal density with mean
    and variance $\theta_j^{*-}$ and $\phi$ evaluated at $y_i$.

-   $q_0 = \ds\int k(y_i | \theta, \phi) g_0(\theta | \mu, \tau^2) d\theta
        = [2\pi(\tau^2+\phi)]^{-1/2} 
        \exp\left\{
          \ds \left( \frac{y_i\tau^2 + \mu\phi}{\tau^2+\phi} \right)^2 -
          \ds \frac{y_i^2\tau^2 + \mu^2\phi}{2 \tau^2 \phi}
        \right\}$

-   $h(\theta_i| \psi, \phi, y_i) = c \cdot k(y_i | \theta_i, \phi) g_0(\theta_i | \mu, \tau^2)
        = k\left(\theta_i~\biggr|~\ds \frac{y_i\tau^2 + \mu\phi}{\tau^2+\phi},
        \ds\frac{\tau^2\phi}{\tau^2 + \phi} \right)$, where $c$ is a
    constant.

-   $g_0$, is the density of $G_0$ and is $k(\theta | \mu, \tau^2)$.

Model & Prior Specification
---------------------------

The hierearchical version of the DP mixture model of interest is
$$\begin{array}{rclcll}
  y_i &|& \theta_i,\phi &\overset{ind.}{\sim}& \text{N}(\theta_i, \phi), & i = 1,...,n\\
  \theta_i &|& G &\overset{i.i.d.}{\sim}&  G, & i = 1,...,n\\
  G &|& \alpha, \mu, \tau^2 &\sim& \text{DP}(\alpha, G_0=\text{N}(\mu,\tau^2))\\
    && \phi &\sim& \Gamma^{-1}(a_\phi,b_\phi) \\
    && \alpha &\sim& \Gamma(a_\alpha,b_\alpha) \\
    && \mu &\sim& \text{N}(a_\mu,b_\mu) \\
    && \tau^2 &\sim& \Gamma^{-1}(a_{\tau^2},b_{\tau^2}).\\
\end{array}$$ where $\Gamma^{-1}(a,b)$ denotes the inverse-Gamma
distribution with the associated density
$f(x) = \ds \frac{b^a}{\Gamma(a)} x^{-a-1} \exp\left(\frac{-b}{x}\right)$,
and we use the shape and *rate* parameterization for the Gamma
distribution.

We can write the complete conditions in closed form to be used in a
Gibbs sampler as follows. $$\begin{array} {rclcl}
  \phi &|& \stv, \y &\sim& \Gamma^{-1}\left(\ds\frac{n}{2}+a_\phi,\frac{\suml (y_i-\theta_i)^2}{2} + b_\phi \right)\\
  \\
  \mu &|& \stu, n^*, \y &\sim& \text{N}\left(\ds \frac{(n^*\bar{\stu}) b_\mu + a_\mu\tau^2}{n^*b_\mu + \tau^2},
    \ds\frac{b_\mu \tau^2}{n^* b_\mu + \tau^2} \right)\\
  \\
  \tau^2 &|& \stu, n^*, \y &\sim& \Gamma^{-1}\left(\ds\frac{n^*}{2}+a_{\tau^2},
    \frac{\sum_{j=1}^{n^*} (\theta_j^*-\mu)^2}{2} + b_{\tau^2} \right)\\
  \eta &|& \alpha, \y &\sim& \text{Beta}(\alpha+1,n) \\
  p(\alpha &|& n^*, \y) &=& (\epsilon)\text{gamma}(a_\alpha+n^*, b_\alpha-\text{log}(\eta)) +
    (1-\epsilon)\text{gamma}(a_\alpha+n^*-1, b_\alpha-\text{log}(\eta))\\
\end{array}$$ where $\eta$ is an auxiliary variable introduced to make
the prior for $\alpha$ conjugate.

[^1]: <https://github.com/luiarthur/bnp_hw/02_dp_priors>
