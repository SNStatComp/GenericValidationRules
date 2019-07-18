#' Field is Mandatory or empty
#'
#'
#' @param d When used in a validation rule, a bare (unquoted) name of a variable. 
#'     Otherwise a vector of class \code{character}. Coerced to character as 
#'     necessary.
#' @param mandatoryLevel character scalar indicating whether a variable
#' must be filled or must be empty. 
#' 
#' 
#' 
#' @family validation-functions
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: FDM
#' 
#' 
#' @examples
#' data(FDMdat)
#' 
#' # Example using 'validate' directly 
#' library(validate)
#'
#' ## OBS_VALUE is not an empty string and not NA ("Mandatory")
#' rules <- validator(OBS_STATUS != "" & !is.na(OBS_VALUE) )
#' summary( confront(FDMdat, rules) )
#'
#' ## OBS_VALUE is empty
#' rules <- validator(OBS_STATUS == "" | is.na(OBS_VALUE) )
#' summary( confront(FDMdat, rules) )
#' 
#' # Example using FDM with 'validate' 
#' ## OBS_STATUS must be empty
#' rule <- validator(FDM(OBS_STATUS, mandatoryLevel="Empty") == TRUE)
#' cf <- confront(FDMdat, rule)
#' summary(cf)
#' as.data.frame(cf)
#'
#' ## OBS_STATUS is mandatory
#' rule <- validator(FDM(OBS_STATUS, mandatoryLevel="Mandatory") == TRUE)
#' cf <- confront(FDMdat, rule)
#' summary(cf)
#' as.data.frame(cf)
#' 
#' # Example using FDM directly
#' FDM(FDMdat$OBS_STATUS, mandatoryLevel="Mandatory")
#' FDM(FDMdat$OBS_STATUS, mandatoryLevel="Empty")
#' 
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
