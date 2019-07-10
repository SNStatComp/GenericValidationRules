library(validate)
source("R/FDL.R")

# Test data:
dat <- read.csv('data/FDL.csv')

# Example of good and bad data on par 4.2.2 of ESTAT doc
rule <- validator(FDL(PARTNER, min=2, max=4) == TRUE)
cf <- confront(dat, rule)
summary(cf)
as.data.frame(cf)
