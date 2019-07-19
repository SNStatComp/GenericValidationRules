

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
#' @param data a data frame.
#' @param field a character scalar containing the codes to be used for this check.
#' @param aggregate_code a charactar scalar containing the code for the aggregate.
#' @param operator a charactar scalar containing a relational Operator between aggregates and the sum of detailed data
#' @param tolerance (acceptable margin) expressed in a absolute number
#' @return A \code{logical} vector with length the number of records. Each element of this vector contains the result of the check
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: VAD
#' 
#' @export
VAD <- function(data, field, aggregate_code, operator, tolerance) {
  keys <- setdiff(colnames(data), c(field, 'OBS_VALUE', 'OBS_STATUS'))
  res <- switch (operator,
    '=' = unsplit(lapply(split(data, data[keys]), VAD_equal, field, aggregate_code, ref, tolerance), data[keys])
  )
  return(res)
}
