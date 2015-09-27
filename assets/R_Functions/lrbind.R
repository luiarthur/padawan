lrbind <- function(L) { #rbinds a list of matrices
  k <- length(L)
  p <- ncol(L[[1]])
  out <- matrix(0,0,p)
  for (i in 1:k) {
    out <- rbind(out,L[[i]])
  }
  out
}
