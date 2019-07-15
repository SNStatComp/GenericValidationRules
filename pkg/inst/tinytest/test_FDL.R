library(validate)
#source("pkg/R/FDL.R")

# Test data:
dat <- read.csv('data/FDL.csv')
datDecimals <- read.csv('data/FDL_Decimals.csv')

# Case1: fixed length
rule <- validator(FDL(PARTNER, x=2) == TRUE)
cf <- confront(dat, rule)
summary(cf)
out <- as.data.frame(cf)

expect_equal(out$value, c(TRUE, FALSE, FALSE, FALSE))



# Case2: min max
rule <- validator(FDL(PARTNER, min=2, max=4) == TRUE)
cf <- confront(dat, rule)
summary(cf)
out <- as.data.frame(cf)
expect_equal(out$value, c(TRUE, FALSE, FALSE, TRUE))

# Case 3: also check decimals:
datDecimals <- read.csv('data/FDL_Decimals.csv')
rule <- validator(FDL(OBS_VALUE, min=1, max=10, minDec=2, maxDec=3) == TRUE)
cf <- confront(datDecimals, rule)
summary(cf)
out <- as.data.frame(cf)

expect_equal(out$value, c(TRUE, FALSE, FALSE, TRUE))

