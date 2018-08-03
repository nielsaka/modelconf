makeStats.reg <-
function(data, models, boot.index){
  n <- nrow(data)
  B <- ncol(boot.index)
  J <- length(models)
  beta <- list()
  sigma.sq.hat <- numeric(J)
  b.sigma.sq.hat <- matrix(, nrow=J, ncol=B)
  b.sigma.sq     <- matrix(, nrow=J, ncol=B)
  
  for (j in 1:J) {
    y <- data[, 1]
    X <- data[, models[[j]]]
    if (!is.matrix(X)) X <- as.matrix(X)
    ols.fit <- fastLmPure(X, y, method=2)
    sigma.sq.hat[j] <- (ols.fit$s^2) * (1 - (ncol(X)/n))
    beta[[j]] <- ols.fit$coefficients
  }
  
  for (b in 1:B) {
    boot.data <- data[boot.index[, b], ]
    
    for (j in 1:J){
      b.y <- boot.data[, 1]
      b.X <- boot.data[, models[[j]]]
      if (!is.matrix(b.X)) b.X <- as.matrix(b.X)
      b.ols.fit <- fastLmPure(b.X, b.y, method=0)
      b.sigma.sq.hat[j, b] <- (b.ols.fit$s^2) * (1 - (ncol(b.X)/n))
      b.sigma.sq[j, b] <- sum((b.y - b.X %*% beta[[j]])^2)/n
    }
  }
  iota.B <- rep(1, B)
  iota.J <- rep(1, J)
  log.b.sigma.ratio <- log((sigma.sq.hat %x% t(iota.B)) / b.sigma.sq.hat)
  b.k.hat <- rowMeans(log.b.sigma.ratio + 
                        (b.sigma.sq / (sigma.sq.hat %x% t(iota.B))) - 1) * n
  Q_k <- n * log.b.sigma.ratio - b.k.hat
  ij.index <- combSimple(J)
  b.t.R <- get_Dij_abs(Q_k, ij.index - 1)
  row.names(b.t.R) <- paste0(ij.index[, 1],"_", ij.index[, 2])
  Q.hat <- n*(log(sigma.sq.hat) + 1)
  stats <- list(Q = Q.hat,
                k = b.k.hat,
                b.t.R = b.t.R)
  return(stats)
}
