

#' Records are without duplicate ID keys.
#'
#' @param keys Character vector: names columns containing dimensions
#' @param ... Comma separated list of bare(unquoted) column names
#'
#' @examples 
#' 
#' library(validate)
#' rules <- validator(RWD(height,weight)==TRUE)
#' cf <- confront(women, rules)
#' summary(cf)
#' as.data.frame(cf)
#' 
#' @export
RWD <- function(keys=NULL, ...){
  if (!is.null(keys)){
    anyDuplicated(.[keys]) == 0
  } else {
    anyDuplicated(data.frame(...)) == 0
  }
}


