---
title: "Distributions"
date: "01/08/2016"
comments: fb
---
$$
\\begin{array}{rcl}
  \text{Gamma(n,2)} &=&\chi^2\_{2n} \\\\
  U \sim \text{Unif(0,1)} &\Rightarrow& -log(U) \sim \text{Exp(1)} \\\\
  \frac{\chi^2\_p/p}{\chi^2\_q/q} &\sim& F\_{p,q} \\\\
  \frac{\text{N(0,1)}}{\sqrt{\chi^2\_p/p}} &=& t\_p \\\\
  (t\_p)^2 &=& F\_{1,p} \\\\
  \text{N(0,1)}^2 &=& \chi^2\_1 \\\\
  \sum\_{i=1}^n{\text{N(0,1)}^2} &=& \chi^2\_n \\\\
  \frac{(n-1)S^2}{\sigma^2} &=& \chi^2\_{n-1}, 
  \text{ where } S^2 = \frac{\sum\_{i=1}^n {x\_i-\bar x}}{n-1}\\\\
  X \sim \text{Gamma}(\alpha,\text{scale}=\beta) &\Rightarrow& \frac{1}{X} \sim \text{InvGamma}(\alpha,\beta^{-1}) \\\\
  \text{F(x)}   &\sim& \text{Unif(0,1)} \\\\
  \text{1-F(x)} &\sim& \text{Unif(0,1)} \\\\
  \text X \sim F\_{p,q} &\iff& \frac{(p/q) X}{1+(p/q) X} \sim \text{Beta(p/2, q/2)} \\\\
  %\begin{cases}
  %    X   \sim \text{Bin(n,p)} \\\\
  %    Y|X \sim \text{Beta(x, n-x+1)}
  %\end{cases}
  %&\Rightarrow& \text{P(X$\ge$x)} = \text{P(Y$\le\theta$)} \\\\
  \sum\_{i=1}^n (x\_i-\mu)^2 &=& \sum\_{i=1}^n (x\_i-\bar{x})^2 + n(\bar x-\mu)^2\\\\
  \Gamma(1/2) &=& \sqrt{2\pi}\\\\
  \sum\_{i=1}^k N(\mu\_i^2,1) &\sim& {\chi^2}\_k(\sum\_{i=1}^k \mu\_i^2)\\\\
  \\\\
  \\\\
  aX\_1 + bX\_2 &\sim& N((a+b)\mu,(a^2+b^2)\sigma^2)\\\\
  AX + b &\sim& N(\mu+b,~A\Sigma A')\\\\
  E[\bf y | \bf x] &=& \\mu\_y + \Sigma\_{yx}\Sigma\_{xx}^{-1}(\bf x-\mu\_x) \\\\
  cov[\bf y | \bf x] &=&  \Sigma\_{yy} - \Sigma\_{yx}\Sigma\_{xx}^{-1}\Sigma\_{xy} \\\\
\\end{array}
$$


## Transformations

- If $h(Y) = X$, then $f\_Y(y) = f\_x[ h(y) ] |h'(y)|$
- If $X = g(U,V)$ and $Y = h(U,V)$, then 
$$ f\_{U,V}(u,v) = f\_{X,Y}(g(u,v),h(u,v))|J|,$$
where $J$ = 
$
\begin{vmatrix}
  g\_u & g\_v \\\\
  h\_u & h\_v \\\\
\end{vmatrix}
$

## Order Statistics

- $F\_{X\_{(j)}}(x) = P(Y\le j) = \displaystyle\sum\_{k=j}^n {n\choose k}[F\_X(x)]^k[1-F\_X(x)]^{n-k}$
- $f\_{X\_{(j)}}(x) = \displaystyle \frac{n!}{(j-1)!(n-j)!}f\_X(x)[F\_X(x)]^{j-1}[1-F\_X(x)]^{n-j}$
- $f\_{X\_{(i)},X\_{(j)}}(u,v) = \displaystyle\frac{n!}{(i-1)!(j-1-i)!(n-j)!}f\_X(u)f\_X(v)[F\_X(u)]^{i-1}[F\_X(v)-F\_X(u)]^{j-1-i}[1-F\_X(v)]^{n-j}$
- $f\_{ X\_{(1)} ,..., X\_{(n)} } (x\_1,...,x\_n) = n! f\_X(x\_1) ... f\_X(x\_n)$
