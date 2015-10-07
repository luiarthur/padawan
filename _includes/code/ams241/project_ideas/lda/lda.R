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
B <- 1000

# Preallocate
a <- matrix(.1,B,K)
b <- matrix(.001,B,K)
psi <- matrix(1/V,B,V)
theta <- matrix(1/V,B,V)

for (b in 1:B) {
  # Update:
  for (d in 1:M) {
    for (w in 1:N[d]) {

    }
  }
}
