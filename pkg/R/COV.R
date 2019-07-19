#' @importFrom utils read.csv
{}


#' COV: Codes are Valid
#'
#' 
#' @param d When used in a validation rule, a bare (unquoted) name of a variable. 
#'     Otherwise a vector of class \code{character}. Coerced to character as 
#'     necessary.
#' @param codelistTable A character scalar: name of a csv file (US convention) 
#'     with at least a column \code{Codes}, containing the valid codes. 
#' @param codelist character vector with valid codes. When used in a validation
#'     rule, this must be a literal character vector (i.e. not a variable defined
#'     elswhere in your script).
#' 
#' @family validation-functions
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: COV
#' 
#' 
#' @examples
#' data(COVdat)
#' 
#' # Using COV with 'validate'
#' library(validate)
#' rule <- validator(COV(DIRECTION, codelist=c("IN", "OUT")) == TRUE)
#' cf <- confront(COVdat, rule)
#' summary(cf)
#' as.data.frame(cf)
#'
#' # Using COV directly
#' COV(COVdat$DIRECTION, codelist=c("IN", "OUT"))
#' 
#' # Using 'validate' directly
#' rule <- validator( DIRECTION %in% c("IN", "OUT") )
#'
#'
#' @export
COV <- function(d, codelistTable=NULL, codelist=NULL) {
  d <- as.character(d) 
  if (!is.null(codelistTable)) {
    # Case 1: read code list from  file:
    cl <- utils::read.csv(codelistTable,colClasses=c(Codes="character"))
    res <- d %in% cl$Codes
  }
  
  if (!is.null(codelist)) {
    # Case 2: codes in vector codelist
    res <- d %in% codelist 
  }

  return(res)
  
}
