# FDL: Check that the length of the data in the field is acceptable

#NOTE: d is a Factor with the values
#Note: below implements case 2 only, to start with

FDL <- function(d, min, max) {
  
  # Turn d into a vector with lengths:
  lengths <- str_length(d)
  
  # Perform check on elements of vector returning a vector of booleans:
  res <- lapply(lengths, function(x) x >= min & x <= max )
  
  return(res)
  
}