

#' Records are without duplicate ID keys.
#'
#' @param ... Comma separated list of bare(unquoted) column names
#'
#' @return For \code{RWD} a \code{logical} vector with lenght the number
#' of records. It is \code{FALSE} for any record that is the duplicate
#' of another record (with respect to the variables in the argument).
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: RWD
#'
#' @examples 
#' 
#' library(validate)
#' rules <- validator(RWD(height,weight)==TRUE)
#' cf <- confront(women, rules)
#' summary(cf)
#' as.data.frame(cf)
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

