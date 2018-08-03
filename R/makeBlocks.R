makeBlocks <-
function(n, l){
  blocks <- matrix(, nrow=l, ncol=n)
  blocks[1,] <- 1:n
  if (l > 1){
    for (i in 2:l) {
      blocks[i,] <- c(i:n, 1:(i - 1))
    }
  }
  return(blocks)
}
