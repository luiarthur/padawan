---
layout: gfm
dollar: yes
---

# Gibbs Sampler
- for *i = 1:B* (where *B* is a big number)
  - for *n = 1:N*
      - Suppose the current multiset is S<sub>*i*</sub> = {A, B, C, ... }, where A, B, C, ... are sets within the multiset
      - Remove observation *n* from all sets within S
          - (notation: Let  A<sub>[-*x*]</sub> be the set A after removing element *x*.)
      - Do one of the following:
          1. Don't place observation *n* back in S with probability: **a** ??
          2. Place observation *n* into an existing set by with probability: **b<sub>1</sub>**, ..., **b<sub>k</sub>** ??
          3. Add a new set of {*n*} with probability: **c** ??
          4. repeat the above until you do one of them

# Example
- &sigma; = (1,2,3)
- D = equidistant &rArr; IBP
- *i = 2*
- S<sub>*i*</sub> = { {1,2}, {1,2,3}, {2} }   
  &rArr; S<sub>*-i*</sub> = { {1}, {1,3} }
- &alpha;

