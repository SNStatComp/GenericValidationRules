library(validate)

data(VIRdat)

rules <- validator( VIR(OBS_VALUE, Min=1) == TRUE )
cf <- confront(VIRdat, rules, raise="all")
out <- as.data.frame(cf)
expect_equal(out$value, c(FALSE, FALSE, TRUE, TRUE))


