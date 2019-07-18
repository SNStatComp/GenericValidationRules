library(validate)
source("../../R/REP.R")

# Test data:
dat <- read.csv('data/REP.csv')
ref <- data.frame('ADJUST'=c("S", "N"))

# Example in par 4.3.1 of ESTAT doc:
rule <- validator(REP(coverage="Only",TABLE, FREQ, TIME_PERIOD, REPORTING, PARTNER, DIRECTION, AGE, ADJUST) == TRUE)
cf <- confront(dat, rule, ref=ref)

summary(cf)
out <- as.data.frame(cf)

expect_equal(out$value, c(TRUE, TRUE, FALSE))
