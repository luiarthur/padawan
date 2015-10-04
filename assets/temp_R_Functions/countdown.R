count.down <- function(old.time,i,B) {
  prog <- round(100*i/B,4)
  new.time <- Sys.time()
  time.diff <- as.numeric(new.time-old.time)
  time.remain <- time.diff * (B-i)
  if (time.remain < 60) {
    secs <- round(time.remain)
    time.remain <- paste0(secs,"s     ")
  } else if (time.remain<3600) {
    mins <- round(time.remain%/%60)
    secs <- round(time.remain%%60)
    time.remain <- paste0(mins,"m ",secs,"s        ")
  } else {
    hrs <- round(time.remain%/%3600)
    mins <- round((time.remain%%3600) %/% 60)
    time.remain <- paste0(hrs,"h ",mins,"m         ")
  }
  cat(paste0("\rProgress: ",prog,"%. Time Remaining: ",time.remain," "))
  if (i==B) cat("100%\n")
}

# Example
#B <- 5000
#for(i in 1:B) {
#  old.time <- Sys.time()
#
#    Sys.sleep(1) # your (mcmc) junk here
#
#  count.down(old.time,i,B)
#}

