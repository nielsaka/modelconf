#' Model Confidence Sets
#'
#' An alternative implementation of the Model Confidece Set (MCS).
#'
#' Three functions implement the algorithms in Hansen, Lunde, Nason (2011).
#' \itemize{
#'   \item \code{\link{estMCS}}
#'   \item \code{\link{estMCS.quick}}
#'   \item \code{\link{estMCS.reg}}
#' }
#'
#' @references Hansen, P. R., Lunde, A., Nason, J. M. 2011. "The Model
#' Confidence Set", \emph{Econometrica}, \bold{79(2)}, 453 - 497
#' @importFrom RcppEigen fastLmPure
# sourceCpp necessary??
#' @importFrom Rcpp sourceCpp
#' @useDynLib modelconf
"_PACKAGE"


#' Forecasts based on models found in Stock and Watson (1999).
#'
#' This data set is taken from an article by Hansen, Lunde and Nason (2011). It
#' allows to apply the functions of this package and to compare the results
#' with the original outcomes in the paper.
#'
#' ...
#'
#' @name SW_infl4cast
#' @docType data
#' @format A data frame with 168 observations on the following 21 variables.
#' \describe{ \item{list("Obs")}{a numeric vector} \item{list("NoChange.A")}{a
#' numeric vector} \item{list("NoChange.B")}{a numeric vector}
#' \item{list("uniar")}{a numeric vector} \item{list("dtip")}{a numeric vector}
#' \item{list("dtgmpyq")}{a numeric vector} \item{list("dtmsmtq")}{a numeric
#' vector} \item{list("dtlpnag")}{a numeric vector} \item{list("ipxmca")}{a
#' numeric vector} \item{list("hsbp")}{a numeric vector}
#' \item{list("lhmu25")}{a numeric vector} \item{list("ip")}{a numeric vector}
#' \item{list("gmpyq")}{a numeric vector} \item{list("msmtq")}{a numeric
#' vector} \item{list("lpnag")}{a numeric vector} \item{list("dipxmca")}{a
#' numeric vector} \item{list("dhsbp")}{a numeric vector}
#' \item{list("dlhmu25")}{a numeric vector} \item{list("dlhur")}{a numeric
#' vector} \item{list("lhur")}{a numeric vector} }
#' @references Stock and Watson (....)
#' @source Hansen, P. R., Lunde, A., Nason, J. M. 2011. "The Model Confidence
#' Set", \emph{Econometrica}, \bold{79(2)}, 453 - 497
#' @keywords datasets
#' @examples
#'
#' data(SW_infl4cast)
#'
NULL





#' Observational data for Taylor Rule regressions.
#'
#' This data set is taken from an article by Hansen, Lunde and Nason (2011). It
#' allows to apply the functions of this package and to compare the results
#' with the original outcomes in the paper.
#'
#'
#' @name TR_regs
#' @docType data
#' @format A data frame with 148 observations on the following 21 variables.
#' \describe{ \item{list("X")}{a factor} \item{list("Constant")}{a numeric
#' vector} \item{list("Trend")}{a numeric vector} \item{list("FFR")}{a numeric
#' vector} \item{list("dFFR")}{a numeric vector} \item{list("GDP")}{a numeric
#' vector} \item{list("lnGDP")}{a numeric vector} \item{list("GDPD.I")}{a
#' numeric vector} \item{list("GDPC.I")}{a numeric vector}
#' \item{list("HPCE.I")}{a numeric vector} \item{list("CPCE.I")}{a numeric
#' vector} \item{list("HCPI.I")}{a numeric vector} \item{list("CCPI.I")}{a
#' numeric vector} \item{list("GAP_HP")}{a numeric vector}
#' \item{list("GAP_Gr")}{a numeric vector} \item{list("GAP_Tr")}{a numeric
#' vector} \item{list("GAP_BK")}{a numeric vector} \item{list("Unemp")}{a
#' numeric vector} \item{list("UMP.gap")}{a numeric vector}
#' \item{list("Lab.Cost")}{a numeric vector} \item{list("GDPD.I.GAP_HP")}{a
#' numeric vector} }
#' @references Hansen, Lunde, Nason (2011)
#' @source Hansen, Lunde, Nason (2011) url ...
#' @keywords datasets
#' @examples
#'
#' data(TR_regs)
#'
NULL



