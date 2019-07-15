library(validate)

dat <- read.csv("data/RWD.csv")

rules <- validator( 
  RWD(TABLE, FREQ, TIME_PERIOD, REPORTING, PARTNER, DIRECTION, AGE, ADJUST) == TRUE )


cf <- confront(dat, rules)
out <- as.data.frame(cf)
expect_false(out$value)


all_keys <- c("TABLE", "FREQ", "TIME_PERIOD"
  , "REPORTING", "PARTNER", "DIRECTION", "AGE", "ADJUST")

rules <- validator( RWD(keys=all_keys) == TRUE)
cf <- confront(dat, rules)
out <- as.data.frame(cf)
expect_false(out$value)

