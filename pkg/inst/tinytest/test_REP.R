library(validate)
voptions(raise="all")
#source("pkg/R/REP.R")
# Test data:
dat <- read.csv('data/REP.csv')
reftab <- data.frame(ADJUST=c("S", "N"))

# Example in par 4.3.1 of ESTAT doc:
rule <- validator(REP(coverage="Only", keyTable=ref
    ,TABLE, FREQ, TIME_PERIOD, REPORTING, PARTNER, DIRECTION, AGE, ADJUST) == TRUE)

cf <- confront(dat, rule, ref = reftab) 

out <- as.data.frame(cf)
expect_equal(out$value, c(TRUE, TRUE, FALSE))

out <- REP(coverage="Only",keyTable = reftab
    , TABLE       = dat$TABLE
    , FREQ        = dat$FREQ
    , TIME_PERIOD = dat$TIME_PERIOD
    , REPORTING   = dat$REPORTING
    , PARTNER     = dat$PARTNER
    , DIRECTION   = dat$DIRECTION
    , AGE         = dat$AGE
    , ADJUST      = dat$ADJUST )

expect_equal(out, c(TRUE, TRUE, FALSE))


