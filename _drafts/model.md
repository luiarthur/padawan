---
layout: quick
dollar: on
---

# Model Specification for Attraction Indian Buffet Model
---

## Model
$$
  \begin{array}{rclcl}
    \mathbf{X} & | & Z,A,\eta\_1,\eta\_2 & \sim & \text{Normal}(     ZA, \  \eta\_1I\_N, \ \eta\_2I\_P ) \\\\
    Z & | & \alpha, D, \sigma, \tau & \sim      & \text{aIBM}( \alpha, \  \sigma, \  \tau ) \\\\
    & & A & \sim                           & \text{Normal}( 0, \ I\_K, \ I\_P ) \\\\
    & & \alpha  & \sim                     & \text{Gamma}( 1,1 ) \\\\
    & & \tau    & \sim                     & \text{Gamma}( 1,1 ) \\\\
    & & \eta\_1 & \sim                     & \text{Gamma}( 1,1 ) \\\\
    & & \eta\_2 & \sim                     & \text{Gamma}( 1,1 ) \\\\
    & & \sigma  & \sim                     & \text{permute}( 1,...,6 ) \\\\
  \end{array}
$$

---

## Example: Predicting Alzheimer's (Gershman, et al.)
$\mathbf{X}$ is an $N \times P$ matrix which consists of 104 patients (rows) and 224
brain material scores (columns) from an *MRI* dataset. $\mathbf{y}$ is a length $N$
vector indicating whether each patient has Alzheimer's.

We are interested in predicting which patients have Alzheimer's. We will model using
(1) the raw data, and (2) the latent features generating $\mathbf X$:

### Raw Data Model
$$
  \begin{array}{rcl}
    y\_i & \sim & \text{Bernuolli($p\_i$)}, \text{ where}\\\\
    \ln{\left( \frac{p\_i}{1-p\_i} \right)} & = & \mathbf{x'}\_i \beta \\\\
  \end{array}
$$

### Latent Feature Model
$$
  \begin{array}{rcl}
    y\_i & \sim & \text{Bernuolli($q\_i$)}, \text{ where}\\\\
    \ln{\left( \frac{q\_i}{1-q\_i} \right)} & = & \mathbf{\hat z'}\_i \gamma, \\\\
  \end{array}
$$
and $\hat{\mathbf{Z}}$ is the posterior mode.

The difference between the two models is that in the raw data model, we are
directly modeling the response based on the data; whereas, in the latent
feature model, we are modeling the response based on the latent features. That
is, we need to first retrieve the latent features, and then fit the logistic
regression model.

We will obtain $\hat{\mathbf{Z}}$ for the entire dataset then train our
logistic regression model using leave one out cross validation and compuite AUC.

---
