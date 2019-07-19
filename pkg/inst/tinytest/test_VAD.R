library(validate)
#source("../../R/VAD.R")

# Test data:
#dat <- read.csv('data/VAD.csv')
#ht_age_groups <- read.csv('data/HT_AGE_GROUPS.csv')

data(VADdat)
data(HT_AGE_GROUPSdat)

# Example in par 4.3.6 of ESTAT doc:
rule <- validator(VAD(data=., field='AGE', aggregate_code='TOTAL', operator='='
  , tolerance='0.01', ref=refdata) == TRUE)
cf <- confront(VADdat, rule, ref=list(refdata=HT_AGE_GROUPSdat))

summary(cf)
out <- as.data.frame(cf)

expect_equal(out$value, c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE))
