# FDM: Field is Mandatory or empty

FDM <- function(d, mandatoryLevel="Mandatory") {
  
  if (mandatoryLevel == "Empty") {
    res <- lapply(d, function(x) x == "" || is.na(x))
  }
  else {
    res <- lapply(d, function(x) x != "" && !is.na(x))
  }
  
  return(res)
  
}
