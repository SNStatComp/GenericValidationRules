# COV: Codes are Valid

COV <- function(d, codelistTable=NULL, codelist=NULL) {
  
  if (!is.null(codelistTable)) {
    # Case 1: read code list from  file:
    cl <- read.csv(codeListTable)
    res <- lapply(d, function(x) x %in% cl$Codes )
  }
  
  if (!is.null(codelist)) {
    # Case 2: codes in vector codelist
    res <- lapply(d, function(x) x %in% codelist )
  }

  return(res)
  
}