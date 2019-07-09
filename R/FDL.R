FDL <- function(field, min, max) {
  #print(field)
  res <- minmax(field, min, max)
  #print(res)
  return(TRUE)
}

minmax <- function(x, min, max) {
  print('test',nchar(x))
  return(lapply(x, nchar))
} 