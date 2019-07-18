

#' Records are without duplicate ID keys.
#'
#' @param ... When used in a validation rule, a comma separated list of 
#'     bare (unquoted) column names. Otherwise a comma separated list of
#'     \code{character} vectors.
#'
#' @return For \code{RWD} a \code{logical} vector with lenght the number
#' of records. It is \code{FALSE} for any record that is the duplicate
#' of another record (with respect to the variables in the argument).
#'
#'
#' @family validation-functions
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: RWD
#'
#' @examples 
#' data(RWDdat)
#' library(validate)
#' # Using RWD with 'validate'
#' rules <- validator( 
#'   RWD(TABLE, FREQ, TIME_PERIOD, REPORTING, PARTNER, DIRECTION, AGE, ADJUST) == TRUE )
#' cf <- confront(RWDdat, rules)
#' summary(cf)
#' as.data.frame(cf)
#' 
#' # Using RWD directly
#' 
#' RWD(RWDdat$TABLE, RWDdat$FREQ, RWDdat$TIME_PERIOD, RWDdat$REPORTING
#'   , RWDdat$PARTNER, RWDdat$DIRECTION, RWDdat$AGE, RWDdat$ADJUST)
#' 
#' @export
RWD <- function(...){
  df <- data.frame(...)
  !( duplicated(df) | duplicated(df, fromLast=TRUE) )
}


#' @rdname RWD
#' @return 
#' For \code{RDW2}: \code{TRUE} when there are no records that have duplicate
#' values for the variables in the argument, else \code{FALSE}.
#' @export
RWD2 <- function(...){
   anyDuplicated(data.frame(...)) == 0
}

