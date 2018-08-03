t.range <- 
function(stats){
  data.mean      <- stats$data.mean
  boot.data.mean <- stats$boot.data.mean
  boot.data.mean.shift <- boot.data.mean - data.mean
  m  		<- length(data.mean)
  ij.index	<- combSimple(m)
  d.ij		<- get_Dij(as.matrix(data.mean), ij.index - 1)
  boot.d.ij <- get_Dij_abs(boot.data.mean.shift, ij.index - 1) 
  sd.d.ij 	<- sqrt(rowMeans(boot.d.ij*boot.d.ij))
  t.stat      <- d.ij / sd.d.ij
  boot.t.stat <- boot.d.ij / sd.d.ij
  candidate	<- which.max(abs(t.stat))
  T.range    	<- abs(t.stat[candidate])
  boot.T.range<- colMax(boot.t.stat)
  p.value    <- mean.fast((boot.T.range - T.range) > 0)
  if (t.stat[candidate] > 0 ) { 
    candidate  <- ij.index[candidate, 1]
  } else {                     
    candidate  <- ij.index[candidate, 2]
  }
  return(list(candidate=candidate, p.value=p.value))
}