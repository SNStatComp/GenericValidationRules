# FDM: Field is Mandatory or empty

FDM <- function(d, mandatoryLevel="Mandatory") {
  
  if (mandatoryLevel == "Empty") {
    res <- lapply(d, function(x) x == "" || is.na(x))
  }
  
  if (mandatoryLevel == "Mandatory") {
    res <- lapply(d, function(x) x != "" && !is.na(x))
  }
  
  return(res)
  
}
