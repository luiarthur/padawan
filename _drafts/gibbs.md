---
layout: gfm
dollar: yes
---

# Gibbs Sampler
- for *i = 1:B* (where *B* is a big number)
  - for *n = 1:N*
      - Suppose the current multiset is S<sub>*i,n*</sub> = {A, B, C, ... }, where A, B, C, ... are sets within the multiset
      - Remove observation *n* from all sets within S
          - notation: 
              - Let  S<sub>*i,-x*</sub> be the multiset S<sub>*i*</sub> after removing the element *x* from every set.
      - Do one of the following:
          1. Don't place observation *n* back in S<sub>*i,-n*</sub> with probability: **a** ??
          -  Place observation *n* into an existing set by with probability: **b<sub>1</sub>**, ..., **b<sub>k</sub>** ??
          -  Repeat 1-3 with {n} appended to S<sub>*i,-n*</sub>

# Example
- &sigma; = (1,2,3)
- D = equidistant &rArr; IBP
- for some i &isin; [1,B]
- *n = 2*
- S<sub>*i,-n*</sub> = { {1,2}, {1,2,3}, {2} }   &rArr; S<sub>*-i*</sub> = { {1}, {1,3} }
    - Do one of the following:
        1. { {1}, {1,3} } &rArr; { {1}, {1,3} }
        -  { {1}, {1,3} } &rArr; { {1,2}, {1,3} } or { {1}, {1,2,3} }, or { {1,2}, {1,2,3} }
        -  { {1}, {1,3} } &rArr; { {1}, {1,3}, {2} }
        -  { {1}, {1,3} } &rArr; { {1,2}, {1,3}, {2} } or { {1}, {1,2,3}, {2} }, or { {1,2}, {1,2,3}, {2} }
        -  { {1}, {1,3} } &rArr; { {1}, {1,3}, {2}, {2} }
        -  { {1}, {1,3} } &rArr; { {1,2}, {1,3}, {2}, {2} } or { {1}, {1,2,3}, {2}, {2} }, or { {1,2}, {1,2,3}, {2}, {2} }
        -  etc.

# Questions:
- With what probability do I go to each of the new states?
- What is that quantity heuristically / conceptually? 
    - Is it P(S<sub>*i_new,n*</sub> | S<sub>*i,-n*</sub>)?

