---
title: "Normal Approximation"
date: 2016-02-24
comments: cucumber
---

## Drawing stuff from a box

| | |EV|SE|
|:---|:---|:---|:---|
|**Proportions** |sum  |$p\times n$| $\sqrt{p(1-p)}\times \sqrt{n}$|
|            |mean |$p$|$\sqrt{p(1-p)} / \sqrt{n}$ |
|**Means**       |sum  |$\bar{x} \times n$|$\displaystyle\sqrt{\frac{(x\_1-\bar{x})^2+...+x\_n-\bar{x})^2}{n}} \times \sqrt{n}$|
|            |mean |$\bar{x}$|$\displaystyle\sqrt{\frac{(x\_1-\bar{x})^2+...+x\_n-\bar{x})^2}{n}} / \sqrt{n}$|

Note that the Standard Errors (SE) are computed from the standard deviation of the box (one draw from the box).

***

## Confidence Intervals

A confidence interval is computed as follows:

$$
  \text{CI} = \text{estimate} \pm z^* \times \text{SE}
$$

So, the $95\%$ confidence interval for a **mean** is:

$$
  \bar{x} \pm 1.95 \times \frac{s}{\sqrt{n}}, \text{ where } s = \displaystyle\sqrt{\frac{(x_1-\bar{x})^2+...+x_n-\bar{x})^2}{n}}
$$

and the $95\%$ condifence intercal for a **proportion** is:

$$
  p \pm 1.95 \times \frac{\sqrt{p(1-p)}}{\sqrt{n}}
$$
