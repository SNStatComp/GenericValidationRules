#' @importFrom stats reshape
#'
{}


#' Values are Consistent
#'
#' Pivot a table in long format around a variable, execute a validation rule
#' after pivoting, transform the results to the unpivoted table.
#'
#' @param data A bare (unquoted) '\code{.}' when used in a validation rule, otherwise
#'     a data frame.
#' @param pivot Pivoting variable: the values \code{VAL1}, \code{VAL2},
#'     \eqn{\ldots},\code{VALN} of this variabe become columns after pivoting.
#' @param idvars Identifying variables: these variables stay in rows after pivoting. All variables
#'     that are not pivot or identifying are considered observations. A variable named \code{OBS}
#'     will be split over columns \code{OBS.VAL1}, \code{OBS.VAL2}, \eqn{\ldots}. When \code{VCO} is used in
#'     a validation rule with \pkg{validate}, \code{idvars} must be a literal character vector. 
#'     That is, its value can not be a variable defined earlier in the script.
#' @param rule A bare expression in terms of the \code{OBS.VARi} variables.
#'
#'
#'
#'
#' @family validation-functions
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: VCO
#' 
#' @examples
#' data(VCOdat)
#' # Example using VCO directly on a data set.
#' VCO(VCOdat, pivot = "AGE"
#'  , idvars = c("TABLE","FREQ", "TIME_PERIOD","REPORTING","PARTNER","DIRECTION")
#'  , rule = OBS_VALUE.Y0_18/OBS_VALUE.TOTAL<0.5)
#'
#' # Example using VCO in a validation rule with the 'validate' package (NOTE: data = . )
#' library(validate)
#' rules <- validator(
#'   VCO( data = . , pivot = "AGE"
#'    , idvars = c("TABLE","FREQ", "TIME_PERIOD","REPORTING","PARTNER","DIRECTION")
#'    , rule = OBS_VALUE.Y0_18/OBS_VALUE.TOTAL<0.5) == TRUE)
#' cf <- confront(VCOdat, rules)
#' summary(cf)
#' as.data.frame(cf)
#'
#' @export
VCO <- function(data, pivot, idvars, rule){
  rule <- as.expression(substitute(rule))
  dat <- stats::reshape(data, direction="wide", timevar=pivot, idvar=idvars)
  dat$result <- eval(rule, dat)
  dat <- merge(data, dat[c(idvars,"result")], sort=FALSE)
  id1 <- do.call(paste0,data[idvars])
  id2 <- do.call(paste0, dat[idvars])
  dat$result[match(id1, id2)]
}

