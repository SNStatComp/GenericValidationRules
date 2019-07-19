
#' Check number of records.
#'
#' Check that the number of records in a file is higher or equal to a minimum 
#' and (optionally) is lower or equal to a maximum.
#'
#' @param data A bare (unquoted) '\code{.}' when used in a validation rule, otherwise
#'     a data frame.
#' @param min nonnegative integer
#' @param max nonnegative integer, not smaller then \code{min}, or \code{NULL}. If
#'   \code{max} is set to \code{NULL}, only the minimum number of records is checked.
#'
#' @note
#' These checks can easily be performed directly with \pkg{validate} directly (see examples).
#' \code{RNR} and \code{RNR2} are provided for consistency.
#'
#' @return 
#' For \code{RNR} A \code{logical} vector of length \code{nrow(data)}. All \code{FALSE} when
#' the number of records satisfies the bounds, otherwise all \code{TRUE}.
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: RNR
#'
#'
#' @family validation-functions
#' @examples
#' data(RNRdat)
#' 
#' # Using 'validate' directly
#' library(validate)
#' rules <- validator( nrow(.) >= 4 )
#' cf <- confront(RNRdat, rules)
#' summary(cf)
#' as.data.frame(cf)
#'
#'
#' # Using RNR directly
#' RNR(RNRdat, min=4)
#' 
#' # Using RNR with 'validate' (NOTE: data= . )
#' rule <- validator(RNR(data=., min=4) == TRUE)
#' cf <- confront(RNRdat, rule)
#' out <- as.data.frame(cf)
#'
#'
#' @export
RNR <- function(data, min=1, max=NULL){
  n <- nrow(data)
  res <- n >= min
  if (!is.null(max)) res <- res & n <= max
  rep(res,n)
}

#' @rdname RNR
#' @export
#' @return For \code{RNR2}, \code{TRUE} or \code{FALSE}.
RNR2 <- function(data, min=1, max=NULL){
  n <- nrow(data)
  res <- n >= min
  if (!is.null(max)) res <- res & n <= max
  res
}
