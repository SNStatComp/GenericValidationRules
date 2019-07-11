# FDL: Check that the length of the data in the field is acceptable
library(stringr)

#Note: implemented case 1 and 2 only

FDL <- function(d, x=NULL, min=NULL, max=NULL, minDec=NULL, maxDec=NULL) {
  
  if (!is.null(x)) {
    # case 1:
    
    lengths <- str_length(d)
    res <- lapply(lengths, function(l) l == x )
  }
  
  if (!is.null(min) && !is.null(max)) {
    # case 2:
  
    lengths <- str_length(d)
    res <- lapply(lengths, function(x) x >= min & x <= max )
    
    if (!is.null(minDec) && !is.null(maxDec)) {
      # case 3: also check decimals:
      
      lengths <- str_length(str_extract(d, "\\.\\d*")) - 1
      res2 <- lapply(lengths, function(x) x >= minDec & x <= maxDec )
      
      res <- unlist(res) & unlist(res2)
    }
  }
  
  return(res)
  
}