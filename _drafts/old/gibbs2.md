---
layout: gfm
dollar: on
---

<!-- in fact, P(&pi;<sub>0&rarr;j</sub>) = P(&pi;<sub>j</sub>) * dpois(0,&alpha;/2) *  (&sum;<sub>j &isin; [0,...,8]</sub> P(&pi;<sub>j</sub>))<sup>-1</sup>-->
<!-- then P(&pi;<sub>0&rarr;9</sub>) = P(&pi;<sub>9</sub>) * dpois(3,&alpha;/2) *  (&sum;<sub>j &isin; [0,...,8]</sub> P(&pi;<sub>j</sub>))<sup>-1</sup> -->
#Example
1. &sigma; = (1,2,3)
-  item to place: 2
-  current state &pi;<sub>0</sub>: { {1,2,3}, {1,2}, {3} }
-  current state after filtering item 2: { {1,3}, {1}, {3} }
-  exluding sets that ONLY contain item 2, there are 8=2^3 possible new states (because there are 3 unique and unrepeated sets in the filtered current state):
     -  &pi;<sub>1</sub>: { {1,3}, {1}, {3} }
     -  &pi;<sub>2</sub>: { {1,3}, {1}, {2,3} }
     -  &pi;<sub>3</sub>: { {1,3}, {1,2}, {3} }
     -  &pi;<sub>4</sub>: { {1,3}, {1,2}, {2,3} }
     -  &pi;<sub>5</sub>: { {1,2,3},   {1},   {3} }
     -  &pi;<sub>6</sub>: { {1,2,3},   {1}, {2,3} }
     -  &pi;<sub>7</sub>: { {1,2,3}, {1,2},   {3} }
     -  &pi;<sub>8</sub>: { {1,2,3}, {1,2}, {2,3} }
-  Let the probability of going from the current state &pi;<sub>0</sub> to &pi;<sub>j</sub> be P(&pi;<sub>0&rarr;j</sub>), where j &isin; [1,...,8]
-  P(&pi;<sub>0&rarr;j</sub>) &prop; P(&pi;<sub>j</sub>) * dpois(0,&alpha;/2)
-  in fact, $P(\pi\_{0 \rightarrow j}) = \frac{P(\pi\_j) * dpois(0,\alpha/2)}{\sum\_{j \in \\{1,...,8\\} } P(\pi_j) }$
-  Now we also need to consider the other possible new states (which are infinitely many). There are an infinitely countable number of sets, which can be "enumerated" by recursively attaching the set {2} to each of the &pi;<sub>j</sub>'s.
    - say the number of {2}'s we attach is 3, then the new set is &pi;<sub>9</sub> = { {1,2,3}, {1,2}, {2,3}, {2}, {2}, {2} }
    - then $P(\pi\_{0 \rightarrow 9}) = \frac{P(\pi\_9) * dpois(3,\alpha/2)}{\sum\_{j \in \\{1,...,8\\} } P(\pi_j) } $

# Questions:
1. Is this correct so far?
    -  If so, when &pi;<sub>0</sub> contains 10 unique sets, we have at least 1024 probabilities to compute, right?
