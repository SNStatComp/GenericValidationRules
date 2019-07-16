
#' COV: Codes are Valid
#'
#' @param d A character vector
#' @param codelistTable A character scalar: name of a csv file (US convention) 
#' with at least a column \code{Codes}, containing the valid codes. 
#' @param codelist character vector with valid codes.
#' 
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: COV
#' 
#' @export
COV <- function(d, codelistTable=NULL, codelist=NULL) {
  d <- as.character(d) 
  if (!is.null(codelistTable)) {
    # Case 1: read code list from  file:
    cl <- read.csv(codelistTable,colClasses=c(Codes="character"))
    res <- d %in% cl$Codes
  }
  
  if (!is.null(codelist)) {
    # Case 2: codes in vector codelist
    res <- d %in% codelist 
  }

  return(res)
  
}