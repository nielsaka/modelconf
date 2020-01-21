#' Estimation of model confidence sets for linear regressions using an in-sample
#' loss measure.
#'
#' The function allows to estimate a model confidence set a la Hansen, Lunde
#' and Nason (2011) for the case of linear regression models. A matrix is
#' returned that lists the entered models with their likelihood, estimated
#' efficient degrees of freedom, KLIC, BIC, AIC and the MCS p-values associated
#' with each information criterion.
#'
#' ...
#'
#' @param data A matrix containing the data set to be used.
#' @param models A list with one entry for each model specifying in a numerical
#' vector the columns of matrix \code{data} to be used in that model.
#' @param B the number of bootstrap samples.
#' @param l the block length used in the moving-block bootstrap.
#' @return ...
#' @author Niels Aka
#' @seealso \code{\link{estMCS}}, \code{\link{estMCS.quick}}
#' @references Hansen, P. R., Lunde, A., Nason, J. M. 2011. "The Model
#'   Confidence Set", \emph{Econometrica}, \bold{79(2)}, 453 - 497
#' @keywords htest robust models
#'
#'
#' @export
estMCS.reg <-
function(data, models, B=1000, l=2) {
  n <- nrow(data)
  J <- length(models)
  boot.index <- makeIndex(B, makeBlocks(n, l))
  mcs <- matrix(, ncol=8, nrow=J,
                dimnames = list(NULL, c("Q", "k", "KLIC", "p-val", "AIC",
                                        "p-val", "BIC", "p-val")))
  stats <- makeStats.reg(data, models, boot.index)
  Q <- stats$Q
  k <- stats$k
  mcs[, 1:2] <- cbind(Q, k)
  mcs[, c(3, 5, 7)] <- Q + matrix(c(k, 2*k, log(n)*k), ncol=3)
  iota.J <- rep(1, J)
  for (i in c(3, 5, 7)) {
    model.index <- 1:J
    IC <- mcs[, i]
    t.R <- abs(IC %x% t(iota.J) - t(IC) %x% iota.J)
    b.t.R <- stats$b.t.R
    for (j in 1:(J-1)) {
      T.R <- max(t.R)
      if (j < (J - 1)) {
        b.T.R <-   colMax(b.t.R)
      } else {
        b.T.R <- b.t.R
        b.t.R <- as.matrix(b.t.R)
      }
      ij.index <- combSimple(J - j + 1)
      kick <- which(max(IC) == IC)
      kick.many <- rowSums(ij.index == kick) == 0
      p.val <- mean.fast(b.T.R - T.R >= 0)
      mcs[model.index[kick], i + 1] <- max(c(mcs[, i + 1], p.val),
                                           na.rm = TRUE)
      IC <- IC[-kick]
      t.R <- t.R[-kick, -kick]
      b.t.R <- b.t.R[kick.many, ]
      model.index <- model.index[-kick]
    }
    mcs[model.index, i + 1] <- 1
  }
  return(mcs)
}
