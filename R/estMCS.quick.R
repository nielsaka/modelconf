#' Estimation of a model confidence set (MCS) using an out-of-sample loss
#' measure.
#'
#' Given estimated losses of different models, this function will estimate a
#' model confidence set and return a vector indicating which models are
#' inside the estimated set.
#'
#' This function works in a similar way to \code{\link{estMCS}}. But instead of
#' returning the complete set of models that were fed to the function together
#' with some additional information, this function will only return a vector of
#' integers indicating which models are inside the estimated model confidence
#' set. The indicated models are superior to all models that were in
#' the initial set. Using this function instead of \code{\link{estMCS}} will
#' be computationally less burdensome, because it stops once the MCS p-value
#' is above the specified significance level \code{alpha}.
#'
#' @inheritParams estMCS
#' @param alpha A scalar, the significance level.
#' @return A vector of length (m* x 1), where m* is the estimated number of
#'   superior models. The elements of the vector are integers and specify the
#'   models which are inside the estimated MCS. They refer to the order in which
#'   they occurred as columns in \code{loss}.
#' @author Niels Aka
#' @seealso \code{\link{estMCS}}, \code{\link{estMCS.reg}}.
#' @references Hansen, P. R., Lunde, A., Nason, J. M. 2011. "The Model
#'   Confidence Set", \emph{Econometrica}, \bold{79(2)}, 453 - 497
#' @examples
#' data(SW_infl4cast)
#' data <- as.matrix(SW_infl4cast)
#' loss <- (data[, -1] - data[, 1])^2 # compute squared errors
#'
#' (my_MCS <- estMCS.quick(loss, test = "t.min",
#'                         B = 25000, l = 12, alpha = 0.1))
#'
#' my_MCS_all <- estMCS(loss, test = "t.min", B = 25000, l = 12)
#'
#' all(my_MCS == which(my_MCS_all[, "MCS p-val"] > 0.1))
#' @export
estMCS.quick <-
function(loss, test, B, l, alpha){
  n <- nrow(loss)
  m <- ncol(loss)
  blocks <- makeBlocks(n, l) 
  models <- 1:m 
  boot.index <- makeIndex(B, blocks)
  stats <- makeStats(loss, boot.index)
  rejection <- do.call(test, list(stats)) 
  models <- models[-rejection$candidate]
  stats <- list(data.mean = stats$data.mean[-rejection$candidate],
                boot.data.mean = stats$boot.data.mean[-rejection$candidate, ])
  if (alpha < rejection$p.value){
    return (1:m)
  } else {                       
    while (1 < NROW(stats$data.mean)){
		rejection <- do.call(test, list(stats))
        if (alpha < rejection$p.value){
			break
      }
        models <- models[-rejection$candidate]
        stats <- list(data.mean = stats$data.mean[-rejection$candidate],
                      boot.data.mean = stats$boot.data.mean[-rejection$candidate, ])
    }
    return(models)
  }
}
