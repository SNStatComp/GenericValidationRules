#' Check that values are within a range
#'
#' @param d Bare (unquoted) name of a variable
#'
#' @return A \code{logical} with the length of \code{d}.
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


