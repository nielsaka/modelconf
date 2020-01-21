#' Estimation of model confidence sets for linear regressions using an in-sample
#' loss measure.
#'
#' The function allows to estimate a model confidence set a la Hansen, Lunde and
#' Nason (2011) for the case of linear regression models. A matrix is returned
#' that lists the entered models with their likelihood, estimated 'efficient
#' degrees of freedom', KLIC, BIC, AIC, and the MCS p-values associated with
#' each information criterion.
#'
#' For setting an appropriate value for the block length, check out the `b.star`
#' function in package `np`.
#'
#' @param data A matrix containing the data set to be used.
#' @param models A list with one entry for each model. Each entry is an integer
#'   vector that specifies the columns of matrix `data` to be used as a
#'   regressor in that model. The dependent variable must not be specified. It
#'   is automatically assumed to be the first column. Note that a constant will
#'   not be included unless it is one of the specified regressors.
#' @param B A scalar integer; the number of bootstrap samples.
#' @param l A scalar integer; the block length used in the moving-block
#'   bootstrap.
#'
#' @return A matrix with the following columns:
#'  * -2 * log-likelihood function (Q),
#'  * effective degrees of freedom (k),
#'  * KLIC, KLIC MCS p-value,
#'  * AIC, AIC MCS p-value,
#'  * BIC, BIC MCS p-value.
#'
#'   If the list of models is named, the names will transferred to row names.
#'
#' @author Niels Aka
#' @seealso \code{\link{estMCS}}, \code{\link{estMCS.quick}}
#' @references Hansen, P. R., Lunde, A., Nason, J. M. 2011. "The Model
#'   Confidence Set", \emph{Econometrica}, \bold{79(2)}, 453 - 497
#'
#' @examples
#' data(TR_regs)
#' my_data <- as.matrix(TR_regs[-(1:36),
#'              c("FFR", "Constant", "GDPD.I", "GAP_HP", "UMP.gap", "Lab.Cost")])
#' models <- list(
#'   c(2, 3, 4, 5, 6),
#'   c(2,    4, 5, 6),
#'   c(2,       5, 6),
#'   c(2, 3         ),
#'   c(2,    4      ),
#'   c(2,       5   ),
#'   c(2,          6),
#'   c(2, 3, 4,    6)
#' )
#' names(models) <- paste0("model_", seq_along(models))
#' (my_mcs <- estMCS.reg(my_data, models, B = 20000, l = 5))
#'
#' # The estimated 90% MCS according to AIC
#' my_mcs[my_mcs[, "AIC_pval"] > 1-0.9, ]
#'
#' @export
estMCS.reg <-
function(data, models, B=1000, l=2) {
  n <- nrow(data)
  J <- length(models)
  boot.index <- makeIndex(B, makeBlocks(n, l))
  mcs <- matrix(, ncol=8, nrow=J,
                dimnames = list(NULL, c("Q", "k", "KLIC", "KLIC_pval", "AIC",
                                        "AIC_pval", "BIC", "BIC_pval")))
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
      kick <- which.max(IC)
      # TODO: may select multiple models at this stage!
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
  rownames(mcs) <- names(models)
  return(mcs)
}
