

#' Records expected are provided.
#' 
#' @param ... When used in a validation rule, a comma separated list of 
#'     bare (unquoted) column names. Otherwise a comma separated list of
#'     \code{character} vectors.
#'
#' @return For \code{RWD} a \code{logical} vector with length the number
#' of records. It is \code{FALSE} for any record when the check fails on the coverage of the records provided:
#'  Expected codes or Periods for a specific field or combination of fields is present
#'  (check that no combination has been missed out)
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: REP
#'

REP_only <- function(x, y) {
  xs = do.call(paste,x[colnames(y)])
  ys = do.call(paste, y)
  print(xs)
  print(ys)
  res <- all(xs %in% ys & ys %in% xs)
  return(res)
  
}

#' @export
REP <- function(coverage=c("Min", "Max", "Only", "Excl"), ...) {
  d <- data.frame(...)
  keys <- setdiff(colnames(d), colnames(ref))
  res <- switch (coverage,
    Only = unsplit(lapply(split(d, d[keys]), REP_only, ref), d[keys])
  )
  return(res)
}
