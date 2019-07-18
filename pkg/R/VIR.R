#' Check that values are within a range
#'
#' @param d When used in a validation rule, a bare (unquoted) name of a variable. 
#'     Otherwise a vector of class \code{character}. Coerced to character as 
#'     necessary.
#'
#' @param Min smallest allowed value
#' @param Max largest allowed value
#'
#' @note
#' Checking ranges can be doen with \code{VIR} but is even easier to do directly
#' with \pkg{validate}. See the examples.
#'
#' @return A \code{logical} with the length of \code{d}.
#'
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: VIR
#' 
#' @examples
#' data(VIRdat)
#' library(validate)
#' # Using 'validate' directly:
#' rules <- validator(OBS_VALUE >= 1)
#' cf <- confront(VIRdat, rules)
#' summary(cf)
#' as.data.frame(cf)
#' 
#' # Using VIR directly
#' VIR(VIRdat$OBS_VALUE, Min = 1)
#' 
#' # Using VIR in a validation rule
#' 
#' rules <- validator(VIR(OBS_VALUE, Min=1) == TRUE)
#' cf <- confront(VIRdat, rules)
#' summary(cf)
#' as.data.frame(cf)
#' 
#' 
#' 
#' 
#' @export
VIR <- function(d, Min=NULL, Max=NULL){

  # case 1: check minimum
  if ( !is.null(Min) && is.null(Max) ){
    stopifnot(is.numeric(Min))
    res <- d >= Min
  }
  # case 2: ceck maximum
  if ( is.null(Min) && !is.null(Max) ){
    stopifnot(is.numeric(Max))
    res <- d <= Max
  }
  # case 3: check range
  if ( !is.null(Min) && !is.null(Max) ){
    stopifnot(is.numeric(Min), is.numeric(Max))
    res <- d >= Min & d <= Max
  }

  res
}


