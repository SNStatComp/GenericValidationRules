
#' Check number of records.
#'
#' Check that the number of records in a file is higher or equal to a minimum 
#' and (optionally) is lower or equal to a maximum.
#'
#' @param data A bare (unquoted) '\code{.}' when used in a validation rule, otherwise
#'     a data frame.
#' @param Min nonnegative integer
#' @param Max nonnegative integer, not smaller then \code{Min}, or \code{NULL}. If
#'   \code{Max} is set to \code{NULL}, only the minimum number of records is checked.
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
#' RNR(RNRdat, Min=4)
#' 
#' # Using RNR with 'validate' (NOTE: data= . )
#' rule <- validator(RNR(data=., Min=4) == TRUE)
#' cf <- confront(RNRdat, rule)
#' out <- as.data.frame(cf)
#'
#'
#' @export
RNR <- function(data, Min=1, Max=NULL){
  n <- nrow(data)
  res <- n >= Min
  if (!is.null(Max)) res <- res & n <= Max
  rep(res,n)
}

#' @rdname RNR
#' @export
#' @return For \code{RNR2}, \code{TRUE} or \code{FALSE}.
RNR2 <- function(data, Min=1, Max=NULL){
  n <- nrow(data)
  res <- n >= Min
  if (!is.null(Max)) res <- res & n <= Max
  res
}
