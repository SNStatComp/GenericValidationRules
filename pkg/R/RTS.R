

period_type <- function(x, undefined=NA_character_){
  if ( all( grepl("^[12][0-9]{3}$",x) ) )           return("annual")
  if ( all( grepl("^[12][0-9]{3}-?Q[1-4]$",x) ) )   return("quarterly")
  if ( all( grepl("^[12][0-9]{3}M[01][0-9]$",x) ) ) return("monthly")

  warning("Undefined period type or different period types in single column.", call.=FALSE)
  undefined
}


#' Turn a period into an integer
#' 
#' Annual periods are turned in to the integer year. Quarterly 
#' and Monthly periods are turned in to the month number, counted
#' from the year zero, so quarters and months have consecutive numbers
#' accross years.
#'
#' @param x a \code{character} vector.
#' @param from \code{character} scalar, indicating the period format 
#' (see \code{\link{RTS}} for supported formats).
#'
#'
#' @examples
#' 
#' periods <- c("2018-Q4","2019-Q1")
#' period_to_int(periods, from="quarterly")
#'
#' @family utilities
#' @export
period_to_int <- function(x, from = c("annual","quarterly","monthly")){
  from <- match.arg(from)

  if (from == "annual"){
    res <- as.numeric(x)
  }


  if (from ==  "quarterly" ){
    L       <- strsplit(x,"-?Q")
    year    <- as.numeric(sapply(L, `[[`,1))
    quarter <- as.numeric(sapply(L, `[[`, 2))
    res     <- 4*year + quarter-1
  }

  if ( from == "monthly" ){
    L     <- strsplit(x, "M")
    year  <- as.numeric( sapply(L,`[[`,1) )
    month <- as.numeric( sapply(L, `[[`, 2) )
    res   <- 12*year + month-1 == 1
  }

  res
}

is_gapless <- function(x){
  has_no_gaps <- all(diff(sort(x)) == 1)
  rep(has_no_gaps, length(x))
}

#' Integer year from period string
#' 
#' Extracts first four characters of each element of \code{x} and converts
#' to integer.
#'
#' @param x a \code{character} vector.
#'
#'
#' @examples
#' periods <- c("2018-Q4","2019-Q1")
#' year_from_period(periods)
#'
#' @family utilities
#' @export
year_from_period <- function(x){
  as.integer(substr(x,1,4))
}



#' Check that records are present for time series
#'
#' A record set is split by a set of \emph{dimensions}. For each split,
#' the variable indicating the time period must be both gapless and within bounds.
#' 
#'
#' @param timevar When used in a validation rule, a bare (unquoted) name of the variable
#'     representing a time period (e.g. \code{TIME_PERIOD}). Otherwise a vector of class 
#'     \code{character}. Coerced to character as necessary.
#' @param ftp First time period in one of the supported notations (see Details)
#' @param ltp Last time period in one of the supported notations (see Details)
#' @param ... Comma-separated list of bare (unquoted) dimensions. Time series must
#'    be gapless from \code{ftp} to \code{ltp} for each combination of values in these
#'    dimensions.
#'
#' @section Details:
#'
#' The following notations for time periods are supported:
#' \itemize{
#'   \item{\code{YYYY}: annual data, e.g. \code{"2016"}}
#'   \item{\code{YYYY-?QN}: quarterly data, e.g. \code{"2016Q1"} or \code{"2016-Q1"}}
#'   \item{\code{YYYYMNN}: monthly data, e.g. \code{"2016M01"}, \code{"2016M10"}} 
#' }
#'
#'
#' @family validation-functions
#' @references 
#' 
#' \href{../doc/20180202_maintypes.pdf}{Main types of validation rules for ESS data}: RTS
#'
#' @examples
#' # RTS examples
#' data(RTSdat)
#' 
#' # Example using RTS with 'validate'
#' library(validate)
#' rules <- validator(
#'  RTS(TIME_PERIOD, ftp = "2008", ltp = "2010"
#'    , TABLE, FREQ, REPORTING, PARTNER, DIRECTION, AGE, ADJUST) == TRUE
#' )
#' cf <- confront(RTSdat, rules)
#' summary(cf)
#' out <- as.data.frame(cf)
#'
#' # Example using RTS directly
#' RTS(RTSdat$TIME_PERIOD, ftp = "2008", ltp = "2010"
#'   , RTSdat$TABLE, RTSdat$FREQ, RTSdat$REPORTING
#'   , RTSdat$PARTNER, RTSdat$DIRECTION, RTSdat$AGE, RTSdat$ADJUST) 
#' 
#' # Or, using the 'with' function from base R
#' with(RTSdat
#'    , RTS( TIME_PERIOD, ftp = "2008", ltp = "2010"
#'         , TABLE, FREQ, REPORTING, PARTNER, DIRECTION, AGE, ADJUST)
#' )
#'
#' @export
RTS <- function(timevar, ftp, ltp, ...){

  pt <- period_type(ftp)
  
  if ( !identical(pt, period_type(ltp)) ){
    msg <- sprintf("Start period is '%s' while end period is '%s'"
            , pt, period_type(ltp,"undefined or not unique"))
    stop(msg, call.=FALSE)
  }
  timevar <- as.character(timevar)
  if ( !identical(pt, period_type(timevar)) ){
    msg <- sprintf("Start period is '%s' while time period variable is '%s'"
                  , pt, period_type(timevar,"undefined or not unique"))
    stop(msg, call.=FALSE)  
  }
  splits <- list(...)

  numtime <- period_to_int(timevar, from=pt)
  
  inrange <- numtime >= period_to_int(ftp, from=pt) & 
             numtime <= period_to_int(ltp, from=pt)

  gapless <- unsplit( tapply(numtime, splits, is_gapless), splits )

  # record is valid if it is part of a gapless sequence and within the range
  # set by 
  gapless & inrange


}



