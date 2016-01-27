# Adv Bayes Computing (27 Jan, 2016)


### Generalized Double Pareto Prior (state of the art)

$\pi(\kappa) = \frac{1}{2(1-\kappa)^2}[\frac{\sqrt{\pi}\exp(-\kappa/[2(1-\kappa)])}{\sqrt{2\kappa(1-\kappa)}}\text{Erfc}(\sqrt{\frac{\kappa}{2(1-\kappa)}})-1]$, $0 < \kappa < 1$

Set $\alpha = \eta = 1$, not essential to put prior. Could also discretize $\eta$ and do Gibbs (aka Greedy Gibbs).

Computational advantages (for moderate $p < 5000$)

For a sparse model, $\mathcal A = \left\{ \beta_j: \beta_j \ne 0 \right\}$,
$$\lim_{n\rightarrow\infty}P(\mathcal A_{GDP} = \mathcal A_{True Model})=1A$$

Bayesian methods are not scalable compared to frequentist methods. Argue about other model traits.

Just want good prediction ($p=50000$)
$x_1,...,x_n$, 
$x_i$ is $p \times 1$
$\Phi x_i$ is $m \times 1$ (compress)

$y = \Phi x \beta + \epsilon$

$y = M \beta + \epsilon$

$M$ is $n \times m$

