# FDL: Check that the length of the data in the field is acceptable
library(stringr)

#Note: below implements case 2 only, to start with

FDL <- function(d, min, max) {
  
  # Turn Factor d into a lengths Vector:
  lengths <- str_length(d)
  
  # Perform length check on elements of vector:
  res <- lapply(lengths, function(x) x >= min & x <= max )
  
  return(res)
  
}