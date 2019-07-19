#' @importFrom stats aggregate reshape
{}

#' Check that the length of the data in the field is acceptable
#'
#'
#'
#' @param data When used in a validation rule, a \code{.} to reference the data set passed
#'   to \code{\link[validate]{confront}}. A data frame when called directly.
#' @param value character scalar: name of the variable with values (e.g. \code{OBS_VALUE})
#'   column with observed values. Otherwise a numeric vector.
#' @param tolerance allowed relative difference (unadjusted data is the reference).
#' @param adjust  character scalar: name of the variable in \code{data} indicating whether
#'   data is seasonally adjusted or not. 
#' @param nsa A character scalar. The code used to indicate non-seasonally adjusted data.
#' @param sa A character scalar. The code used to indicate seasonally adjusted data. 
#' @param idvars  character vector with names of all dimensions (identifying variables), except for 
#'   the time period and the adjustment status.
#'
#' @family validation-functions
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: VSA
#' 
#' @examples
#' data(VSAdat)
#'
#' # Using VSA directly
#' VSA(data= VSAdat
#'   , idvars = c("TABLE","FREQ","REPORTING","PARTNER","DIRECTION","AGE"))
#' 
#'
#'
#' # Using VSA with 'validate' (NOTE: data=.)
#' library(validate)
#' rules <- validator(
#'   VSA(data=.
#'     , idvars = c("TABLE","FREQ","REPORTING","PARTNER","DIRECTION","AGE")) == TRUE
#' )
#' cf <- confront(VSAdat, rules,raise="all")
#' summary(cf)
#' as.data.frame(cf)
#'
#'
#' @export
VSA <- function(data, tolerance=0.01, value="OBS_VALUE", adjust="ADJUST", nsa="N", sa="S", idvars){
  keys <-  data[c(idvars, adjust)]

  d <- stats::aggregate(data[value], keys, sum)
  
  d <- stats::reshape(d, timevar=adjust, idvar=idvars, direction="wide")
  
  expr <- sprintf("abs(%s.%s - %s.%s)/(%s.%s)",value,nsa,value,sa,value,nsa)
  check <- parse(text=expr)
  d$.result <- with(d, eval(check)) < tolerance

  order_dummy <- seq_len(nrow(data))
  out <- merge(cbind(data,order_dummy), d, sort=FALSE)
  out$.result[order(out$order_dummy)]
}



