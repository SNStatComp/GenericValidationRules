library(validate)
#source("../../R/COV.R")

# Test data:
dat <- read.csv('data/COV.csv')

# Example in par 4.2.4 of ESTAT doc:
rule <- validator(COV(DIRECTION, codelistTable="data/COV_CL_DIRECTION.csv") == TRUE)
cf <- confront(dat, rule)
summary(cf)
out <- as.data.frame(cf)

expect_equal(out$value, c(TRUE,FALSE, TRUE, TRUE))

# Test case for case 2:
rule <- validator(COV(DIRECTION, codelist=c("IN", "OUT")) == TRUE)
cf <- confront(dat, rule)
summary(cf)
out <- as.data.frame(cf)

expect_equal(out$value, c(TRUE,FALSE, TRUE, TRUE))
