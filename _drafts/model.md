---
layout: quick
dollar: on
---

# Model Specification for Attraction Indian Buffet Model
---

## Model
\\[
  \begin{array}{rclcrcl}
    X & | & Z,A,\eta\_1,\eta\_2 & \sim     & Normal(&     ZA, \~\~  \eta\_1I\_N, \~\~  \eta\_2I\_P &) \\\\
    Z & | & \alpha, D, \sigma, \tau & \sim &   aIBM(& \alpha, \~\~  \sigma, \~\~  \tau &) \\\\
    A &   & & \sim                         & Normal(& 0, \~\~  I\_K, \~\~  I\_P &) \\\\
  \end{array}
\\]

---

## Example: Predicting Alzheimers 
$X$ is an $N \times P$ matrix which consists of 104 patients (rows) and 244
brain material scores (columns) from an *MRI* dataset. $y$


We will compare two methods: (1) logistic regression from



---
