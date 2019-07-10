# COV: Codes are Valid
# Implemented:
# case1: code list in seperate file
# case2: codes in vector
# NOTE: Documentation from Eurostat on COV hardcodes code column as "Codes" so we follow that:

COV <- function(d, codelistTable=NULL, codelist=NULL) {
  
  if (!is.null(codelistTable)) {
    # Case 1: read code list from  file:
    # TODO: error handling on file read:
    cl <- read.csv(codeListTable)
    res <- lapply(d, function(x) x %in% cl$Codes )
  }
  
  if (!is.null(codelist)) {
    # Case 2: codes in vector codelist
    res <- lapply(d, function(x) x %in% codelist )
  }
  
  
  

  return(res)
  
}