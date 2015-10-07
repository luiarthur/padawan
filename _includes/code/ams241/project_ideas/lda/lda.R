### lda.R

# Let x be a list of words.
# Let M be the number of documents

x <- as.list(1:M) 
N <- NULL
for (d in 1:M) {
  x[[d]] <- vector(words_in_doc[d])
  N[d] <- length(x[[d]])
}

V <- sum(N)
K <- 5     # Number of topics preset to 5

# GIBBS
rdir <- function(N,a) {
  k <- length(a)
  x <- matrix(rgamma(k*N, a, 1), N, k, byrow=T)
  rowsums <- x %*% rep(1,k)
  x / as.vector(rowsums)
}

B <- 1000

# Preallocate
psi <- as.list(1:B); psi[[1]] <- matrix(1/V,K,V)
theta <- as.list(1:B); theta[[1]] <- matrix(1/K,M,K)
z <- x
for (d in 1:M) z[[d]] <- sample(1:K,N[d],replace=T)
al <- matrix(.1,B,K)
be <- matrix(.001,B,V)

for (b in 2:B) {
  # Update:
  for (d in 1:M) {
    for (w in 1:N[d]) {
      for (k in 1:K) {
        xx <- x[which(z == k)]
        # be[b,] <- be[b-1,] + sum(x == ) # Stuck here
        psi[[b]][k,] <- rdir(1, be[b,])
      } # k in 1:K
    } # w in 1:N[d]
    al[b,] <- al[b-1,] + sum(z == k)
    theta[[b]][d,] <- rdir(1, be[b,])
  } # d in 1:M
} # b in 1:B
