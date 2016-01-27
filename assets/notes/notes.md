# Adv Bayes Computing (27 Jan, 2016)


## Generalized Double Pareto Prior

$\pi(\kappa) = \frac{1}{2(1-\kappa)^2}[\frac{\sqrt{\pi}\exp(-\kappa/[2(1-\kappa)])}{\sqrt{2\kappa(1-\kappa)}}\text{Erfc}(\sqrt{\frac{\kappa}{2(1-\kappa)}})-1]$, $0 < \kappa < 1$

Set $\alpha = \eta = 1$, not essential to put prior. Could also discretize $\eta$ and do Gibbs (aka Greedy Gibbs).


