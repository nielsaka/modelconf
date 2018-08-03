makeStats <-
function(data, boot.index) {
  data.mean <- colMeans(data)
  n <- nrow(data)
  B <- ncol(boot.index)
  weights <- vapply(1L:B,
                    function(j) tabulate(boot.index[, j], nbins = n),
                    integer(n)) * (1 / n)
  if (all(apply(weights, 1, function(x) length(unique(x)) == 1))){
    warning("makeStats: Insufficient observations or block length too large.")
  } 
  boot.data.mean <- t(data) %*% weights
  return(list(data.mean = data.mean,
              boot.data.mean = boot.data.mean))
}
