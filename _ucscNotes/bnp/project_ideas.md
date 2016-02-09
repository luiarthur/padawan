---
title: Project Ideas
date: 2015-10-15
---

## Latent Dirichlet Allocation

### Model

$$ \begin{array}{rcl}
   x_{dw} &\sim& \text{Cat}_V(\mathbf\psi_{z_{dw}}),~ d=1...M, w=1...N_d \\\\
   z_{dw} &\sim& \text{Cat}_K(\mathbf\theta_d),~ d=1...M, w=1...N_d \\\\
   \mathbf\psi_k   &\sim& \text{Dir}_V(\mathbf\beta),~ k=1...K \text{ topics} \\\\
   \mathbf\theta_d &\sim& \text{Dir}_K(\mathbf\alpha),~ d=1...M \text{ documents} \\\\
\end{array} $$

where $V = \sum\_{d=1}^{M}N\_d$ is the total number of words.

### Posteriors

$$ \begin{array}{rclcl}
    \psi_k &|& \mathbf x &\sim& \text{Dir}( \beta+s_{1,k},..., \beta+s_{V,k}),~ k=1...K \\\\
  \theta_d &|& \mathbf Z &\sim& \text{Dir}(\alpha+t_{1,d},...,\alpha+t_{K,d}),~ d=1...M \\\\
\end{array} $$

where $s_{i,k}$ is the number of times the $i^{th}$ word in the *vocabulary* has *topic* $k$ 
(throughout all documents). And $t_{j,d}$ is the number of words in *document* $d$ with 
*topic* $j$.

<!--
  hard link: ln rel_path/to/lda.R; 
  soft link: ln -s rel_path/to/lda.R

  Soft links aren't allowed on Github.
  Difference: 
    - Soft links are just links (just contains the path)
    - Hard links are physical copies. You get a file that shares the same location.
    If you change original file, you change the hardlinked file, and vice versea.
-->
### R Code 
{% highlight R linenos %}
  {% include_relative code/project_ideas/lda/lda_hardlink %}
{% endhighlight %}

### HDP Tutorial & Applications (towards the end) by Michael Jordan
<iframe src="https://www.youtube.com/embed/PxgW3lOrj60" frameborder="0" allowfullscreen></iframe>
