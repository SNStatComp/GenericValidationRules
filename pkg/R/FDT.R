#' Field type
#'
#' Test whether a variable is of the required 'field type'.
#'
#'
#' @param d When used in a validation rule, a bare (unquoted) name of a variable. 
#'     Otherwise a vector of class \code{character}. Coerced to character as 
#'     necessary.
#' @param ft \code{[character]} Field type.
#' @param exceptions \code{[character]} vector of acceptable values, beyond
#'     \code{"Numeric"} or \code{"NumericWithDecimals"}.
#' 
#' @section Details:
#' The sets of 'Alphabetic' and 'Alphanumeric' characters are determined by 
#' the POSIX named ranges \code{"[:alpha:]"} respectively \code{"[:alnum:]"}. 
#' The interpretation of these character ranges depends on the current \code{locale},
#' see \code{\link[base]{regex}}. Numeric values are those that can be coerced
#' to integer or are in the list of \code{exceptions}. Acceptable NumericWithDecimals
#' are numbers that have at least a single decimal after the decimal separator
#' '\code{.}' (it is not required to have a number before it).
#' 
#' 
#' 
#' @family validation-functions
#' @references 
#' \itemize{
#'  \item{\href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: FDT}
#'  \item{ \href{https://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html}{
#'      POSIX regular expressions}. The Open Group base specifications Issue 6.}
#' }
#'
#'
#' @examples
#' data(FDTdat)
#' 
#' # Using FDT with 'validate'
#' library(validate)
#' rules <- validator(FDT(OBS_VALUE, ft="Numeric", exceptions="NA")==TRUE)
#' cf <- confront(FDTdat, rules)
#' summary(cf)
#' as.data.frame(cf)
#'
#' # Using FDT directly
#' FDT(FDTdat$OBS_VALUE, ft="Numeric", exceptions="NA")
#'
#'
#'
#' @export
FDT <- function(d
  , ft = c("Alphabetic","Alphanumeric","Numeric","NumericWithDecimals")
  , exceptions = "NA" ){
  
  ft <- match.arg(ft)
  d <- as.character(d)
  switch(ft
    , "Alphabetic"   = grepl("^[[:alpha:]]*$", as.character(d)) | is.na(d)
    , "Alphanumeric" = grepl("^[[:alnum:]]*$", as.character(d)) | is.na(d)
    , "Numeric"      = d %in% exceptions | !is.na(suppressWarnings(as.integer(d)))
    , "NumericWithDecimals" = d %in% exceptions | grepl("^[0-9]*\\.[0-9]+$",d)
  )
}  
