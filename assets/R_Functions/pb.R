# Text progress bar
pb <- function(i,n) { 
  cat(paste0("\rProgress: ",round(i*1000/n)/10,"%"))
  if (i==n) cat("\n")
}
