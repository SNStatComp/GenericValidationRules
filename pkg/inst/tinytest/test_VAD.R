library(validate)
source("../../R/VAD.R")

# Test data:
dat <- read.csv('data/VAD.csv')
ref <- read.csv('data/HT_AGE_GROUPS.csv')

# Example in par 4.3.6 of ESTAT doc:
rule <- validator(VAD(data=dat, field='AGE', aggregate_code='TOTAL', operator='=', tolerance='0.01') == TRUE)
cf <- confront(dat, rule, ref=ref)

summary(cf)
out <- as.data.frame(cf)

expect_equal(out$value, c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE))
