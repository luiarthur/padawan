---
layout: quick
dollar: on
---

# Model Specification for Attraction Indian Buffet Model
---

<!--http://rcmdnk.github.io/en/blog/2014/12/11/blog-javascript/ 
 https://mailinabox.email://mailinabox.email/ -->

## Model
$$
  \begin{array}{rclcl}
    \mathbf{X} & | & Z,A,\eta\_1 & \sim & \text{Normal}(     ZA, \  \eta\_1I\_N, \ \eta\_1I\_P ) \\\\
    Z & | & \alpha, D, \sigma  & \sim      & \text{aIBM}( \alpha, \  \sigma ) \\\\
    A & | & \eta\_2 & \sim                           & \text{Normal}( 0, \ \eta\_2I\_K, \ \eta\_2I\_P ) \\\\
    & & \alpha  & \sim                     & \text{Gamma}( 1,1 ) \\\\
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
    \beta & \sim & \text{Normal}(0,10\ \mathbf I\_{P+1}) \\\\
  \end{array}
$$

### Latent Feature Model
$$
  \begin{array}{rcl}
    y\_i & \sim & \text{Bernuolli($q\_i$)}\\\\
    \ln{\left( \frac{q\_i}{1-q\_i} \right)} & = & \mathbf{\hat z'}\_i \gamma \\\\
    \gamma & \sim & \text{Normal}(0,10\ \mathbf I\_{P+1}) \\\\
  \end{array}
$$
where $\hat{\mathbf{Z}}$ is the posterior mode and $P+1$ is the number of
columns in $\mathbf X$ and $\hat{\mathbf{Z}}$, which in this case also includes
a column of $\mathbf 1$'s. A Bayesian model is appropriate here as $P$ is much
larger than $N$.

The difference between the two models is that in the raw data model, we are
directly modeling the response based on the data; whereas, in the latent
feature model, we are modeling the response based on the latent features. That
is, we need to first retrieve the latent features, and then fit the logistic
regression model.

We will obtain $\hat{\mathbf{Z}}$ for the entire dataset then train our
logistic regression model using leave one out cross-validation. We will then
compute the proportion of accurate predictions.

## Functions
~~~Julia
function gibbs(X::data, B::numOfIterations) 
  # Note that we are modeling tau
  return posterior_draws_Z
end

function modeIBP(Z::posteriorDraws)
  return posterior_mode_Z
end

function logisticRegression(y::responses, X::regressors, B::numOfIterations)
  return posterior_draws_beta
end

function predict(x::regressor, beta::estimates)
  prediction = x'beta
  return prediction
end

function leaveOneOutCV(y::responses, X::regressors, B::numOfIterations)
  N = length(y)
  pred = zeros(N)
  for i in 1:N
    post_beta = logisticRegression(y[-i],X[-i,:],B)
    beta = mean(post_beta)
    pred[i] = predict(x[i],beta)
  end

  prop_correct = mean(y == pred)
  return prop_correct
end

# Main:
post_Z = gibbs(X,B)
Z = modeIBP(post_Z)
prop_X = leaveOneOutCV(y,X,B)
prop_Z = leaveOneOutCV(y,Z,B)

println(prop_Z, prop_X)
~~~
