# FDL: Check that the length of the data in the field is acceptable

#' Check field lengths 
#'
#' @param d A character vector
#' @param x Number of code points required
#' @param min Mimimum number of code points
#' @param max Maximum number of code points
#' @param minDec minimum number of decimal positions
#' @param maxDec maximal number of decimal positions
#'
#'
#'
#' @export
FDL <- function(d, x=NULL, min=NULL, max=NULL, minDec=NULL, maxDec=NULL) {
  
  if (!is.null(x)) {
    # case 1:
    return( char(d) == x )
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
      res <- grepl("\\.",d) & lengths  >= minDec & lengths <= maxDec 
      
    }
  }
  
  return(res)
  
}
