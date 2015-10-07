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

## R Code
{% highlight R linenos %}
  {% include code/ams241/project_ideas/lda/lda.R %}
{% endhighlight %}
