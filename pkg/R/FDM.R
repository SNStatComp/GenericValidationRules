#' Field is Mandatory or empty
#'
#'
#' @param d A character vector
#' @param mandatoryLevel character scalar indicating whether a variable
#' must be filled or must be empty. 
#' 
#' 
#' 
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: FDM
#' 
#' @export
FDM <- function(d, mandatoryLevel=c("Mandatory","Empty")) {
  mandatoryLevel <- match.arg(mandatoryLevel)
  d <- as.character(d)
  if (mandatoryLevel == "Empty") {
    res <- d == "" | is.na(d)
  }
  
  if (mandatoryLevel == "Mandatory") {
    res <- d != "" & !is.na(d)
  }
  
  return(res)
  
}
