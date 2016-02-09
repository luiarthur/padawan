---
title: "Distributions"
date: 2016-01-08
comments: cucumber 
---

$$
\begin{array}{rcl}
  \text{Gamma(n,2)} &=&\chi^2_{2n} \\\\
  U \sim \text{Unif(0,1)} &\Rightarrow& -log(U) \sim \text{Exp(1)} \\\\
  \frac{\chi^2_p/p}{\chi^2_q/q} &\sim& F_{p,q} \\\\
  \frac{\text{N(0,1)}}{\sqrt{\chi^2_p/p}} &=& t_p \\\\
  (t_p)^2 &=& F_{1,p} \\\\
  \text{N(0,1)}^2 &=& \chi^2_1 \\\\
  \sum_{i=1}^n{\text{N(0,1)}^2} &=& \chi^2_n \\\\
  \frac{(n-1)S^2}{\sigma^2} &=& \chi^2_{n-1}, 
  \text{ where } S^2 = \frac{\sum_{i=1}^n {x_i-\bar x}}{n-1}\\\\
  X \sim \text{Gamma}(\alpha,\text{scale}=\beta) &\Rightarrow& \frac{1}{X} \sim \text{InvGamma}(\alpha,\beta^{-1}) \\\\
  \text{F(x)}   &\sim& \text{Unif(0,1)} \\\\
  \text{1-F(x)} &\sim& \text{Unif(0,1)} \\\\
  \text X \sim F_{p,q} &\iff& \frac{(p/q) X}{1+(p/q) X} \sim \text{Beta(p/2, q/2)} \\\\
  %\begin{cases}
  %    X   \sim \text{Bin(n,p)} \\\\
  %    Y\|X \sim \text{Beta(x, n-x+1)}
  %\end{cases}
  %&\Rightarrow& \text{P(X$\ge$x)} = \text{P(Y$\le\theta$)} \\\\
  \sum_{i=1}^n (x_i-\mu)^2 &=& \sum_{i=1}^n (x_i-\bar{x})^2 + n(\bar x-\mu)^2\\\\
  \Gamma(1/2) &=& \sqrt{2\pi}\\\\
  \sum_{i=1}^k N(\mu_i^2,1) &\sim& {\chi^2}_k(\sum_{i=1}^k \mu_i^2)\\\\
  \\\\
  \\\\
  aX_1 + bX_2 &\sim& N((a+b)\mu,(a^2+b^2)\sigma^2)\\\\
  AX + b &\sim& N(\mu+b,~A\Sigma A')\\\\
  E[\bf y | \bf x] &=& \mu_y + \Sigma_{yx}\Sigma_{xx}^{-1}(\bf x-\mu_x) \\\\
  cov[\bf y | \bf x] &=&  \Sigma_{yy} - \Sigma_{yx}\Sigma_{xx}^{-1}\Sigma_{xy} \\\\
\end{array}
$$


## Transformations

- If $h(Y) = X$, then $f_Y(y) = f_x[ h(y) ] \|h'(y)\|$
- If $X = g(U,V)$ and $Y = h(U,V)$, then 
$$ f_{U,V}(u,v) = f_{X,Y}(g(u,v),h(u,v))\norm{J},$$
where $J$ = 
$$
\begin{vmatrix}
  g_u & g_v \\\\
  h_u & h_v \\\\
\end{vmatrix}
$$

## Order Statistics

- $F_{X_{(j)}}(x) = P(Y\le j) = \displaystyle\sum_{k=j}^n {n\choose k}[F_X(x)]^k[1-F_X(x)]^{n-k}$
- $f_{X_{(j)}}(x) = \displaystyle \frac{n!}{(j-1)!(n-j)!}f_X(x)[F_X(x)]^{j-1}[1-F_X(x)]^{n-j}$
- $f_{X_{(i)},X_{(j)}}(u,v) = \displaystyle\frac{n!}{(i-1)!(j-1-i)!(n-j)!}f_X(u)f_X(v)[F_X(u)]^{i-1}[F_X(v)-F_X(u)]^{j-1-i}[1-F_X(v)]^{n-j}$, for $i \lt j$
- $f_{ X_{(1)} ,..., X_{(n)} } (x_1,...,x_n) = n! f_X(x_1) ... f_X(x_n)$
