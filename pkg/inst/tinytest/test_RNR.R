library(validate)
#source("../../R/COV.R")

# Test data:
dat <- read.csv('data/RNR.csv')

# Example in par 4.2.4 of ESTAT doc:
rule <- validator(RNR(., min=4) == TRUE)
cf <- confront(dat, rule)
out <- as.data.frame(cf)
expect_equal(out$value, c(FALSE,FALSE, FALSE))


rule <- validator(RNR2(., min=4) == TRUE)
cf <- confront(dat, rule)
out <- as.data.frame(cf)
expect_false(out$value)



