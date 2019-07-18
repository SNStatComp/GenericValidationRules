#' @title Code consistency
#' @rdname COC
#' @name COC
#'
#' @description
#' Check that the codes used in fields are consistent with other codes used in
#' another field of the same record, the same field in different records of the
#' same file or in different datasets from the same country. 
#'
#'
#' @section Note:
#' The interface proposed in the original document contains redundancies, and it is 
#' easier to express this rule type directly in \pkg{validate} syntax as shown
#' in the examples below.
#'
#' @family validation-functions
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: COC
#'
#' @examples
#' # First example: consistency of TABLE and FREW
#' library(validate)
#' data(COCdat)
#' rules <- validator(
#'    if ( TABLE == "T01" ) FREQ == "A"
#'  , if ( TABLE == "T02" ) FREQ == "Q")
#'
#' result <- confront(COCdat, rules)
#' summary(result)
#' values(result)
#' as.data.frame(result)
#'
#' # Second example: consistency of TABLE and FREQ
#' data(COC2dat)
#' result <- confront(COC2dat, rules)
#' summary(result)
#' values(result)
#' as.data.frame(result)
#'
#' # Third example: country must be EL. Envelope data can be passed
#' # as a single-row data frame
#' data(COC3dat)
#' rules <- validator(REPORTING == envelope$Country)
#' env <- data.frame(Country="EL", stringsAsFactors=FALSE)
#' result <- confront(COC3dat, rules, ref=list(envelope=env))
#' summary(result)
#' values(result)
#' as.data.frame(result)
#' 
#' # Fourth example: REPORTING country and PARTNER country cannot be the same
#' data(COC4dat)
#' # we convert to character as in the original data, these variables are
#' # different types of 'factor' (categorical) variables.
#' rules <- validator(as.character(REPORTING) != as.character(PARTNER) )
#' result <- confront(COC3dat, rules)
#' summary(result)
#' values(result)
#' as.data.frame(result)
{}
