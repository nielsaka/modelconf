t.max <-
function(stats){ 
  data.mean      <- stats$data.mean
  boot.data.mean <- stats$boot.data.mean
  data.mean.all <- mean.fast(data.mean)
  boot.data.mean <- boot.data.mean - data.mean
  boot.data.mean.all <- colMeans(boot.data.mean)
  boot.data.mean.shift <- t(t(boot.data.mean) - boot.data.mean.all)
  data.sd <- boot.data.mean.shift*boot.data.mean.shift
  data.sd <- sqrt(rowMeans(data.sd))
  t.stat <- (data.mean - data.mean.all) / data.sd
  maxT <- max(t.stat)
  boot.t.stat <- boot.data.mean.shift / data.sd
  boot.maxT <-  apply(boot.t.stat, 2, max)
  p.value <- mean.fast((boot.maxT - maxT) > 0)
  if(is.na(p.value)) stop(paste("p.value=", p.value))
  return(list(candidate=which(t.stat==maxT), p.value=p.value))
}
