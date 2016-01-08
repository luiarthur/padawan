---
title: "Distributions"
date: "01/08/2015"
comments: fb
---
$$
\\begin{array}{rcl}
  \text{Gamma(n,2)} &=&\chi^2\_{2n} \\\\
  U \sim \text{Unif(0,1)} &\Rightarrow& -log(U) \sim \text{Exp(1)} \\\\
  \frac{\chi^2\_p/p}{\chi^2\_q/q} &\sim& F\_{n,m} \\\\
  \frac{\text{N(0,1)}}{\sqrt{\chi^2\_p/p}} &=& t\_p \\\\
  (t\_p)^2 &=& F\_{1,p} \\\\
  \text{N(0,1)}^2 &=& \chi^2\_1 \\\\
  \sum\_{i=1}^n{\text{N(0,1)}^2} &=& \chi^2\_n \\\\
  \frac{(n-1)S^2}{\sigma^2} &=& \chi^2\_{n-1}, 
  \text{ where } S^2 = \frac{\sum\_{i=1}^n {x\_i-\bar x}}{n-1}\\\\
  X \sim \text{Gamma}(\alpha,\beta) &\Rightarrow& \frac{1}{X} \sim \text{InvGamma}(\alpha,\beta^{-1}) \\\\
  \text{F(x)}   &\sim& \text{Unif(0,1)} \\\\
  \text{1-F(x)} &\sim& \text{Unif(0,1)} \\\\
  \text X \sim F\_{p,q} &\iff& \frac{\frac{p}{q} X}{1+\frac{p}{q} X} \sim \text{Beta(p/2, q/2)} \\\\
  \begin{cases}
      X \sim \text{Bin(n,p)} \\\\
      Y \sim \text{Beta(x, n-x+1)}
  \end{cases}
  &\Rightarrow& \text{P(X$\ge$x)} = \text{P(Y$\le\theta$)} \\\\
  \sum\_{i=1}^n (x\_i-\mu)^2 &=& \sum\_{i=1}^n (x\_i-\bar{x})^2 + n(\bar x-\mu)^2\\\\
\\end{array}
$$
