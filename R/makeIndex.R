makeIndex <-
function(B, blocks){
  n <- ncol(blocks)
  l <- nrow(blocks)
  z <- ceiling(n/l)
  start.points <- sample.int(n, z * B, replace = TRUE) 
  index <- blocks[, start.points]
  keep <- c(rep(TRUE, n), rep(FALSE, z*l - n))
  boot.index <- matrix(as.vector(index)[keep], nrow = n, ncol = B)
  return(boot.index)
}
