---
title: "Quiz 1 - Averages, Medians, and Standard Deviations"
date: 2016-09-28
ams: 5
---

Here is recap on how to compute averages, medians and standard deviations.

In each of these examples, suppose a **sample** 

$$(x_1,x_2,...,x_n)$$ 

of size $n$ is observed.

---

## Definitions

Average
: 
$$
\bar{\mathbf x} = \ds\frac{x_1 + x_2 + ... + x_n}{n}
$$ 

= sum of observations divided by number of observations.

---

Standard Deviation (SD)
: 
$$
SD\p{\mathbf x} = \ds\sqrt\frac{(x_1-\bar{x})^2 + (x_2-\bar{x})^2 + ... + (x_n-\bar{x})^2}{n}
$$

where $\bar{x}$ is the average. (From here on, standard deviation and the abbreviation SD will be used interchangeably.)

---

Median
: The observation in the middle **after sorting**.

Say $(x_{(1)},...,x_{(n)})$ is a sorted sample such that
$x_{(1)}$ is the minumum and $x_{(n)}$ is the maximum, the
median of the sample is

$$
\begin{cases} 
x_{(\frac{n+1}{2})} & \text{,  if $n$ is odd} \\
\ds\frac{x_{(\frac{n}{2})} + x_{(\frac{n+1}{2})}}{2}& \text{, if $n$ is even}
\end{cases}
$$

## Examples:

We will now concretize what we've defined with examples.
Say we have observed the following sample (of size 5)
which represent the quiz scores of 5 students in AMS5:

$$ (3,2,4,5,1) $$

Compute the 

1. average of the sample
2. sd of the sample
3. median of the sample

### Solutions:

1. First, note that $n=5$. So, the **average** = 
   $\frac{3+2+4+5+1}{5} = \mathbf 3$.
2. We have already computed the average to be 3. So, substitute
   $\bar{x}$ with 3. Then,

   $$
   \begin{array}{rcl}
   SD &=& \ds\sqrt\frac{(3-3)^2 + (2-3)^2 + (4-3)^2 + (5-3)^2 + (1-3)^2}{5} \\
      &=& \ds\sqrt\frac{0^2 + (-1)^2 + (1)^2 + (2)^2 + (-2)^2}{5} \\
      &=& \ds\sqrt\frac{0 + 1 + 1 + 4 + 4}{5} \\
      &=& \ds\sqrt\frac{10}{5} \\
      &=& \sqrt 2 \\
      &\approx& 1.414
   \end{array}
   $$
3. To compute the median, first order the data:

   $$(3,2,4,5,1) \rightarrow (1,2,3,4,5)$$

   Then, the median is sorted observation number 
   $\frac{5+1}{2} = 3$. The third observation (sorted)
   also happens to be 3. So 3 is the median.

   - Here is a second example for medians. Say the
     sample was instead 

     $$(3,5,7,2,6,9)$$

     Now we have an even number of observations.
     First, sort the data. The sorted observations
     are 

     $$(2,3,5,6,7,9)$$

     The median is now the average of the $3^{rd}$ and $4^{th}$
     observations which is $\frac{5+6}{2} = \mathbf{5.5}$
