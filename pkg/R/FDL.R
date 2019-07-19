#' Check that the length of the data in the field is acceptable
#'
#'
#'
#' @param d When used in a validation rule, a bare (unquoted) name of a variable. 
#'     Otherwise a vector of class \code{character}. Coerced to character as 
#'     necessary.
#' @param x Number of code points required.
#' @param min Mimimum number of code points
#' @param max Maximum number of code points
#' @param minDec minimum number of decimal positions
#' @param maxDec maximal number of decimal positions
#'
#' @section Details:
#'
#' The number of code points (string length in terms of human-readable characters)
#' may depend on current locale settings or encoding issues including those
#' caused by inconsistent choices of \code{UTF} normalization.
#'
#' @family validation-functions
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: FDL
#' 
#' @examples
#' data(FDLdat)
#'
#' # Using 'validate' directly
#' library(validate)
#' ## Minimum nr of characters
#' rule <- validator( nchar(PARTNER) >= 2 )
#' cf <- confront(FDLdat, rule)
#' summary(cf)
#' as.data.frame(cf)
#'
#'
#' ## Minimum and Maximum
#' rule <- validator( nchar(PARTNER) >= 2, nchar(PARTNER) <= 4 )
#' cf <- confront(FDLdat, rule)
#' summary(cf)
#' as.data.frame(cf)
#'
#' # Using FDL with 'validate'
#' rule <- validator(FDL(PARTNER, x=2) == TRUE)
#' cf <- confront(FDLdat, rule)
#' summary(cf)
#' as.data.frame(cf)
#'
#' rule <- validator(FDL(PARTNER, min=2, max=4) == TRUE)
#' cf <- confront(FDLdat, rule)
#' summary(cf)
#' as.data.frame(cf)
#'
#' # Using FDL directly
#' FDL(FDLdat$PARTNER, x=2)
#' FDL(FDLdat$PARTNER, min=2, max=4)
#'
#'
#'
#'
#' @export
FDL <- function(d, x=NULL, min=NULL, max=NULL, minDec=NULL, maxDec=NULL) {
  d <- as.character(d)
  if (!is.null(x)) {
    # case 1:
    return( nchar(d) == x )
  }
  
  if (!is.null(min) && !is.null(max)) {
    # case 2:
  
    lengths <- nchar(d)
    res <- lengths >= min & lengths <= max
    
    if (!is.null(minDec) && !is.null(maxDec)) {
      # case 3: also check decimals:
                       # remove all nrs upto and 
                       # including decimal .
      lengths <- nchar(sub("^[0-9]*\\.","", d))
             # must have decimal . and lengths must be within bounds
      res <- res & grepl("\\.",d) & lengths  >= minDec & lengths <= maxDec 
      
    }
  }
  
  return(res)
  
}

