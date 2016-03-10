sgd <- function(x, y, B=10, alpha=1, init=rep(1,5)) {

  theta <- init
  n <- length(y)

  h <- function(xi,par) par[1] + par[2] * cos(par[3] * xi + par[4])

  for (b in 1:B) {
    ord <- sample(1:n)
    y <- y[ord]
    x <- x[ord]
    y_bar <- mean(y)
    y_minus_y_bar <- y-y_bar

    cat("\r",b,"/",B)
    for (i in 1:n) {
      # Preset:
      theta_curr <- theta
      a <- theta[1]
      b <- theta[2]
      w <- theta[3]
      d <- theta[4]
      s2 <- theta[5]

      # Precomputes:
      c_vec <- cos(w*x+d)
      c_bar <- mean(c_vec)
      c_minus_c_bar <- c_vec-c_bar

      # Update a
      theta[1] <- a+alpha*(y[i]-h(x[i],theta_curr)) / s2
      #theta[1] <- y_bar - b * mean(c_vec)
      # Update b
      theta[2] <- b+alpha*(y[i]-h(x[i],theta_curr))*cos(w*x[i]+d) / s2
      #theta[2] <- sum(c_minus_c_bar * y_minus_y_bar) / sum(c_minus_c_bar^2)

      # Update w
      theta[3] <- w-alpha*(y[i]-h(x[i],theta_curr))*b*sin(w*x[i]+d)*x[i] / s2
      # Update d
      theta[4] <- d-alpha*(y[i]-h(x[i],theta_curr))*b*sin(w*x[i]+d) / s2

      # Update s2
      #theta[5] <- sum((y - h(x,theta))^2)/n
      theta[5] <- s2-alpha*(-n/(2*s2) +(y[i] - h(x[i],theta))^2 / (2*(s2)^2))
    }
  }
  theta[5] <- sum((y - h(x,theta))^2)/n
  cat("\n")


  theta
}
