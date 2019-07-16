#' Field type
#'
#' @param d Bare (unquoted) name of a variable in the dataset
#' @param ft \code{[character]} Field type.
#' 
#' 
#' @references 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: FDT
#' 
#' @export
FDT <- function(d
  , ft = c("Alphabetic","Alphanumeric","Numeric","NumericWithDecimals")
  , exceptions = "NA" ){
  
  ft <- match.arg(ft)
  d <- as.character(d)
  switch(ft
    , "Alphabetic"   = grepl("^[[:alpha:]]*$", as.character(d) | is.na(d)
    , "Alphanumeric" = grepl("^[[:alnum:]]*$", as.character(d)) | is.na(d))
    , "Numeric"      = d %in% exceptions | !is.na(suppressWarnings(as.integer(d)))
    , "NumericWithDecimals" = d %in% exceptions | grepl("^[0-9]*\\.[0-9]+$",d)
  )
}  