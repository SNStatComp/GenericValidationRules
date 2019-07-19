

VAD_equal <- function(x, field, aggregate_code, ref, tolerance) {
  total <- x[x[[field]]==aggregate_code, c('OBS_VALUE')]
  detail <- sum(x[x[[field]] %in% ref[ref[1]==aggregate_code, 2],c('OBS_VALUE')])
  res <- abs(total - detail)/total < tolerance
  return(res)
}

#' Values for Aggregates are consistent with Details
#' 
#' Check that values for aggregates are consistent with the sum of values for detailed data.
#' 
#' @param data a data frame when called directly. When used in a validation rule, \code{data=.} to
#'   reference the data set passed to \code{\link[validate]{confront}}.
#' @param field a character scalar containing the codes to be used for this check.
#' @param aggregate_code a charactar scalar containing the code for the aggregate.
#' @param operator a charactar scalar containing a relational Operator between aggregates and the sum of detailed data
#' @param tolerance (acceptable margin) expressed in a absolute number
#' @param refdata When called directly, a data frame. When used in a validation rule, the name of the 
#'    reference variable passed to \code{confront}.
#' @return A \code{logical} vector with length the number of records. Each element of this vector contains the result of the check
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: VAD
#' 
#' 
#' @examples 
#' 
#' 
#' data(VADdat)
#' data(HT_AGE_GROUPSdat)
#'
#' # Example in par 4.3.6 of ESTAT doc, using 'validate'
#' library(validate)
#' rule <- validator(VAD(data=., field='AGE', aggregate_code='TOTAL', operator='='
#'   , tolerance='0.01', ref=refdata) == TRUE)
#' cf <- confront(VADdat, rule, ref=list(refdata=HT_AGE_GROUPSdat))
#' summary(cf)
#' as.data.frame(cf)
#' 
#' # example using VAD directly
#' 
#' VAD(data=VADdat, field='AGE', aggregate_code='TOTAL', operator='='
#'   , tolerance='0.01', ref=HT_AGE_GROUPSdat)
#' 
#' 
#' 
#' @export
VAD <- function(data, field, aggregate_code, operator, tolerance, refdata) {
  keys <- setdiff(colnames(data), c(field, 'OBS_VALUE', 'OBS_STATUS'))
  res <- switch (operator,
    '=' = unsplit(lapply(split(data, data[keys]), VAD_equal, field, aggregate_code, refdata, tolerance), data[keys])
  )
  return(res)
}
