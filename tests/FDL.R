library(validate)
source("R/FDL.R")

# Test data:
dat <- read.csv('data/FDL.csv')

# Example case1: fixed length
rule <- validator(FDL(PARTNER, x=2) == TRUE)
cf <- confront(dat, rule)
summary(cf)
as.data.frame(cf)

# Example case2: min max
rule <- validator(FDL(PARTNER, min=2, max=4) == TRUE)
cf <- confront(dat, rule)
summary(cf)
as.data.frame(cf)
