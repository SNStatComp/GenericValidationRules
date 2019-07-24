library(validate)


data(RTSdat)

rules <- validator(
  RTS(TIME_PERIOD, ftp = "2008", ltp = "2010"
    , TABLE, FREQ, REPORTING, PARTNER, DIRECTION, AGE, ADJUST) == TRUE
)

cf <- confront(RTSdat, rules, raise="all")
out <- as.data.frame(cf)

expect_equal(out$value, c(TRUE, TRUE, TRUE, FALSE, FALSE, FALSE))

expect_equal(GenericValidationRules:::period_type("2018-Q2"),"quarterly")
expect_equal(GenericValidationRules:::period_to_int("2018-Q2", from="quarterly"),8073)



