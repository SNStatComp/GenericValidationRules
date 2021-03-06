library(validate)

data(RWDdat)

rules <- validator( 
  RWD(TABLE, FREQ, TIME_PERIOD, REPORTING, PARTNER, DIRECTION, AGE, ADJUST) == TRUE )


cf <- confront(RWDdat, rules, raise="all")
out <- as.data.frame(cf)
expect_equal(out$value,c(TRUE, TRUE, FALSE, FALSE, TRUE))


rules <- validator( 
  RWD2(TABLE, FREQ, TIME_PERIOD, REPORTING, PARTNER, DIRECTION, AGE, ADJUST) == TRUE )

cf <- confront(RWDdat, rules,raise="all")
out <- as.data.frame(cf)
expect_equal(out$value, FALSE)

