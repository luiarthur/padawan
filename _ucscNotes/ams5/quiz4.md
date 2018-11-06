---
title: "Quiz 4 - Correlation"
date: 2016-04-27
ams: 5
comments: disqus
dollar: on
---


This is how you compute the correlation $r$ of two variables $x$ and $y$. 

|$x$ |$y$|
|:---:|:---:|
| 1 | 3 |
| 2 | 2 |
| 3 | 1 |
{: style="width:200px"}

- First, compute the [averages and SD's][^1] for $x$ and $y$.

| |$x$ |$y$|
|:---: |:---:|:---:|
|average | 2 | 2 |
|SD | $\sqrt\frac{2}{3}$ | $\sqrt\frac{2}{3}$ |
| |  |  |
{: style="width:200px"}

- Then, [standardize][^2] $x$ and $y$

|$z_x$ |$z_y$|
|:---:|:---:|
| $\frac{1-2}{\sqrt\frac{2}{3}} = -\sqrt\frac{3}{2}$ | $\frac{3-2}{\sqrt\frac{2}{3}} = \sqrt\frac{3}{2}$ |
| 0 | 0 |
| $\frac{3-2}{\sqrt\frac{2}{3}} = \sqrt\frac{3}{2}$| $\frac{1-2}{\sqrt\frac{2}{3}} = -\sqrt\frac{3}{2}$ |
{: style="width:200px"}

- Finall, multiple across the columns, add through the rows, and divide by the number of observations $n$

$$
\begin{array}{rcl}
  r &=& \ds\frac{\p{-\sqrt\frac{3}{2}}\p{\sqrt\frac{3}{2}} + (0)(0) + \p{\sqrt\frac{3}{2}}\p{-\sqrt\frac{3}{2}}}{3} \\
    &=& \ds\frac{ -\frac{3}{2} + 0 -\frac{3}{2} }{3} \\
    &=& \ds\frac{-3}{3} \\
    &=& \mathbf{-1} \\
\end{array}
$$

Therefore, the correlation between $x$ and $y$ is **-1**.

<br> <br>

---

#### Notes:
[^1]: If needed, please review your book learn how to compute average and SD. It will be on the test -- I guarantee it!
[^2]: To standardize an observation, $z = \frac{\text{observation - average}}{\text{SD}}$

