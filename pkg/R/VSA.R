#' Check that the length of the data in the field is acceptable
#'
#'
#'
#' @param data 
#' @param value character scalar: name of the variable with values (e.g. \code{OBS_VALUE})
#'   column with observed values. Otherwise a numeric vector.
#' @param tolerance allowed relative difference (unadjusted data is the reference).
#' @param adjust  character scalar: name of the variable in \code{data} indicating whether
#'   data is seasonally adjusted or not. 
#' @param nsa A character scalar. The code used to indicate non-seasonally adjusted data.
#' @param sa A character scalar. The code used to indicate seasonally adjusted data. 
#' @param idvars  character vector with names of all dimensions (identifying variables), except for 
#'   the time period and the adjustment status.
#' @family validation-functions
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: FDL
#' 
#' @examples
#'
#'
#'
#'
#' @export
VSA <- function(data, tolerance=0.01, value="OBS_VALUE", adjust="ADJUST", nsa="N", sa="S", idvars){
  keys <-  data[c(idvars, adjust)]

  d <- aggregate(data[value], keys, sum)
  
  d <- reshape(d, timevar=adjust, idvar=idvars, direction="wide")
  
  expr <- sprintf("abs(%s.%s - %s.%s)/(%s.%s)",value,nsa,value,sa,value,nsa)
  check <- parse(text=expr)
  d$.result <- with(d, eval(check)) < tolerance

  order_dummy <- seq_len(nrow(data))
  out <- merge(cbind(data,order_dummy), d, sort=FALSE)
  out$.result[order(out$order_dummy)]
}



