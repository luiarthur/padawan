---
layout: notes
ams: 241
title: Project Ideas
date: "10/15/2015"
dollar: on
---

# Latent Dirichlet Allocation

## Model
$$ \begin{array}{rcl}
   x\_{dw} &\sim& \text{Cat}\_V(\mathbf\psi\_{z\_{dw}}),~ d=1...M, w=1...N\_d \\\\
   z\_{dw} &\sim& \text{Cat}\_K(\mathbf\theta\_d),~ d=1...M, w=1...N\_d \\\\
   \mathbf\psi\_k   &\sim& \text{Dir}\_V(\mathbf\beta),~ k=1...K \text{ topics} \\\\
   \mathbf\theta\_d &\sim& \text{Dir}\_K(\mathbf\alpha),~ d=1...M \text{ documents} \\\\
\end{array} $$
where $V = \sum\_{d=1}^{M}N\_d$ is the total number of words.

## Posteriors
$$ \begin{array}{rclcl}
    \psi\_k &|& \mathbf x &\sim& \text{Dir}( \beta+s\_{1,k},..., \beta+s\_{V,k}),~ k=1...K \\\\
  \theta\_d &|& \mathbf Z &\sim& \text{Dir}(\alpha+t\_{1,d},...,\alpha+t\_{K,d}),~ d=1...M \\\\
\end{array} $$
where $s\_{i,k}$ is the number of times the $i^{th}$ word in the *vocabulary* has *topic* $k$ 
(throughout all documents). And $t\_{j,d}$ is the number of words in *document* $d$ with 
*topic* $j$.

## R Code
{% highlight R linenos %}
  {% include code/ams241/project_ideas/lda/lda.R %}
{% endhighlight %}

## HDP Tutorial & Applications (towards the end) by Michael Jordan
<iframe src="https://www.youtube.com/embed/PxgW3lOrj60" frameborder="0" allowfullscreen></iframe>
