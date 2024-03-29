---
title: Pitman Yor Process & Resources
date: 2016-03-21
ams: 241
---

### Pitman-Yor Process

In the Dirichlet Process, DP($\alpha, G_0$), if $x_i$ represents observation $i$, $K_i$ is the number of unique labels before assigning observation $i$, $c_k$ represents the number of observations assigned to label $k$, and $u_k$ is the value for label $k$, then assign observation $i$ to be

$$
\begin{cases}
    x_i \sim G_0, & \text{w.p.} ~~ \ds\frac{\alpha}{\alpha+i-1} \\
    \\
    x_i = u_k, & \text{w.p.} ~~ \ds\frac{c_k}{\alpha+i-1}, \text{ for } k=1,...,K_i \\
\end{cases}
$$

In the Pitman-Yor Process, PYP($\delta,\alpha, G_0$), $\delta \in (0,1)$, $\alpha \gt -\delta$, 

$$
\begin{cases}
    x_i \sim G_0, & \text{w.p.} ~~ \ds\frac{\alpha+\delta K_i}{\alpha+i-1} \\
    \\
    x_i = u_k, & \text{w.p.} ~~ \ds\frac{c_k-\delta}{\alpha+i-1}, \text{ for } k=1,...,K_i \\
\end{cases}
$$

DP($\alpha,G_0$) = PYP($0,\alpha,G_0$). 
NSP($\delta,G_0$) = PYP($\delta,0,G_0$). NSP = Normalized Stationary Process.

So, in the normalized stationary process, NSP($\delta,G_0$), $\delta \in (0,1)$,

$$
\begin{cases}
    x_i \sim G_0, & \text{w.p.} ~~ \ds\frac{\delta K_i}{i-1} \\
    \\
    x_i = u_k, & \text{w.p.} ~~ \ds\frac{c_k-\delta}{i-1}, \text{ for } k=1,...,K_i \\
\end{cases}
$$

Note that in the NSP, the first observation is drawn from the centering distribution $G\_0$.


***

### Resources

- [Notes1]({{ "/assets/ams241/notes/notes-1_2.pdf" | prepend: site.baseurl }})
- [Notes2]({{ "/assets/ams241/notes/notes-2_6.pdf" | prepend: site.baseurl }})
- [Notes3]({{ "/assets/ams241/notes/notes-3.pdf" | prepend: site.baseurl }})
- [Notes on Convergence]({{ "/assets/ams241/notes/notes-convergence.pdf" | prepend: site.baseurl }})
- [Notes on Stochastic Processes]({{ "/assets/ams241/notes/notes-stoch-processes.pdf" | prepend: site.baseurl }})
- [References]({{ "/assets/ams241/notes/references_8.pdf" | prepend: site.baseurl }})

