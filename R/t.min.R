t.min <-
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
  minT <- min(t.stat)
  boot.t.stat <- boot.data.mean.shift / data.sd
  boot.minT <-  apply(boot.t.stat, 2, min)
  p.value <- mean.fast((minT - boot.minT) > 0)
  if(is.na(p.value)){
    print(paste("p.value=", p.value))
    browser()
  }
  return(list(candidate=which(t.stat==max(t.stat)), p.value=p.value))
}
