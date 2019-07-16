library(validate)
voptions(raise="all")

dat <- read.csv("data/RWD.csv")

rules <- validator( 
  RWD(TABLE, FREQ, TIME_PERIOD, REPORTING, PARTNER, DIRECTION, AGE, ADJUST) == TRUE )


cf <- confront(dat, rules)
out <- as.data.frame(cf)
expect_equal(out$value,c(TRUE, TRUE, FALSE, FALSE, TRUE))


rules <- validator( 
  RWD2(TABLE, FREQ, TIME_PERIOD, REPORTING, PARTNER, DIRECTION, AGE, ADJUST) == TRUE )

cf <- confront(dat, rules)
out <- as.data.frame(cf)
expect_equal(out$value, FALSE)

