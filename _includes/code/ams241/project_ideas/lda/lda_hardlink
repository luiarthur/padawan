### lda.R

# Let x be a list of words.
# Let M be the number of documents

dwn <- as.numeric(readLines("dat/docword.kos.txt",n=3))
M <- dwn[1] # Number of documents
V <- dwn[2] # Number of unique words in documents
nnz <- dwn[3] # Total num of words in all documents

dat <- read.table("dat/docword.kos.txt",skip=3)
colnames(dat) <- c("doc","wid","count")

vocab <- readLines("dat/vocab.kos.txt")

x <- as.list(1:M) 
N <- NULL
u <- NULL

for (d in 1:M) {
  x[[d]] <- dat[which(dat[,1] == d),1:3]
  N[d] <- sum(x[[d]][,3])
  u[d] <- nrow(x[[d]])
}

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
for (d in 1:M) {
  nd <- z[[d]][,3]
  z[[d]] <- cbind(z[[d]][,-3], 
                  t(apply(matrix(nd),1,function(x) rmultinom(1,x,rep(1,K)) )))
}
al <- matrix(.1,B,K)
be <- matrix(.001,B,V)


word <- z[[d]][w,2]

temp <- sapply(z, function(zz) {
  if (word %in% zz[,2]) {
    ind <- which(zz[,2] == word) 
    out <- zz[ind, 2+k]
  } else {
    out <- 0
  }
  out
})


for (b in 2:B) {
  # Update:
  for (d in 1:M) {
    for (w in 1:u[d]) {
      for (k in 1:K) {
        word <- z[[d]][w,2]
        num_of_wd_w_with_topic_k <- sum(sapply(z, function(zz) {
          if (word %in% zz[,2]) {
            ind <- which(zz[,2] == word) 
            out <- zz[ind, 2+k]
          } else {
            out <- 0
          }
          out
        }))
        be[b,] <- be[b-1,] + num_of_wd_with_topic_k_and_wd_w
        psi[[b]][k,] <- rdir(1, be[b,])
      } # k in 1:K
    } # w in 1:N[d]
    al[b,] <- al[b-1,] + sum(z == k)
    theta[[b]][d,] <- rdir(1, be[b,])
  } # d in 1:M
} # b in 1:B
