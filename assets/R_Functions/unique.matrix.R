unique.matrix <- function(X) {
  # Counts the number of unique matrices in a list.
  # X = a list of matrices. We want the output to be:
  # 1) a list of UNIQUE matrices
  # 2) a vector of their counts
  toMat <- function(s) {
    dims <- regexpr(": \\d* \\d*",s)
    begin <- as.integer(dims)+2
    end <- begin+attr(dims,"match.length")
    dims <- substr(s,begin,end)
    pos <- as.integer(regexpr(" ",dims))
    dims <- c(substr(dims,1,pos-1),substr(dims,pos+1,nchar(dims)))
    dims <- as.integer(dims)

    mat <- substr(s,1,begin-3)
    M <- matrix(0,dims[1],dims[2])
    if (mat>" ") {
      vec <- as.integer(strsplit(mat,",")[[1]])
      M <- matrix(vec,dims[1],dims[2])
    }

    M
  }

  S <- lapply(X,function(x) paste(toString(x),":",nrow(x),ncol(x),collapse=","))
  tab <- table(unlist(S))
  counts <- as.integer(tab)
  mat <- names(tab)
  uniq.M <- lapply(as.list(mat),toMat)
  
  ind <- sort(counts,index.return=T,decr=T)
  ind <- ind$ix
  list(counts[ind],uniq.M[ind])
}
