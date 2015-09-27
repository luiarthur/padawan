
Rapply <- function(L,f) { # L is a list, f is a function to apply to L[[x]]
                          # L apply takes a list, applies a function, 
                          # and rbinds it. Assumes output is vector.
  n <- length(L)
  out <- apply(matrix(1:n),1,function(i) f(L[[i]]))
  t(out)
}
