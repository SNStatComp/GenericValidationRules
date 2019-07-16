library(validate)
voptions(raise="all")

dat <- read.csv("data/RTS.csv")


rules <- validator(
  RTS(TIME_PERIOD, ftp = "2008", ltp = "2010"
    , TABLE, FREQ, REPORTING, PARTNER, DIRECTION, AGE, ADJUST) == TRUE
)

cf <- confront(dat, rules)
out <- as.data.frame(cf)

expect_equal(out$value, c(TRUE, TRUE, TRUE, FALSE, FALSE, FALSE))




