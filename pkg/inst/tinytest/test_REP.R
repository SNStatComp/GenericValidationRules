library(validate)


# Test data:
data(REPdat)
reftab <- data.frame(ADJUST=c("S", "N"))

# Example in par 4.3.1 of ESTAT doc:
rule <- validator(REP(coverage="Only", keyTable=ref
    ,TABLE, FREQ, TIME_PERIOD, REPORTING, PARTNER, DIRECTION, AGE, ADJUST) == TRUE)

cf <- confront(REPdat, rule, ref = reftab, raise="all") 

out <- as.data.frame(cf)
expect_equal(out$value, c(TRUE, TRUE, FALSE))

out <- REP(coverage="Only",keyTable = reftab
    , TABLE       = REPdat$TABLE
    , FREQ        = REPdat$FREQ
    , TIME_PERIOD = REPdat$TIME_PERIOD
    , REPORTING   = REPdat$REPORTING
    , PARTNER     = REPdat$PARTNER
    , DIRECTION   = REPdat$DIRECTION
    , AGE         = REPdat$AGE
    , ADJUST      = REPdat$ADJUST )

expect_equal(out, c(TRUE, TRUE, FALSE))


