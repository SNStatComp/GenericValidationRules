library(validate)

# example 1
data(COCdat)
rules <- validator(
      if (TABLE == "T01") FREQ == "A"
    , if (TABLE == "T02") FREQ == "Q")
cf  <- confront(COCdat, rules)
out <- as.data.frame(cf)
expect_equal(out$value, c(FALSE, TRUE, TRUE, TRUE, TRUE, TRUE))

# example 2 (same ruleset)
data(COC2dat)
cf <- confront(COC2dat, rules)
out <- as.data.frame(cf)
expect_equal(out$value, c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, TRUE))

# example 3 
data(COC3dat)

rules <- validator(REPORTING == "EL")
cf <- confront(COC3dat, rules)
out <- as.data.frame(cf)
expect_equal(out$value, c(TRUE, TRUE, FALSE))


## Or, using externally defined envelope data:
env <- data.frame(Country="EL",stringsAsFactors=FALSE)
rules <- validator(REPORTING == envelope$Country)
cf <- confront(COC3dat, rules, ref=list(envelope=env), raise="all")
out <- as.data.frame(cf)
expect_equal(out$value, c(TRUE, TRUE, FALSE))

# example 4
data(COC4dat)
COC4dat$REPORTING <- as.character(COC4dat$REPORTING)
COC4dat$PARTNER <- as.character(COC4dat$PARTNER)
rules <- validator(REPORTING != PARTNER)

cf <- confront(COC4dat, rules)
out <- as.data.frame(cf)
expect_equal(out$value, c(TRUE, TRUE, FALSE, TRUE ))

# example 5
data(COC5dat)
rules <- validator( if ( TABLE == "T01" ) ADJUST == "N" )
cf <- confront(COC5dat, rules)
out <- as.data.frame(cf)
expect_equal(out$value, c(TRUE, TRUE, FALSE, TRUE))


