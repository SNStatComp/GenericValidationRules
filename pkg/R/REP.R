

REP_only <- function(x, y) {
  xs = do.call(paste,x[colnames(y)])
  ys = do.call(paste, y)
  res <- all(xs %in% ys & ys %in% xs)
  return(res)
}

#' Records expected are provided.
#'
#' @param coverage character scalar indicating the type of coverage:
#' \itemize{
#'   \item{\code{Min}: The combinations represent the minimum coverage of the records to be provided (More combinations are acceptable)}
#'   \item{\code{Max}: The combinations represent the maximum coverage of the records to be provided (Less  combinations are acceptable)}
#'   \item{\code{Only}: The combinations are represented in all the records to be provided (not less, not more combinations can be accepted)}
#'  \item{\code{Excl}: The combinations should not be provided in records}
#' }
#' @param keyTable When used directly, a data frame containig (keys or key 
#'   combinations) that must be present in the data. When used in a validation
#'   rule, the bare (unqouted) name of the data frame when passed as a reference
#'   data with \code{validate::confront} (see example).
#' @param ... When used in a validation rule, a comma separated list of 
#'     bare (unquoted) column names. Otherwise a named, comma separated list of
#'     \code{character} vectors.
#'     
#'
#' @return A \code{logical} vector with length the number
#' of records. It is \code{FALSE} for any record when the check fails on the coverage of the records provided:
#'  Expected codes or Periods for a specific field or combination of fields is present
#'  (check that no combination has been missed out)
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: REP
#'
#' @examples
#' data(REPdat)
#' 
#' # Using REP in 'validate' (NOTE: keyTable = ref)
#' library(validate)
#' rule <- validator(REP(coverage="Only", keyTable=ref
#'    ,TABLE, FREQ, TIME_PERIOD, REPORTING, PARTNER, DIRECTION, AGE, ADJUST) == TRUE)
#' cf <- confront(REPdat, rule, ref = data.frame(ADJUST=c("S", "N"))) 
#' summary(cf)
#' as.data.frame(cf)
#' 
#' # Using REP directly (NOTE: named columns)
#' REP(coverage="Only",keyTable=data.frame(ADJUST=c("S", "N"))
#'     , TABLE       = REPdat$TABLE
#'     , FREQ        = REPdat$FREQ
#'     , TIME_PERIOD = REPdat$TIME_PERIOD
#'     , REPORTING   = REPdat$REPORTING
#'     , PARTNER     = REPdat$PARTNER
#'     , DIRECTION   = REPdat$DIRECTION
#'     , AGE         = REPdat$AGE
#'     , ADJUST      = REPdat$ADJUST )
#'
#' @export
REP <- function(coverage=c("Min", "Max", "Only", "Excl"), keyTable, ...) {
  d <- data.frame(...)
  keys <- setdiff(colnames(d), colnames(keyTable))
  res <- switch (coverage,
    "Only" = unsplit(lapply(split(d, d[keys]), REP_only, keyTable), d[keys])
  )
  return(res)
}

