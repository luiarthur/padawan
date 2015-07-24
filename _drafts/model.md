---
layout: quick
dollar: on
---

# Model Specification for Attraction Indian Buffet Model
---

## Model
\\[
  \begin{array}{rclcrrrr}
    X & | & Z,A,\eta\_1,\eta\_2 & \sim & Normal( &     ZA, & \eta\_1I\_N, & \eta\_2I\_P) \\\\
    Z & | & \alpha, \sigma, \tau & \sim &   aIBM( & \alpha, &        \sigma, & \tau) \\\\
    A &   & & \sim & Normal( &      0, &          I\_K, & I\_P) \\\\
  \end{array}
\\]

---

## Example
$ X $ is an observed matrix which


---
